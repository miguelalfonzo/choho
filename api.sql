-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para api
CREATE DATABASE IF NOT EXISTS `api` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish2_ci */;
USE `api`;

-- Volcando estructura para tabla api.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `first_surname` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `second_surname` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `dni` char(8) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `home_address` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ubigeo` char(6) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `updated_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- Volcando datos para la tabla api.customers: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`id`, `name`, `first_surname`, `second_surname`, `dni`, `home_address`, `ubigeo`, `email`, `phone`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
	(1, 'pepito', 'gonzales', 'fernandez', '07514845', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'maria', 'angela', 'tucson', '28828822', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;

-- Volcando estructura para tabla api.employees
CREATE TABLE IF NOT EXISTS `employees` (
  `cod_employee` char(10) COLLATE utf8_spanish2_ci NOT NULL DEFAULT '',
  `name` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `first_surname` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `second_surname` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `dni` char(8) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `home_address` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ubigeo` char(6) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `updated_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`cod_employee`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- Volcando datos para la tabla api.employees: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` (`cod_employee`, `name`, `first_surname`, `second_surname`, `dni`, `home_address`, `ubigeo`, `email`, `phone`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
	('c001', 'miguel', 'alfonzo', 'hernandez', '73570379', 'los olivos , av palmeras', NULL, 'miguel_94_14@outlook.com', '986313520', NULL, NULL, NULL, NULL),
	('c002', 'claudia', 'alfonzo', 'hernandez', '73570375', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;

-- Volcando estructura para procedimiento api.list_orders_details_employee
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_orders_details_employee`(
	IN `xorder` INT

)
BEGIN

SELECT t1.id_product , t2.description ,t1.quantity , t1.unit_price ,t1.amount

FROM orders_products t1
INNER JOIN products t2 ON t1.id_product = t2.id 

WHERE t1.id_order = xorder;
END//
DELIMITER ;

-- Volcando estructura para procedimiento api.list_orders_employee
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_orders_employee`(
	IN `xcod_employee` CHAR(10)















)
BEGIN


SELECT 
		t2.cod_employee,
		CONCAT(t2.name,' ',t2.first_surname,' ',t2.second_surname) AS name_employee,
		t1.id AS id_order,
		t6.description AS status,
		
		t3.id AS id_customer,
		CONCAT(t3.name,' ',t3.first_surname,' ',t3.second_surname) AS name_customer,
	
		(SELECT COUNT(*) FROM orders WHERE id_customer=t1.id_customer ) AS total_orders_customers,
		t1.items AS item_order,
		t1.amount AS amount_order,
		t1.date_payment
	
	
FROM 
orders t1
INNER JOIN employees t2 ON t2.cod_employee=t1.id_employee
INNER JOIN customers t3 ON t3.id = t1.id_customer

INNER JOIN states t6 ON t6.id = t1.id_state
WHERE ( (IFNULL(xcod_employee,'')=''  ) OR (t1.id_employee=xcod_employee) ) ;


END//
DELIMITER ;

-- Volcando estructura para tabla api.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_order` date DEFAULT NULL,
  `date_payment` date DEFAULT NULL,
  `date_deliver` date DEFAULT NULL,
  `amount` decimal(10,4) DEFAULT NULL,
  `items` int(11) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `id_employee` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `id_customer` int(11) DEFAULT NULL,
  `id_state` int(11) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `updated_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_employee` (`id_employee`),
  KEY `order_customer` (`id_customer`),
  KEY `order_state` (`id_state`),
  CONSTRAINT `order_customer` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_employee` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`cod_employee`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_state` FOREIGN KEY (`id_state`) REFERENCES `states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- Volcando datos para la tabla api.orders: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `date_order`, `date_payment`, `date_deliver`, `amount`, `items`, `description`, `id_employee`, `id_customer`, `id_state`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
	(1, '2022-06-19', '2022-06-19', '2022-06-19', 25400.0000, 7, 'order de prueba', 'c001', 1, 1, NULL, NULL, NULL, NULL),
	(2, '2022-06-19', '2022-06-19', '2022-06-19', 100.0000, 1, 'segunda ordern', 'c001', 1, 2, NULL, NULL, NULL, NULL),
	(3, '2022-06-19', '2022-06-19', '2022-06-19', 20.0000, 1, 'tercera orden', 'c001', 2, 2, NULL, NULL, NULL, NULL),
	(4, '2022-06-19', '2022-06-19', '2022-06-19', 50.0000, 1, 'cuarta order', 'c002', 1, 2, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Volcando estructura para tabla api.orders_products
CREATE TABLE IF NOT EXISTS `orders_products` (
  `id_product` int(11) NOT NULL,
  `id_order` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unit_price` decimal(10,4) DEFAULT NULL,
  `amount` decimal(10,4) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `updated_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id_product`,`id_order`),
  KEY `order_producto_id_order` (`id_order`),
  CONSTRAINT `order_producto_id_order` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_producto_id_product` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- Volcando datos para la tabla api.orders_products: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` (`id_product`, `id_order`, `quantity`, `unit_price`, `amount`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
	(1, 1, 5, 5000.0000, 25000.0000, NULL, NULL, NULL, NULL),
	(1, 2, 1, 100.0000, 100.0000, NULL, NULL, NULL, NULL),
	(1, 4, 1, 50.0000, 50.0000, NULL, NULL, NULL, NULL),
	(2, 1, 2, 200.0000, 400.0000, NULL, NULL, NULL, NULL),
	(2, 3, 1, 20.0000, 20.0000, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;

-- Volcando estructura para tabla api.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `unit_price` decimal(10,4) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `updated_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- Volcando datos para la tabla api.products: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `description`, `unit_price`, `stock`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
	(1, 'baterias', NULL, 100, '2021-06-19', '2022-06-19', NULL, NULL),
	(2, 'cadenas', NULL, 80, '2022-06-19', '2022-06-19', NULL, NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Volcando estructura para tabla api.states
CREATE TABLE IF NOT EXISTS `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `updated_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- Volcando datos para la tabla api.states: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` (`id`, `description`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
	(1, 'pagado', NULL, NULL, NULL, NULL),
	(2, 'pendiente', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `states` ENABLE KEYS */;

-- Volcando estructura para tabla api.tokens
CREATE TABLE IF NOT EXISTS `tokens` (
  `token` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `date_expiration` date NOT NULL,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `updated_by` char(10) COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- Volcando datos para la tabla api.tokens: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` (`token`, `date_expiration`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
	('49319d1dbd60d6a141640d44a2d665edf5b0b1bb', '2025-06-19', '2022-06-19', NULL, NULL, NULL);
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;

-- Volcando estructura para procedimiento api.verify_token_api
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `verify_token_api`(
	IN `xtoken` VARCHAR(100)


)
BEGIN
	
	DECLARE v_token VARCHAR(100) DEFAULT NULL;
	DECLARE v_expiration DATE DEFAULT NULL;
   
    SELECT token , date_expiration
    INTO v_token ,v_expiration
    FROM tokens
	 WHERE token = xtoken;
    
    
    
    IF (v_token IS NULL) THEN 
		
		SELECT 'ERROR' AS STATUS ,'THE TOKEN DOES NOT EXIST' AS DESCRIPTION;
		
	ELSE 
	
		IF (v_expiration >= CURDATE())THEN
			
			SELECT 'OK' AS STATUS ,'CONFIRMED TOKEN' AS DESCRIPTION;
			
			
		ELSE
			
			SELECT 'ERROR' AS STATUS ,'THE TOKEN HAS ALREADY EXPIRED' AS DESCRIPTION;
			
		END IF;
		
	END IF;


    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
