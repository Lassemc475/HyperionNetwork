/*
Navicat MySQL Data Transfer

Source Server         : ByHyperion - Dedicated
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : vrpfx

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2018-04-29 17:54:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `vrp_srv_data`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_srv_data`;
CREATE TABLE `vrp_srv_data` (
  `dkey` varchar(255) NOT NULL DEFAULT '',
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vrp_srv_data
-- ----------------------------

-- ----------------------------
-- Table structure for `vrp_users`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_users`;
CREATE TABLE `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_login` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `last_date` text COLLATE utf8_danish_ci DEFAULT NULL,
  `whitelisted` tinyint(1) DEFAULT 0,
  `banned` tinyint(1) DEFAULT 0,
  `reason` text CHARACTER SET utf8 DEFAULT '',
  `DmvTest` int(11) DEFAULT 1,
  `freason` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8329 DEFAULT CHARSET=utf8 COLLATE=utf8_danish_ci;

-- ----------------------------
-- Records of vrp_users
-- ----------------------------
-- ----------------------------
-- Table structure for `vrp_user_business`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_user_business`;
CREATE TABLE `vrp_user_business` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(30) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `capital` int(11) DEFAULT 0,
  `laundered` int(11) DEFAULT 0,
  `reset_timestamp` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vrp_user_business
-- ----------------------------

-- ----------------------------
-- Table structure for `vrp_user_data`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_user_data`;
CREATE TABLE `vrp_user_data` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `dkey` varchar(255) NOT NULL DEFAULT '',
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vrp_user_data
-- ----------------------------

-- ----------------------------
-- Table structure for `vrp_user_homes`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_user_homes`;
CREATE TABLE `vrp_user_homes` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `home` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT 0,
  KEY `home` (`home`,`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vrp_user_homes
-- ----------------------------

-- ----------------------------
-- Table structure for `vrp_user_identities`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_user_identities`;
CREATE TABLE `vrp_user_identities` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `registration` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `firstname` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `age` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `registration_UNIQUE` (`registration`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`),
  CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_danish_ci;

-- ----------------------------
-- Records of vrp_user_identities
-- ----------------------------

-- ----------------------------
-- Table structure for `vrp_user_ids`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_user_ids`;
CREATE TABLE `vrp_user_ids` (
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `user_id` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`),
  KEY `fk_user_ids_users` (`user_id`),
  CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vrp_user_ids
-- ----------------------------

-- ----------------------------
-- Table structure for `vrp_user_moneys`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_user_moneys`;
CREATE TABLE `vrp_user_moneys` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `wallet` bigint(20) DEFAULT 0,
  `bank` bigint(20) DEFAULT 0,
  `_log_upd` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vrp_user_moneys
-- ----------------------------

-- ----------------------------
-- Table structure for `vrp_user_vehicles`
-- ----------------------------
DROP TABLE IF EXISTS `vrp_user_vehicles`;
CREATE TABLE `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `vehicle` varchar(255) NOT NULL DEFAULT '',
  `vehicle_name` varchar(255) NOT NULL,
  `vehicle_plate` varchar(15) NOT NULL,
  `veh_type` varchar(255) NOT NULL DEFAULT 'default',
  `vehicle_colorprimary` varchar(255) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(255) DEFAULT NULL,
  `vehicle_pearlescentcolor` varchar(255) DEFAULT NULL,
  `vehicle_wheelcolor` varchar(255) DEFAULT NULL,
  `vehicle_plateindex` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor1` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor2` varchar(255) DEFAULT NULL,
  `vehicle_neoncolor3` varchar(255) DEFAULT NULL,
  `vehicle_windowtint` varchar(255) DEFAULT NULL,
  `vehicle_wheeltype` varchar(255) DEFAULT NULL,
  `vehicle_mods0` varchar(255) DEFAULT NULL,
  `vehicle_mods1` varchar(255) DEFAULT NULL,
  `vehicle_mods2` varchar(255) DEFAULT NULL,
  `vehicle_mods3` varchar(255) DEFAULT NULL,
  `vehicle_mods4` varchar(255) DEFAULT NULL,
  `vehicle_mods5` varchar(255) DEFAULT NULL,
  `vehicle_mods6` varchar(255) DEFAULT NULL,
  `vehicle_mods7` varchar(255) DEFAULT NULL,
  `vehicle_mods8` varchar(255) DEFAULT NULL,
  `vehicle_mods9` varchar(255) DEFAULT NULL,
  `vehicle_mods10` varchar(255) DEFAULT NULL,
  `vehicle_mods11` varchar(255) DEFAULT NULL,
  `vehicle_mods12` varchar(255) DEFAULT NULL,
  `vehicle_mods13` varchar(255) DEFAULT NULL,
  `vehicle_mods14` varchar(255) DEFAULT NULL,
  `vehicle_mods15` varchar(255) DEFAULT NULL,
  `vehicle_mods16` varchar(255) DEFAULT NULL,
  `vehicle_turbo` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_tiresmoke` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_xenon` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_mods23` varchar(255) DEFAULT NULL,
  `vehicle_mods24` varchar(255) DEFAULT NULL,
  `vehicle_neon0` varchar(255) DEFAULT NULL,
  `vehicle_neon1` varchar(255) DEFAULT NULL,
  `vehicle_neon2` varchar(255) DEFAULT NULL,
  `vehicle_neon3` varchar(255) DEFAULT NULL,
  `vehicle_bulletproof` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor1` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor2` varchar(255) DEFAULT NULL,
  `vehicle_smokecolor3` varchar(255) DEFAULT NULL,
  `vehicle_modvariation` varchar(255) NOT NULL DEFAULT 'off',
  `vehicle_price` int(60) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`vehicle_plate`,`vehicle`),
  CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vrp_user_vehicles
-- ----------------------------

-- ----------------------------
-- Table structure for `_log_banstory`
-- ----------------------------
DROP TABLE IF EXISTS `_log_banstory`;
CREATE TABLE `_log_banstory` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `ban_from` int(11) NOT NULL,
  `ban_to` int(11) NOT NULL,
  `ban_reason` varchar(255) NOT NULL,
  `_upd` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of _log_banstory
-- ----------------------------

-- ----------------------------
-- Table structure for `_log_cashflow`
-- ----------------------------
DROP TABLE IF EXISTS `_log_cashflow`;
CREATE TABLE `_log_cashflow` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `cash_type` varchar(45) NOT NULL,
  `cash_start` bigint(20) NOT NULL,
  `cash_move` bigint(20) NOT NULL,
  `cash_end` bigint(20) NOT NULL,
  `_upd` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=302972 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of _log_cashflow
-- ----------------------------

-- ----------------------------
-- Table structure for `_log_user_switch`
-- ----------------------------
DROP TABLE IF EXISTS `_log_user_switch`;
CREATE TABLE `_log_user_switch` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(250) NOT NULL,
  `userid` bigint(20) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `userid_UNIQUE` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of _log_user_switch
-- ----------------------------


-- ----------------------------
-- Table structure for `_log_vehicles`
-- ----------------------------
DROP TABLE IF EXISTS `_log_vehicles`;
CREATE TABLE `_log_vehicles` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `action` varchar(250) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `vehicle` varchar(250) NOT NULL,
  `vehicle_price` bigint(20) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=12402 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _log_vehicles
-- ----------------------------

-- ----------------------------
-- Table structure for `_log_weapons_user`
-- ----------------------------
DROP TABLE IF EXISTS `_log_weapons_user`;
CREATE TABLE `_log_weapons_user` (
  `user_id` int(11) DEFAULT NULL,
  `to` varchar(255) NOT NULL DEFAULT '',
  `from` varchar(255) NOT NULL DEFAULT '0',
  `weapon_name` varchar(255) DEFAULT '',
  `_time` timestamp NULL DEFAULT current_timestamp(),
  `weapon_amount` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of _log_weapons_user
-- ----------------------------

-- ----------------------------
-- View structure for `banned`
-- ----------------------------
DROP VIEW IF EXISTS `banned`;
CREATE ALGORITHM=UNDEFINED DEFINER=`gtavrp`@`%` SQL SECURITY DEFINER VIEW `banned` AS select `ident`.`user_id` AS `user_id`,conv(replace(`ident`.`identifier`,'steam:',''),16,10) AS `steamid`,`status`.`banned` AS `status`,`status`.`reason` AS `reason` from (`vrp_user_ids` `ident` join `vrp_users` `status` on(`ident`.`user_id` = `status`.`id`)) where `status`.`banned` > 0 order by `ident`.`user_id`;

-- ----------------------------
-- View structure for `cars_forbes`
-- ----------------------------
DROP VIEW IF EXISTS `cars_forbes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`gtavrp`@`%` SQL SECURITY DEFINER VIEW `cars_forbes` AS select `vrp_user_vehicles`.`user_id` AS `user_id`,sum(`vrp_user_vehicles`.`vehicle_price`) AS `SUM(vehicle_price)` from `vrp_user_vehicles` group by `vrp_user_vehicles`.`user_id` order by sum(`vrp_user_vehicles`.`vehicle_price`) desc;

-- ----------------------------
-- View structure for `cars_inactive_import`
-- ----------------------------
DROP VIEW IF EXISTS `cars_inactive_import`;
CREATE ALGORITHM=UNDEFINED DEFINER=`gtavrp`@`%` SQL SECURITY DEFINER VIEW `cars_inactive_import` AS select `vehicle`.`user_id` AS `id`,concat(`ident`.`firstname`,' ',`ident`.`name`) AS `name`,`vehicle`.`vehicle` AS `spawnname`,`vehicle`.`veh_type` AS `type`,`vehicle`.`vehicle_name` AS `vehicle_name`,cast(`money`.`_log_upd` as date) AS `last_money_transaction`,to_days(curdate()) - to_days(cast(`money`.`_log_upd` as date)) AS `days` from ((`vrp_user_identities` `ident` join `vrp_user_vehicles` `vehicle` on(`vehicle`.`user_id` = `ident`.`user_id` and `vehicle`.`vehicle` <> 'sandking' and `vehicle`.`vehicle` <> 'sanchez' and `vehicle`.`vehicle` <> 'sultan' and `vehicle`.`vehicle` <> 'premier')) join `vrp_user_moneys` `money` on(`vehicle`.`user_id` = `money`.`user_id` and `vehicle`.`vehicle_name` <> '' and `vehicle`.`vehicle_price` = 0 and `vehicle`.`vehicle_plate` <> '')) where cast(`money`.`_log_upd` as date) <= curdate() - interval 30 day order by to_days(curdate()) - to_days(cast(`money`.`_log_upd` as date)) desc;

-- ----------------------------
-- View structure for `cars_list`
-- ----------------------------
DROP VIEW IF EXISTS `cars_list`;
CREATE ALGORITHM=UNDEFINED DEFINER=`gtavrp`@`%` SQL SECURITY DEFINER VIEW `cars_list` AS select `vrp_user_vehicles`.`vehicle` AS `spawnname`,`vrp_user_vehicles`.`vehicle_name` AS `vehicle_name` from `vrp_user_vehicles` where `vrp_user_vehicles`.`vehicle_name` <> '' group by `vrp_user_vehicles`.`vehicle_name` order by `vrp_user_vehicles`.`vehicle_name`;

-- ----------------------------
-- View structure for `moneyhoes`
-- ----------------------------
DROP VIEW IF EXISTS `moneyhoes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`gtavrp`@`%` SQL SECURITY DEFINER VIEW `moneyhoes` AS select `ident`.`user_id` AS `id`,concat(`ident`.`firstname`,' ',`ident`.`name`) AS `name`,`money`.`wallet` + `money`.`bank` AS `value` from (`vrp_user_identities` `ident` join `vrp_user_moneys` `money` on(`ident`.`user_id` = `money`.`user_id`)) order by `money`.`wallet` + `money`.`bank` desc;
DROP TRIGGER IF EXISTS `vrp_users_analysis_bannings`;
DELIMITER ;;
CREATE TRIGGER `vrp_users_analysis_bannings` BEFORE UPDATE ON `vrp_users` FOR EACH ROW BEGIN

	IF ( IFNULL(OLD.`banned`,0) != IFNULL(NEW.`banned`,0) ) THEN
		INSERT INTO `_log_banstory`
			(`user_id`,`ban_from`,`ban_to`,`ban_reason`)
				VALUES
            (OLD.`id`,OLD.`banned`,NEW.`banned`,IFNULL(NEW.`reason`,''))
		;
    END IF;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `vrp_user_ids_logging`;
DELIMITER ;;
CREATE TRIGGER `vrp_user_ids_logging` AFTER DELETE ON `vrp_user_ids` FOR EACH ROW BEGIN

	INSERT INTO
		`_log_user_switch`
        (`identifier`,`userid`)
	VALUES
		(OLD.`identifier`,OLD.`user_id`)
	
    ON DUPLICATE KEY UPDATE `userid`=`userid`;

END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `vrp_user_moneys_analysis_update`;
DELIMITER ;;
CREATE TRIGGER `vrp_user_moneys_analysis_update` AFTER UPDATE ON `vrp_user_moneys` FOR EACH ROW BEGIN
	/* Lets check if the wallet has changed */
    IF ( IFNULL(OLD.`wallet`,0) != IFNULL(NEW.`wallet`,0) ) THEN
        INSERT INTO `vrpfx`.`_log_cashflow`
            (
                `user_id`,
                `cash_type`,
                `cash_start`,
                `cash_move`,
                `cash_end`
            )
                VALUES
            (
                OLD.`user_id`,
                'WALLET',
                IFNULL(OLD.`wallet`,0),
                ( IFNULL(NEW.`wallet`,0) - IFNULL(OLD.`wallet`,0) ),
                IFNULL(NEW.`wallet`,0)
            )
        ;
    END IF;

    /* Lets check if the wallet has changed */
    IF ( IFNULL(OLD.`bank`,0) != IFNULL(NEW.`bank`,0) ) THEN
        INSERT INTO `vrpfx`.`_log_cashflow`
            (
                `user_id`,
                `cash_type`,
                `cash_start`,
                `cash_move`,
                `cash_end`
            )
                VALUES
            (
                OLD.`user_id`,
                'BANK',
                IFNULL(OLD.`bank`,0),
                ( IFNULL(NEW.`bank`,0) - IFNULL(OLD.`bank`,0) ),
                IFNULL(NEW.`bank`,0)
            )
        ;
    END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `_log_adding`;
DELIMITER ;;
CREATE TRIGGER `_log_adding` BEFORE INSERT ON `vrp_user_vehicles` FOR EACH ROW INSERT INTO `vrpfx`.`_log_vehicles` (`action`,`user_id`,`vehicle`,`vehicle_price`) VALUES ('insert', NEW.`user_id`, NEW.`vehicle`, NEW.`vehicle_price`)
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `_log_deleting`;
DELIMITER ;;
CREATE TRIGGER `_log_deleting` BEFORE DELETE ON `vrp_user_vehicles` FOR EACH ROW INSERT INTO `vrpfx`.`_log_vehicles` (`action`,`user_id`,`vehicle`,`vehicle_price`) VALUES ('delete', OLD.`user_id`, OLD.`vehicle`, OLD.`vehicle_price`)
;;
DELIMITER ;
