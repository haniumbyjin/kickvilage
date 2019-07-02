# Host: db.huiya.me:3307  (Version 5.5.5-10.3.7-MariaDB)
# Date: 2019-04-05 23:47:42
# Generator: MySQL-Front 6.1  (Build 1.26)


#
# Structure for table "admin"
#

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `adminId` varchar(200) NOT NULL COMMENT '관리자아이디',
  `adminPw` varchar(200) NOT NULL COMMENT '관리지비밀번호',
  `salt` varchar(64) DEFAULT NULL COMMENT '솔트',
  PRIMARY KEY (`adminId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='admin';

#
# Structure for table "station"
#

DROP TABLE IF EXISTS `station`;
CREATE TABLE `station` (
  `stationNum` int(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '정류소번호',
  `stationName` varchar(60) DEFAULT NULL COMMENT '주소',
  `locationX` varchar(30) DEFAULT NULL COMMENT '위도',
  `locationY` varchar(30) DEFAULT NULL COMMENT '경도',
  `open` varchar(100) DEFAULT NULL COMMENT '영업시간',
  PRIMARY KEY (`stationNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='정류소';

#
# Structure for table "kickboard"
#

DROP TABLE IF EXISTS `kickboard`;
CREATE TABLE `kickboard` (
  `serialNum` int(10) unsigned NOT NULL COMMENT '킥보드고유번호',
  `stationNum` int(10) unsigned DEFAULT NULL COMMENT '정류소번호',
  PRIMARY KEY (`serialNum`),
  KEY `FK_station_TO_kickboard` (`stationNum`),
  CONSTRAINT `FK_station_TO_kickboard` FOREIGN KEY (`stationNum`) REFERENCES `station` (`stationNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='킥보드';

#
# Structure for table "user"
#

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` varchar(200) NOT NULL COMMENT '사용자아이디',
  `userPw` varchar(200) DEFAULT NULL COMMENT '비밀번호',
  `userName` varchar(200) DEFAULT NULL COMMENT '이름',
  `phoneNum` varchar(50) DEFAULT NULL COMMENT '폰번호',
  `driverLisence` enum('y','n') DEFAULT NULL COMMENT '운전면허유무',
  `salt` varchar(64) DEFAULT NULL COMMENT '솔트',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자';

#
# Structure for table "reserve"
#

DROP TABLE IF EXISTS `reserve`;
CREATE TABLE `reserve` (
  `reserveNum` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '번호',
  `userId` varchar(200) DEFAULT NULL COMMENT '사용자아이디',
  `rentalStationNum` int(10) unsigned DEFAULT NULL COMMENT '대여_정류소_번호호',
  `returnStationNum` int(10) unsigned DEFAULT NULL COMMENT '반납_정류소_번호호',
  `reserveDate` datetime(6) DEFAULT NULL COMMENT '예약날짜',
  `rentalDate` datetime(6) DEFAULT NULL COMMENT '대여날짜',
  `returnDate` datetime(6) DEFAULT NULL COMMENT '반납날짜',
  `rentalFee` int(10) unsigned DEFAULT NULL COMMENT '가격',
  `serialNum` int(10) unsigned DEFAULT NULL COMMENT '킥보드고유번호',
  PRIMARY KEY (`reserveNum`),
  KEY `FK_station_TO_reserve` (`rentalStationNum`),
  KEY `FK_station_TO_reserve2` (`returnStationNum`),
  KEY `FK_user_TO_reserve` (`userId`),
  KEY `FK_kickboard_TO_reserve` (`serialNum`),
  CONSTRAINT `FK_kickboard_TO_reserve` FOREIGN KEY (`serialNum`) REFERENCES `kickboard` (`serialNum`),
  CONSTRAINT `FK_station_TO_reserve` FOREIGN KEY (`rentalStationNum`) REFERENCES `station` (`stationNum`),
  CONSTRAINT `FK_station_TO_reserve2` FOREIGN KEY (`returnStationNum`) REFERENCES `station` (`stationNum`),
  CONSTRAINT `FK_user_TO_reserve` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='예약,대여';

#
# Structure for table "GPS"
#

DROP TABLE IF EXISTS `GPS`;
CREATE TABLE `GPS` (
  `reserveNum` int(10) unsigned DEFAULT NULL COMMENT '번호',
  `sequence` int(10) unsigned DEFAULT NULL COMMENT '순서',
  `locationX` varchar(30) DEFAULT NULL COMMENT '위도',
  `locationY` varchar(30) DEFAULT NULL COMMENT '경도',
  KEY `FK_reserve_TO_GPS` (`reserveNum`),
  CONSTRAINT `FK_reserve_TO_GPS` FOREIGN KEY (`reserveNum`) REFERENCES `reserve` (`reserveNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='GPS';

#
# Structure for table "card"
#

DROP TABLE IF EXISTS `card`;
CREATE TABLE `card` (
  `cardNum` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '카드고유값',
  `userId` varchar(200) DEFAULT NULL COMMENT '사용자아이디',
  `cardNumFirst` varchar(15) DEFAULT NULL COMMENT '카드번호첫번쨰',
  `cardNumSecond` varchar(15) DEFAULT NULL COMMENT '카드번호두번쨰',
  `cardNumThird` varchar(15) DEFAULT NULL COMMENT '카드번호세번쨰',
  `cardNumFourth` varchar(15) DEFAULT NULL COMMENT '카드번호네번쨰',
  `validityMonth` varchar(10) DEFAULT NULL COMMENT '유효기간월',
  `validityYear` varchar(10) DEFAULT NULL COMMENT '유효기간일',
  `cardPw` varchar(10) DEFAULT NULL COMMENT '카드비밀번호',
  PRIMARY KEY (`cardNum`),
  KEY `FK_user_TO_card` (`userId`),
  CONSTRAINT `FK_user_TO_card` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='카드';

#
# Structure for table "board"
#

DROP TABLE IF EXISTS `board`;
CREATE TABLE `board` (
  `boardNum` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '게시판번호',
  `boardTitle` varchar(255) DEFAULT NULL COMMENT '제목',
  `boardText` longtext DEFAULT NULL COMMENT '내용',
  `boardDate` timestamp(6) NULL DEFAULT NULL COMMENT '날짜',
  `userId` varchar(200) DEFAULT NULL COMMENT '사용자아이디',
  PRIMARY KEY (`boardNum`),
  KEY `FK_user_TO_board` (`userId`),
  CONSTRAINT `FK_user_TO_board` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='board';

#
# Structure for table "answer"
#

DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `answerNum` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '댓글번호',
  `adminId` varchar(200) DEFAULT NULL COMMENT '관리자아이디',
  `answerText` longtext DEFAULT NULL COMMENT '내용',
  `answerDate` timestamp NULL DEFAULT NULL COMMENT '날짜',
  `boardNum` int(10) unsigned DEFAULT NULL COMMENT '게시판번호',
  PRIMARY KEY (`answerNum`),
  KEY `FK_admin_TO_answer` (`adminId`),
  KEY `FK_board_TO_answer` (`boardNum`),
  CONSTRAINT `FK_admin_TO_answer` FOREIGN KEY (`adminId`) REFERENCES `admin` (`adminId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_board_TO_answer` FOREIGN KEY (`boardNum`) REFERENCES `board` (`boardNum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='answer';
