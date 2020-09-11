CREATE TABLE IF NOT EXISTS `USERS` (
`ID` int(11) NOT NULL AUTO_INCREMENT,
`NAME` varchar(24) DEFAULT NULL,
`PASSWORD` varchar(256) DEFAULT NULL,
`SALT` varchar(256) DEFAULT NULL,
`LAST_IP` varchar(16) DEFAULT NULL,
`SCORE` int(8) DEFAULT NULL,
`RANK` int(8) NOT NULL DEFAULT 0,
`CASH` int(16) DEFAULT NULL,
`KILLS` int(8) DEFAULT NULL,
`DEATHS` int(8) DEFAULT NULL,
`LASTSEEN` int(16) DEFAULT NULL,
`FIGHTSTYLE` int(3) DEFAULT NULL,
`CAPTURES` int(8) DEFAULT NULL,
`DM_KILLS` int(8) DEFAULT NULL,
`DM_DEATHS` int(8) DEFAULT NULL,
`MUTE_TIME` int(16) DEFAULT NULL,
`ADMIN_LEVEL` int(2) DEFAULT NULL,
`VIP_LEVEL` int(2) DEFAULT NULL,
`CLAN`int(2) DEFAULT NULL,
PRIMARY KEY (`ID`),
UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `BANS`(
`ID` int(11) NOT NULL AUTO_INCREMENT,
`USER_NAME` varchar(24) DEFAULT NULL,
`ADMIN_NAME` varchar(24) DEFAULT NULL,
`IP` int(16) DEFAULT NULL,
`REASON` varchar(64) DEFAULT NULL,
`BANNED_ON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`EXPIRE` int(11) NOT NULL DEFAULT '0',
UNIQUE KEY `NAME` (`NAME`),
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `TRANSACTIONS`(
`ID` int(11) NOT NULL AUTO_INCREMENT,
`TO_ID` int(11) DEFAULT NULL,
`FROM_ID` int(11) DEFAULT NULL,
`CASH` int(11) NOT NULL DEFAULT '0',
`NATURE`varchar(16) DEFAULT 'transaction',
`DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `REWARD_CODES`(
`ID` int(11) NOT NULL AUTO_INCREMENT,
`CODE` varchar(8) DEFAULT NULL,
`CODE_TYPE` varchar(8) DEFAULT NULL,
`CODE_VALUE` int(8) DEFAULT NULL,
`MAX_USES` int(11) DEFAULT NULL,
`USES` int(11) DEFAULT '0',
`EXPIRE_TIME`int(11) DEFAULT '0',
`CREATION_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `NAME_CHANGES`(
`ID` int(11) NOT NULL AUTO_INCREMENT,
`USER_ID` int(11) DEFAULT NULL,
`ADMIN_NAME` varchar(24) DEFAULT NULL,
`FROM_NAME` varchar(24) DEFAULT NULL,
`TO_NAME` varchar(24) DEFAULT NULL,
`TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `NOTES`(
`ID` int(11) NOT NULL AUTO_INCREMENT,
`USER_ID` int(11) NOT NULL,
`ADDED_BY` int(11) NOT NULL,
`NOTE` varchar(256) DEFAULT NULL,
`TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE IF NOT EXISTS `ADMIN_LOG`(
`ID` int(11) NOT NULL AUTO_INCREMENT,
`ISSUER` varchar(24) DEFAULT NULL,
`ADMIN_LEVEL` tinyint(2) DEFAULT NULL,
`ACTION` text DEFAULT NULL,
`ACTION_ID` int(11) DEFAULT NULL,
`TARGET` varchar(24) DEFAULT NULL,
`DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;