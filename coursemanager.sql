create database coursemanager; 
use coursemanager;
CREATE TABLE if not exists `coursemanager`.`userinfo` (
  `id` int unsigned not null auto_increment,
  `userNo` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NULL,
  `password` VARCHAR(100) NOT NULL ,
  `role` VARCHAR(100) not NULL ,
  `ip_addr` VARCHAR(100) not NULL ,
  `mac_addr` VARCHAR(100) not NULL ,
  `switch_addr` VARCHAR(100) not NULL,
  `addtime` DATETIME not NULL,
  `lastlogintime` DATETIME not NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE key `userNo` (`userNo`) )
  ENGINE = InnoDB default charset=utf8;
  use coursemanager;
insert into `coursemanager`.`userinfo` (`id`,`userNo`,`name`,`password`,`role`,`addtime`,`ip_addr`,`mac_addr`,`switch_addr`
,`lastlogintime`
 )values('1','1','admin',
 '$2a$09$jwbt.074xQHy4/TfKgVsS.spaDSxmsnbm54cU9nUzfpuIb/NoDx9O','OWNER','2016-11-28 16:41:20','0','0','0','2016-11-28 16:41:30');
 
  create table if not exists  `coursemanager`.`sdnInfo`
  (
   `id` int unsigned not null auto_increment,
   `ip` VARCHAR(100) not NULL ,
   `mac` VARCHAR(100) not NULL ,
   `acesstime` DATETIME not NULL ,
   `topology_flag` boolean default '-1',
   `content` text not null,
   primary key (`id`),
	UNIQUE KEY `ip_mac` (`ip`,`mac`)
  )
  ENGINE = InnoDB default charset=utf8;
  
  create table if not exists `coursemanager`.`signlog`
  (
   `id` int unsigned not null auto_increment,
   `userid`  int unsigned not null,
   signed_time datetime not null,
   primary key (`id`)
  )
 ENGINE = InnoDB default charset=utf8 ;


