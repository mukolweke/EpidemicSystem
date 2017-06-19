-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 18, 2017 at 06:43 PM
-- Server version: 5.1.37
-- PHP Version: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `farmer_sys_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `reg_date` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `email`, `password`, `reg_date`, `status`) VALUES
(1, 'admin@admin.com', '98bfe778b3044eba856c4a35455a18', '01/01/2017', 0);

-- --------------------------------------------------------

--
-- Table structure for table `comment_epidemic`
--

CREATE TABLE IF NOT EXISTS `comment_epidemic` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `comm_desc` varchar(100) NOT NULL,
  `reg_date` varchar(100) NOT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `comment_epidemic`
--

INSERT INTO `comment_epidemic` (`comment_id`, `user_id`, `post_id`, `comm_desc`, `reg_date`) VALUES
(1, 1, 4, 'sorry about that...', 'Fri Jun 09 12:15:29 EAT 2017'),
(2, 1, 4, 'sorry about that...', 'Fri Jun 09 12:15:29 EAT 2017'),
(3, 4, 1, 'sorry about that...', 'Fri Jun 09 12:15:29 EAT 2017'),
(4, 4, 1, 'sorry about that...', 'Fri Jun 09 12:15:29 EAT 2017'),
(5, 3, 7, 'so what do you want', 'Fri Jun 09 13:31:51 EAT 2017');

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE IF NOT EXISTS `email` (
  `email_id` int(11) NOT NULL AUTO_INCREMENT,
  `email_to` varchar(100) NOT NULL,
  `email_from` varchar(100) NOT NULL,
  `email_subj` varchar(100) NOT NULL,
  `email_msg` int(10) NOT NULL,
  `email_status` tinyint(1) NOT NULL DEFAULT '0',
  `email_timestamp` varchar(50) NOT NULL,
  PRIMARY KEY (`email_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `email`
--


-- --------------------------------------------------------

--
-- Table structure for table `expert`
--

CREATE TABLE IF NOT EXISTS `expert` (
  `expert_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `field` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `addr` varchar(45) NOT NULL,
  `lat` varchar(45) NOT NULL,
  `lng` varchar(45) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `reg_date` varchar(100) NOT NULL,
  PRIMARY KEY (`expert_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `expert`
--


-- --------------------------------------------------------

--
-- Table structure for table `farmer`
--

CREATE TABLE IF NOT EXISTS `farmer` (
  `farmer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `addr` varchar(100) NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `status` tinyint(1) NOT NULL,
  `reg_date` varchar(100) NOT NULL,
  PRIMARY KEY (`farmer_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `farmer`
--

INSERT INTO `farmer` (`farmer_id`, `name`, `email`, `phone`, `password`, `addr`, `lat`, `lng`, `status`, `reg_date`) VALUES
(1, 'Betty Nyagoha', 'betty@mail.com', '+254898932322', 'baecee277e85d79b7efa8d842a139e7', 'Nandi, Kenya', 0.1036226, 35.1776556, 0, 'Jun 16, 2017 6:54:32 PM'),
(2, 'Alex Mukolwe', 'alexis@mail.com', '+254703946651', 'baecee277e85d79b7efa8d842a139e7', 'Turkana County, Kenya', 3.1183929, 35.5988136, 0, 'Jun 16, 2017 6:57:50 PM'),
(3, 'Kimani Njoroge', 'kimanithegreat@gmail.com', '+254719692332', '547da2b03f94766f1d06a8dec93e64', 'Nandi, Kenya', 0.1036226, 35.1776556, 0, 'Jun 16, 2017 7:55:13 PM'),
(4, 'Synthia', 'syth@mail.com', '+98765456789', 'jvcbjsdnudycgaknavfh8784bf', 'Nandi, Kenya', 0.1036226, 35.1776556, 0, '2017-08-32');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `message` varchar(100) NOT NULL,
  `msg_status` tinyint(1) NOT NULL,
  PRIMARY KEY (`msg_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `message`
--


-- --------------------------------------------------------

--
-- Table structure for table `post_blog`
--

CREATE TABLE IF NOT EXISTS `post_blog` (
  `blog_id` int(11) NOT NULL AUTO_INCREMENT,
  `expert_id` int(11) NOT NULL,
  `blog_title` varchar(45) NOT NULL,
  `blog_desc` varchar(45) NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `blog_date` varchar(45) NOT NULL,
  PRIMARY KEY (`blog_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `post_blog`
--


-- --------------------------------------------------------

--
-- Table structure for table `post_epidemic`
--

CREATE TABLE IF NOT EXISTS `post_epidemic` (
  `post_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_title` varchar(45) NOT NULL,
  `post_desc` text NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `reg_date` varchar(100) NOT NULL,
  PRIMARY KEY (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `post_epidemic`
--


-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `auth_key` tinyint(1) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `email`, `password`, `auth_key`) VALUES
(1, 'admin@admin.com', '98bfe778b3044eba856c4a35455a18', 1),
(2, 'betty@mail.com', 'baecee277e85d79b7efa8d842a139e7', 3),
(3, 'alexis@mail.com', 'baecee277e85d79b7efa8d842a139e7', 3),
(4, 'kimanithegreat@gmail.com', '547da2b03f94766f1d06a8dec93e64', 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
