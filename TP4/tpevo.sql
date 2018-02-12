-- MySQL dump 10.13  Distrib 5.5.28, for Win64 (x86)
--
-- Host: localhost    Database: tpevo
-- ------------------------------------------------------
-- Server version	5.5.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_425ae3c4` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_5886d21f` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_1bb8f392` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add activite',7,'add_activite'),(20,'Can change activite',7,'change_activite'),(21,'Can delete activite',7,'delete_activite'),(22,'Can add groupe',8,'add_groupe'),(23,'Can change groupe',8,'change_groupe'),(24,'Can delete groupe',8,'delete_groupe'),(25,'Can add athlete',9,'add_athlete'),(26,'Can change athlete',9,'change_athlete'),(27,'Can delete athlete',9,'delete_athlete'),(28,'Can add coach',10,'add_coach'),(29,'Can change coach',10,'change_coach'),(30,'Can delete coach',10,'delete_coach'),(31,'Can add entrainement',11,'add_entrainement'),(32,'Can change entrainement',11,'change_entrainement'),(33,'Can delete entrainement',11,'delete_entrainement'),(34,'Can add mesocycle',12,'add_mesocycle'),(35,'Can change mesocycle',12,'change_mesocycle'),(36,'Can delete mesocycle',12,'delete_mesocycle'),(37,'Can add mesocycle entrainement',13,'add_mesocycleentrainement'),(38,'Can change mesocycle entrainement',13,'change_mesocycleentrainement'),(39,'Can delete mesocycle entrainement',13,'delete_mesocycleentrainement'),(40,'Can add entrainement activite',14,'add_entrainementactivite'),(41,'Can change entrainement activite',14,'change_entrainementactivite'),(42,'Can delete entrainement activite',14,'delete_entrainementactivite'),(43,'Can add entrainement athlete',15,'add_entrainementathlete'),(44,'Can change entrainement athlete',15,'change_entrainementathlete'),(45,'Can delete entrainement athlete',15,'delete_entrainementathlete'),(46,'Can add invitation groupe',16,'add_invitationgroupe'),(47,'Can change invitation groupe',16,'change_invitationgroupe'),(48,'Can delete invitation groupe',16,'delete_invitationgroupe'),(49,'Can add records',17,'add_records'),(50,'Can change records',17,'change_records'),(51,'Can delete records',17,'delete_records'),(52,'Can add log entry',18,'add_logentry'),(53,'Can change log entry',18,'change_logentry'),(54,'Can delete log entry',18,'delete_logentry');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'root','','','root@root.com','pbkdf2_sha256$10000$J1NSHfflq6hJ$cpjUJ0YwJ5xIZsZyrH/uJ9Sh+g3vCOjAATQNQoW9YdY=',1,1,1,'2012-12-20 03:17:39','2012-12-20 03:17:39'),(2,'PHT4-HINX-ADYA-96I6','','','csg@csg.com','pbkdf2_sha256$10000$aDB40V7nVAYi$pGgWy//C9S1bPwv0tNl6iq1V1tMIzzREMCUczz78jqg=',0,1,0,'2012-12-20 03:21:10','2012-12-20 03:20:37'),(3,'E2KJ-PDG4-9HUK-3ISC','','','asg@asg.com','pbkdf2_sha256$10000$Em2rgFAuHxl1$eFXqXpck3INe8ExbiSxRRxMlCFLILsHPNyBXpVBNwKs=',0,1,0,'2012-12-20 03:23:04','2012-12-20 03:22:36'),(4,'BQ0A-XE66-WM3N-SJU4','','','cag@cag.com','pbkdf2_sha256$10000$XPcGrb0ViKC2$PxlgxSNgGO8scMJXAoiKn9PKsxkCdDUwIsl+FamCz18=',0,1,0,'2012-12-20 03:35:45','2012-12-20 03:24:53'),(5,'IUHA-KJQT-1LHC-MDSU','','','aag@aag.com','pbkdf2_sha256$10000$GF1Y75sjj1zR$BP37xrDK35y303yyytZpyCX7b9n61BcxfUhLt8dIweE=',0,1,0,'2012-12-20 03:41:44','2012-12-20 03:25:24'),(6,'RAF9-HME5-7WVG-IPKF','','','aig@aig.com','pbkdf2_sha256$10000$kyClshhc3kQQ$Gam1dOmTk34FAN93tIcpXTW4BXptJLedDSKFZ6JkDYk=',0,1,0,'2012-12-20 03:33:05','2012-12-20 03:26:31');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_403f60f` (`user_id`),
  KEY `auth_user_groups_425ae3c4` (`group_id`),
  CONSTRAINT `user_id_refs_id_7ceef80f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `group_id_refs_id_f116770` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_403f60f` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `user_id_refs_id_dfbab7d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_403f60f` (`user_id`),
  KEY `django_admin_log_1bb8f392` (`content_type_id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'activite','training','activite'),(8,'groupe','training','groupe'),(9,'athlete','training','athlete'),(10,'coach','training','coach'),(11,'entrainement','training','entrainement'),(12,'mesocycle','training','mesocycle'),(13,'mesocycle entrainement','training','mesocycleentrainement'),(14,'entrainement activite','training','entrainementactivite'),(15,'entrainement athlete','training','entrainementathlete'),(16,'invitation groupe','training','invitationgroupe'),(17,'records','training','records'),(18,'log entry','admin','logentry');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_3da3d3d8` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_activite`
--

DROP TABLE IF EXISTS `training_activite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_activite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `duree` time DEFAULT NULL,
  `distance` smallint(5) unsigned DEFAULT NULL,
  `VAM` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_activite`
--

LOCK TABLES `training_activite` WRITE;
/*!40000 ALTER TABLE `training_activite` DISABLE KEYS */;
INSERT INTO `training_activite` VALUES (3,'Course',NULL,200,105),(4,'Repos','00:02:00',NULL,105),(5,'Course',NULL,400,100),(6,'Repos','00:01:00',NULL,NULL),(7,'Course',NULL,600,90),(8,'Repos','00:01:30',NULL,NULL),(9,'Course',NULL,800,85),(10,'Repos','00:02:00',NULL,NULL),(11,'Course',NULL,NULL,70);
/*!40000 ALTER TABLE `training_activite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_athlete`
--

DROP TABLE IF EXISTS `training_athlete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_athlete` (
  `user_id` int(11) NOT NULL,
  `nom` varchar(60) NOT NULL,
  `groupe_id` int(11) DEFAULT NULL,
  `VAM` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `training_athlete_2a600088` (`groupe_id`),
  CONSTRAINT `user_id_refs_id_4a778c22` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `groupe_id_refs_id_5ad94dd` FOREIGN KEY (`groupe_id`) REFERENCES `training_groupe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_athlete`
--

LOCK TABLES `training_athlete` WRITE;
/*!40000 ALTER TABLE `training_athlete` DISABLE KEYS */;
INSERT INTO `training_athlete` VALUES (2,'Coach sans groupe',NULL,1),(3,'Athlète sans groupe',NULL,1),(4,'Coach avec groupe',1,1),(5,'Athlète avec groupe',1,1),(6,'Athlète invité à un groupe',NULL,1);
/*!40000 ALTER TABLE `training_athlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_coach`
--

DROP TABLE IF EXISTS `training_coach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_coach` (
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_id_refs_user_id_39142ef6` FOREIGN KEY (`user_id`) REFERENCES `training_athlete` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_coach`
--

LOCK TABLES `training_coach` WRITE;
/*!40000 ALTER TABLE `training_coach` DISABLE KEYS */;
INSERT INTO `training_coach` VALUES (2),(4);
/*!40000 ALTER TABLE `training_coach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_entrainement`
--

DROP TABLE IF EXISTS `training_entrainement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_entrainement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(60) NOT NULL,
  `repetition` smallint(5) unsigned DEFAULT NULL,
  `series` smallint(5) unsigned DEFAULT NULL,
  `repos` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_entrainement`
--

LOCK TABLES `training_entrainement` WRITE;
/*!40000 ALTER TABLE `training_entrainement` DISABLE KEYS */;
INSERT INTO `training_entrainement` VALUES (1,'10 10',10,3,'00:03:00'),(2,'erwer',NULL,NULL,NULL),(3,'sfsdf',NULL,NULL,NULL);
/*!40000 ALTER TABLE `training_entrainement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_entrainementactivite`
--

DROP TABLE IF EXISTS `training_entrainementactivite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_entrainementactivite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entrainement_id` int(11) NOT NULL,
  `activite_id` int(11) NOT NULL,
  `ordre` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `training_entrainementactivite_7a48de6` (`entrainement_id`),
  KEY `training_entrainementactivite_1e8a621d` (`activite_id`),
  CONSTRAINT `entrainement_id_refs_id_3d207334` FOREIGN KEY (`entrainement_id`) REFERENCES `training_entrainement` (`id`),
  CONSTRAINT `activite_id_refs_id_2b5a2625` FOREIGN KEY (`activite_id`) REFERENCES `training_activite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_entrainementactivite`
--

LOCK TABLES `training_entrainementactivite` WRITE;
/*!40000 ALTER TABLE `training_entrainementactivite` DISABLE KEYS */;
INSERT INTO `training_entrainementactivite` VALUES (1,1,3,1),(2,1,4,2),(3,2,5,1),(4,2,6,2),(5,2,7,3),(6,2,8,4),(7,2,9,5),(8,2,10,6),(9,3,11,1);
/*!40000 ALTER TABLE `training_entrainementactivite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_entrainementathlete`
--

DROP TABLE IF EXISTS `training_entrainementathlete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_entrainementathlete` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seance_id` int(11) NOT NULL,
  `athlete_id` int(11) NOT NULL,
  `fait` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `training_entrainementathlete_25f186db` (`seance_id`),
  KEY `training_entrainementathlete_788f681a` (`athlete_id`),
  CONSTRAINT `seance_id_refs_id_65c9d750` FOREIGN KEY (`seance_id`) REFERENCES `training_mesocycleentrainement` (`id`),
  CONSTRAINT `athlete_id_refs_user_id_28d7f431` FOREIGN KEY (`athlete_id`) REFERENCES `training_athlete` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_entrainementathlete`
--

LOCK TABLES `training_entrainementathlete` WRITE;
/*!40000 ALTER TABLE `training_entrainementathlete` DISABLE KEYS */;
INSERT INTO `training_entrainementathlete` VALUES (1,1,5,0),(2,2,5,0),(3,3,5,0),(4,4,5,0),(5,5,5,0),(6,6,5,0),(7,7,5,0),(8,8,5,0),(9,9,5,0),(10,10,5,0),(11,11,5,0),(12,12,5,0),(13,13,5,0);
/*!40000 ALTER TABLE `training_entrainementathlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_groupe`
--

DROP TABLE IF EXISTS `training_groupe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_groupe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `coach_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coach_id` (`coach_id`),
  CONSTRAINT `coach_id_refs_user_id_2d8a8ab6` FOREIGN KEY (`coach_id`) REFERENCES `training_coach` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_groupe`
--

LOCK TABLES `training_groupe` WRITE;
/*!40000 ALTER TABLE `training_groupe` DISABLE KEYS */;
INSERT INTO `training_groupe` VALUES (1,'Les vrais pros',4);
/*!40000 ALTER TABLE `training_groupe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_invitationgroupe`
--

DROP TABLE IF EXISTS `training_invitationgroupe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_invitationgroupe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `courriel` varchar(45) NOT NULL,
  `groupe_id` int(11) NOT NULL,
  `date_envoi` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `training_invitationgroupe_2a600088` (`groupe_id`),
  CONSTRAINT `user_id_refs_user_id_4a4e24f2` FOREIGN KEY (`user_id`) REFERENCES `training_athlete` (`user_id`),
  CONSTRAINT `groupe_id_refs_id_799d3fb0` FOREIGN KEY (`groupe_id`) REFERENCES `training_groupe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_invitationgroupe`
--

LOCK TABLES `training_invitationgroupe` WRITE;
/*!40000 ALTER TABLE `training_invitationgroupe` DISABLE KEYS */;
INSERT INTO `training_invitationgroupe` VALUES (2,6,'',1,'2012-12-20 03:32:26');
/*!40000 ALTER TABLE `training_invitationgroupe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_mesocycle`
--

DROP TABLE IF EXISTS `training_mesocycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_mesocycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `periode` date NOT NULL,
  `groupe_id` int(11) NOT NULL,
  `public` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `training_mesocycle_2a600088` (`groupe_id`),
  CONSTRAINT `groupe_id_refs_id_5f5ce0ac` FOREIGN KEY (`groupe_id`) REFERENCES `training_groupe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_mesocycle`
--

LOCK TABLES `training_mesocycle` WRITE;
/*!40000 ALTER TABLE `training_mesocycle` DISABLE KEYS */;
INSERT INTO `training_mesocycle` VALUES (1,'Décembre 2012','2012-12-01',1,1);
/*!40000 ALTER TABLE `training_mesocycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_mesocycleentrainement`
--

DROP TABLE IF EXISTS `training_mesocycleentrainement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_mesocycleentrainement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entrainement_id` int(11) NOT NULL,
  `mesocycle_id` int(11) NOT NULL,
  `jour` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `training_mesocycleentrainement_7a48de6` (`entrainement_id`),
  KEY `training_mesocycleentrainement_4846fc65` (`mesocycle_id`),
  CONSTRAINT `mesocycle_id_refs_id_5b47a867` FOREIGN KEY (`mesocycle_id`) REFERENCES `training_mesocycle` (`id`),
  CONSTRAINT `entrainement_id_refs_id_653fcf3c` FOREIGN KEY (`entrainement_id`) REFERENCES `training_entrainement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_mesocycleentrainement`
--

LOCK TABLES `training_mesocycleentrainement` WRITE;
/*!40000 ALTER TABLE `training_mesocycleentrainement` DISABLE KEYS */;
INSERT INTO `training_mesocycleentrainement` VALUES (1,3,1,'2012-12-12'),(2,2,1,'2012-12-10'),(3,3,1,'2012-12-17'),(4,1,1,'2012-12-14'),(5,1,1,'2012-12-19'),(6,2,1,'2012-12-31'),(7,1,1,'2012-12-03'),(8,2,1,'2012-12-05'),(9,3,1,'2012-12-07'),(10,1,1,'2012-12-28'),(11,2,1,'2012-12-21'),(12,3,1,'2012-12-26'),(13,1,1,'2012-12-24');
/*!40000 ALTER TABLE `training_mesocycleentrainement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `training_records`
--

DROP TABLE IF EXISTS `training_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `training_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `athlete_id` int(11) NOT NULL,
  `activite_id` int(11) NOT NULL,
  `duree` time DEFAULT NULL,
  `distance` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `training_records_788f681a` (`athlete_id`),
  KEY `training_records_1e8a621d` (`activite_id`),
  CONSTRAINT `athlete_id_refs_user_id_1cf897b4` FOREIGN KEY (`athlete_id`) REFERENCES `training_athlete` (`user_id`),
  CONSTRAINT `activite_id_refs_id_70f2ad23` FOREIGN KEY (`activite_id`) REFERENCES `training_activite` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `training_records`
--

LOCK TABLES `training_records` WRITE;
/*!40000 ALTER TABLE `training_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `training_records` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-12-19 22:47:36
