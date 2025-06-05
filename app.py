from flask import Flask,jsonify,send_from_directory,request
from flask_cors import CORS
from dotenv import load_dotenv
import os
import mysql.connector.pooling

load_dotenv()

app = Flask(__name__, static_folder="react-frontend/build", static_url_path="")
CORS(app)
db_config = {
    "host": os.getenv("DB_HOST"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "database": os.getenv("DB_NAME")
}

# Create MySQL connection pool
try:
    connection_pool = mysql.connector.pooling.MySQLConnectionPool(
        pool_name="mypool",
        pool_size=10,
        **db_config
    )
    print("MySQL Connection Pool created successfully")
except mysql.connector.Error as e:
    print(f"Error creating MySQL Connection Pool: {e}")
    connection_pool = None

def get_db_connection():
    if connection_pool is None:
        print("No connection pool available!")
        return None
    try:
        conn = connection_pool.get_connection()
        conn.ping(reconnect=True)
        return conn
    except mysql.connector.Error as e:
        print(f"Error getting connection from pool: {e}")
        return None

# ----------- ✅ API ROUTES START HERE -----------

@app.route('/hospital', methods=['GET'])
def get_hospital():
    db = get_db_connection()
    if db is None:
        return jsonify({"error": "DB connection failed"}), 500
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT name, location FROM hospital LIMIT 1")
        hospital = cursor.fetchone()
        if not hospital:
            return jsonify({"error": "No hospital found"}), 404
        return jsonify(hospital)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/departments', methods=['GET'])
def get_departments():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id, name, description FROM departments")
        return jsonify(cursor.fetchall())
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/add_department', methods=['POST'])
def add_department():
    data = request.json
    name = data.get('name')
    description = data.get('description')
    hospital_id = 1
    parent_department_id = None

    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("""
            INSERT INTO departments (name, description, hospital_id, parent_department_id)
            VALUES (%s, %s, %s, %s)
        """, (name, description, hospital_id, parent_department_id))
        db.commit()
        return jsonify({"message": "Department added successfully"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/update_department/<int:dept_id>', methods=['PUT'])
def update_department(dept_id):
    data = request.json
    name = data.get('name')
    description = data.get('description')

    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("""
            UPDATE departments SET name = %s, description = %s WHERE id = %s
        """, (name, description, dept_id))
        db.commit()
        return jsonify({"message": "Department updated"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/delete_department/<int:dept_id>', methods=['DELETE'])
def delete_department(dept_id):
    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("DELETE FROM departments WHERE id = %s", (dept_id,))
        db.commit()
        return jsonify({"message": "Department deleted"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/department/<int:dept_id>', methods=['GET'])
def get_department_details(dept_id):
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute("SELECT name, description FROM departments WHERE id = %s", (dept_id,))
        department = cursor.fetchone()

        cursor.execute("SELECT name, specialization, qualification, experience FROM doctors WHERE department_id = %s", (dept_id,))
        doctors = cursor.fetchall()

        cursor.execute("SELECT name, qualification, experience FROM nurses WHERE department_id = %s", (dept_id,))
        nurses = cursor.fetchall()

        return jsonify({"department": department, "doctors": doctors, "nurses": nurses})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/add_doctor', methods=['POST'])
def add_doctor():
    data = request.json
    name = data.get('name')
    specialization = data.get('specialization')
    qualification = data.get('qualification')
    experience = data.get('experience')
    dept_id = data.get('department_id')

    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("""
            INSERT INTO doctors (name, specialization, qualification, experience, department_id)
            VALUES (%s, %s, %s, %s, %s)
        """, (name, specialization, qualification, experience, dept_id))
        db.commit()
        return jsonify({"message": "Doctor added"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/update_doctor', methods=['PUT'])
def update_doctor():
    data = request.json
    name = data.get('name')
    department_id = data.get('department_id')
    specialization = data.get('specialization')
    qualification = data.get('qualification')
    experience = data.get('experience')

    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("""
            UPDATE doctors
            SET specialization = %s, qualification = %s, experience = %s
            WHERE name = %s AND department_id = %s
        """, (specialization, qualification, experience, name, department_id))
        db.commit()
        return jsonify({"message": "Doctor updated"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/delete_doctor/<int:dept_id>/<string:name>', methods=['DELETE'])
def delete_doctor(dept_id, name):
    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("DELETE FROM doctors WHERE department_id = %s AND name = %s", (dept_id, name))
        db.commit()
        return jsonify({"message": "Doctor deleted"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/add_nurse', methods=['POST'])
def add_nurse():
    data = request.json
    name = data.get('name')
    qualification = data.get('qualification')
    experience = data.get('experience')
    dept_id = data.get('department_id')

    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("""
            INSERT INTO nurses (name, qualification, experience, department_id)
            VALUES (%s, %s, %s, %s)
        """, (name, qualification, experience, dept_id))
        db.commit()
        return jsonify({"message": "Nurse added"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/update_nurse', methods=['PUT'])
def update_nurse():
    data = request.json
    name = data.get('name')
    department_id = data.get('department_id')
    qualification = data.get('qualification')
    experience = data.get('experience')

    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("""
            UPDATE nurses
            SET qualification = %s, experience = %s
            WHERE name = %s AND department_id = %s
        """, (qualification, experience, name, department_id))
        db.commit()
        return jsonify({"message": "Nurse updated"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/delete_nurse/<int:dept_id>/<string:name>', methods=['DELETE'])
def delete_nurse(dept_id, name):
    db = get_db_connection()
    cursor = db.cursor()
    try:
        cursor.execute("DELETE FROM nurses WHERE department_id = %s AND name = %s", (dept_id, name))
        db.commit()
        return jsonify({"message": "Nurse deleted"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@app.route('/search', methods=['GET'])
def search():
    query = request.args.get('query', '').strip().lower()
    if not query:
        return jsonify([])

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    results = []

    try:
        cursor.execute("SELECT id, name, description FROM departments")
        for row in cursor.fetchall():
            desc = row['description'] or ''
            if query in desc.lower() or query in (row['name'] or '').lower():
                results.append({
                    "source": "Department",
                    "match": f"{row['name']} — {desc}",
                    "link": f"/department?id={row['id']}"
                })

        cursor.execute("""
            SELECT d.name AS doctor_name, d.specialization, d.qualification, d.experience,
                   d.department_id, dept.name AS department_name
            FROM doctors d
            JOIN departments dept ON d.department_id = dept.id
        """)
        for row in cursor.fetchall():
            if any(query in (str(row[field] or '')).lower() for field in ['doctor_name', 'specialization', 'qualification', 'experience']):
                results.append({
                    "source": "Doctor",
                    "match": f"Dr. {row['doctor_name']} — {row['specialization']} — {row['qualification']} — {row['experience']} years",
                    "link": f"/department?id={row['department_id']}"
                })

        cursor.execute("""
            SELECT n.name AS nurse_name, n.qualification, n.experience,
                   n.department_id, dept.name AS department_name
            FROM nurses n
            JOIN departments dept ON n.department_id = dept.id
        """)
        for row in cursor.fetchall():
            if any(query in (str(row[field] or '')).lower() for field in ['nurse_name', 'qualification', 'experience']):
                results.append({
                    "source": "Nurse",
                    "match": f"{row['nurse_name']} — {row['qualification']} — {row['experience']} years",
                    "link": f"/department?id={row['department_id']}"
                })

        return jsonify(results)

    except Exception as e:
        print("Search error:", e)
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

# ----------- ✅ Serve React Frontend -----------
@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def serve_react(path):
    if path != "" and os.path.exists(os.path.join(app.static_folder, path)):
        return send_from_directory(app.static_folder, path)
    else:
        return send_from_directory(app.static_folder, "index.html")

# ----------- ✅ Run Server -----------
if __name__ == '__main__':
    print("Flask server is running on http://localhost:5001 ...")
    app.run(debug=True, port=5001)
