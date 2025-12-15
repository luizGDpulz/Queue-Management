-- 0001_initial_down.sql
SET FOREIGN_KEY_CHECKS=0;
USE `queue_system`;

DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS queue_entries;
DROP TABLE IF EXISTS queues;
DROP TABLE IF EXISTS professionals;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS establishments;
DROP TABLE IF EXISTS users;

DROP DATABASE IF EXISTS `queue_system`;
SET FOREIGN_KEY_CHECKS=1;
