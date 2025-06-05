-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital_db
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_department_id` int DEFAULT NULL,
  `hospital_id` int NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital_id` (`hospital_id`),
  KEY `parent_department_id` (`parent_department_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`id`) ON DELETE CASCADE,
  CONSTRAINT `departments_ibfk_2` FOREIGN KEY (`parent_department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Emergency Medicine',NULL,1,'Handles medical emergencies and trauma cases.'),(2,'Internal Medicine',NULL,1,'Focuses on diagnosis and non-surgical treatment of diseases in adults.'),(3,'General Surgery',NULL,1,'Performs various surgical procedures for different conditions.'),(4,'Cardiology',NULL,1,'Specializes in heart-related diseases and treatments.'),(5,'Neurology',NULL,1,'Deals with disorders of the nervous system, including the brain and spinal cord.'),(6,'Orthopedics',NULL,1,'Focuses on bone, joint, and muscle-related issues.'),(7,'Pediatrics',NULL,1,'Provides medical care for infants, children, and adolescents.'),(8,'Oncology',NULL,1,'Deals with the diagnosis and treatment of cancer.'),(9,'Nephrology',NULL,1,'Focuses on kidney-related diseases and dialysis treatment.'),(10,'Gastroenterology',NULL,1,'Deals with digestive system disorders, including liver and pancreas.');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `experience` int DEFAULT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Dr. John Doe','MBBS, MD','Emergency Medicine',10,1),(2,'Dr. Alice Smith','MBBS, MS','Trauma Surgery',8,1),(3,'Dr. Robert Brown','MBBS, MD','Critical Care',12,1),(4,'Dr. Jane Williams','MBBS, DM','Emergency Medicine',7,1),(6,'Dr. Michael Carter','MBBS, MD','General Internal Medicine',12,2),(7,'Dr. Sarah Thompson','MBBS, MD','Endocrinology',10,2),(8,'Dr. James Wilson','MBBS, DM','Pulmonology',9,2),(9,'Dr. Rachel Adams','MBBS, MD','Geriatric Medicine',11,2),(10,'Dr. Eric Johnson','MBBS, MD','Hematology',8,2),(11,'Dr. Thomas Anderson','MBBS, MS','General Surgery',15,3),(12,'Dr. Sophia White','MBBS, MS','Laparoscopic Surgery',12,3),(13,'Dr. Daniel Brown','MBBS, MCh','Gastrointestinal Surgery',10,3),(14,'Dr. Olivia Turner','MBBS, MS','Onco-Surgery',9,3),(15,'Dr. Christopher Evans','MBBS, MS','Hepatobiliary Surgery',14,3),(16,'Dr. Henry Adams','MBBS, MD, DM','Interventional Cardiology',15,4),(17,'Dr. Susan Clark','MBBS, MD','Electrophysiology',12,4),(18,'Dr. William Lee','MBBS, DM','Heart Failure & Transplantation',10,4),(19,'Dr. Mary Scott','MBBS, MD','Pediatric Cardiology',11,4),(20,'Dr. Thomas Walker','MBBS, MD','Cardiac Imaging',14,4),(21,'Dr. Robert Harrison','MBBS, MD, DM','Neurophysiology',16,5),(22,'Dr. Emily Watson','MBBS, DM','Stroke and Cerebrovascular Diseases',13,5),(23,'Dr. Daniel Morris','MBBS, MD','Epileptology',11,5),(24,'Dr. Olivia Bennett','MBBS, DM','Neurodegenerative Disorders',12,5),(25,'Dr. Jonathan Reed','MBBS, MD','Movement Disorders',14,5),(26,'Dr. Andrew Miller','MBBS, MS','Spine Surgery',18,6),(27,'Dr. Laura Anderson','MBBS, MS','Joint Replacement Surgery',15,6),(28,'Dr. David Thompson','MBBS, MCh','Sports Medicine',13,6),(29,'Dr. Jessica Wilson','MBBS, MS','Pediatric Orthopedics',12,6),(30,'Dr. Samuel Harris','MBBS, MS','Trauma & Fracture Surgery',14,6),(31,'Dr. Sarah Williams','MBBS, MD','Neonatology',14,7),(32,'Dr. James Anderson','MBBS, MD','Pediatric Pulmonology',12,7),(33,'Dr. Olivia Clarke','MBBS, MD','Pediatric Cardiology',10,7),(34,'Dr. Benjamin Scott','MBBS, MD','Pediatric Gastroenterology',13,7),(35,'Dr. Emily Ross','MBBS, MD','Pediatric Neurology',15,7),(36,'Dr. Richard Bennett','MBBS, MD, DM','Medical Oncology',15,8),(37,'Dr. Laura White','MBBS, MD','Radiation Oncology',12,8),(38,'Dr. Daniel Scott','MBBS, MCh','Surgical Oncology',14,8),(39,'Dr. Olivia Turner','MBBS, MD','Pediatric Oncology',11,8),(40,'Dr. Christopher Evans','MBBS, MD','Hematologic Oncology',10,8),(41,'Dr. Robert Hamilton','MBBS, MD, DM','Kidney Transplant Specialist',16,9),(42,'Dr. Sarah Lawson','MBBS, MD','Dialysis & Renal Failure',14,9),(43,'Dr. James Turner','MBBS, DM','Pediatric Nephrology',12,9),(44,'Dr. Emily Scott','MBBS, MD','Glomerular Diseases',11,9),(45,'Dr. Christopher Adams','MBBS, MD','Hypertension & Kidney Health',13,9),(46,'Dr. William Thompson','MBBS, MD, DM','Hepatology & Liver Diseases',17,10),(47,'Dr. Sophia Anderson','MBBS, MD','Endoscopic Surgery',15,10),(48,'Dr. Daniel Carter','MBBS, DM','Inflammatory Bowel Disease',12,10),(49,'Dr. Olivia Brown','MBBS, MD','Pancreatic Disorders',14,10),(50,'Dr. Benjamin Foster','MBBS, MD','Gastrointestinal Oncology',13,10),(53,'Kavan Anselm A','MBBS','Heart surgeon',10,6),(54,'Kavan Anselm A','MBBS','Heart surgeon',10,6),(57,'Harish','B.Sc Nursing ','Heart Surgeon',4,1);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `established_year` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
INSERT INTO `hospital` VALUES (1,'City General Hospital','Downtown, New York',1990);
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  `experience` int DEFAULT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `nurses_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
INSERT INTO `nurses` VALUES (1,'Nurse Emma Watson','B.Sc Nursing',8,1),(2,'Nurse Olivia Brown','Diploma in Nursing',10,1),(3,'Nurse Liam Jackson','B.Sc Nursing',7,1),(4,'Nurse Sophia White','Diploma in Nursing',5,1),(5,'Nurse Noah Roberts','B.Sc Nursing',6,1),(6,'Nurse Jessica Parker','B.Sc Nursing',10,2),(7,'Nurse Benjamin Clark','Diploma in Nursing',9,2),(8,'Nurse Laura Mitchell','B.Sc Nursing',8,2),(9,'Nurse Samuel Carter','Diploma in Nursing',7,2),(10,'Nurse Emily Ross','B.Sc Nursing',6,2),(11,'Nurse Anna Richardson','B.Sc Nursing',11,3),(12,'Nurse William Scott','Diploma in Nursing',9,3),(13,'Nurse Emma Harris','B.Sc Nursing',10,3),(14,'Nurse Henry Wilson','Diploma in Nursing',8,3),(15,'Nurse Grace Thompson','B.Sc Nursing',7,3),(16,'Nurse Ava Mitchell','B.Sc Nursing',12,4),(17,'Nurse Elijah Carter','Diploma in Nursing',11,4),(18,'Nurse Mia Lewis','B.Sc Nursing',10,4),(19,'Nurse Lucas Evans','Diploma in Nursing',9,4),(20,'Nurse Amelia Turner','B.Sc Nursing',8,4),(21,'Nurse Sarah Mitchell','B.Sc Nursing',12,5),(22,'Nurse Ethan Clarke','Diploma in Nursing',11,5),(23,'Nurse Abigail Ross','B.Sc Nursing',10,5),(24,'Nurse Benjamin Lewis','Diploma in Nursing',9,5),(25,'Nurse Charlotte Foster','B.Sc Nursing',8,5),(26,'Nurse Emily Roberts','B.Sc Nursing',13,6),(27,'Nurse William Carter','Diploma in Nursing',12,6),(28,'Nurse Sophia Mitchell','B.Sc Nursing',11,6),(29,'Nurse Noah Adams','Diploma in Nursing',10,6),(30,'Nurse Olivia Parker','B.Sc Nursing',9,6),(31,'Nurse Hannah Carter','B.Sc Nursing',12,7),(32,'Nurse Ethan Mitchell','Diploma in Nursing',11,7),(33,'Nurse Isabella Foster','B.Sc Nursing',10,7),(34,'Nurse Lucas Evans','Diploma in Nursing',9,7),(35,'Nurse Amelia Turner','B.Sc Nursing',8,7),(36,'Nurse Sophia Parker','B.Sc Nursing',13,8),(37,'Nurse William Carter','Diploma in Nursing',12,8),(38,'Nurse Emily Roberts','B.Sc Nursing',11,8),(39,'Nurse Noah Adams','Diploma in Nursing',10,8),(40,'Nurse Olivia Mitchell','B.Sc Nursing',9,8),(41,'Nurse Hannah Richardson','B.Sc Nursing',12,9),(42,'Nurse Ethan Mitchell','Diploma in Nursing',11,9),(43,'Nurse Isabella Foster','B.Sc Nursing',10,9),(44,'Nurse Lucas Evans','Diploma in Nursing',9,9),(45,'Nurse Amelia Turner','B.Sc Nursing',8,9),(46,'Nurse Emily Watson','B.Sc Nursing',13,10),(47,'Nurse James Mitchell','Diploma in Nursing',12,10),(48,'Nurse Charlotte Adams','B.Sc Nursing',11,10),(49,'Nurse Ethan Carter','Diploma in Nursing',10,10),(50,'Nurse Isabella Roberts','B.Sc Nursing',9,10);
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-27 16:58:21
