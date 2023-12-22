-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 12, 2023 at 08:19 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ott_db`
--
CREATE DATABASE IF NOT EXISTS `ott_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ott_db`;

-- --------------------------------------------------------

--
-- Table structure for table `admin_approvals`
--

CREATE TABLE `admin_approvals` (
  `id` int(11) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `approval_status` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `content`
--

CREATE TABLE `content` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `viewer_count` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content`
--

INSERT INTO `content` (`id`, `title`, `description`, `creator_id`, `viewer_count`, `created_at`, `updated_at`) VALUES
(1, 'Do or Die', 'Movies of death', NULL, 1, '2023-11-29 10:58:04', '2023-11-29 10:58:04'),
(2, 'Do or Die', 'Movies of death', NULL, 1, '2023-11-29 10:59:12', '2023-11-29 10:59:12'),
(3, 'Do or Die', 'Movies of death', NULL, 1, '2023-11-29 10:59:47', '2023-11-29 10:59:47'),
(4, 'Do or Die', 'Movies of death', NULL, 1, '2023-11-29 11:01:55', '2023-11-29 11:01:55'),
(5, 'Do or Die', 'Movies of death', NULL, 7, '2023-11-29 11:02:39', '2023-11-29 17:53:13'),
(6, 'Do or Die', 'Movies of death', 3, 2, '2023-11-29 11:03:54', '2023-11-29 17:53:21');

-- --------------------------------------------------------

--
-- Table structure for table `content_comments`
--

CREATE TABLE `content_comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `content_likes`
--

CREATE TABLE `content_likes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content_likes`
--

INSERT INTO `content_likes` (`id`, `user_id`, `content_id`, `created_at`, `updated_at`) VALUES
(1, 3, 6, '2023-11-29 17:31:15', '2023-11-29 17:31:15'),
(2, 3, 5, '2023-11-29 17:31:23', '2023-11-29 17:31:23'),
(3, 2, 5, '2023-11-30 17:52:22', '2023-11-30 17:52:22'),
(4, 1, 5, '2023-11-30 17:52:40', '2023-11-30 17:52:40'),
(5, 5, 5, '2023-11-30 17:52:56', '2023-11-30 17:52:56');

-- --------------------------------------------------------

--
-- Table structure for table `content_videos`
--

CREATE TABLE `content_videos` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content_videos`
--

INSERT INTO `content_videos` (`id`, `user_id`, `content_id`, `video_id`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 1, '2023-12-07 15:26:31', '2023-12-07 15:26:31'),
(2, 1, 5, 2, '2023-12-07 15:33:54', '2023-12-07 15:33:54'),
(3, 1, 5, 3, '2023-12-07 15:34:54', '2023-12-07 15:34:54'),
(4, 1, 5, 4, '2023-12-07 15:35:12', '2023-12-07 15:35:12');

-- --------------------------------------------------------

--
-- Table structure for table `creator_collaborations`
--

CREATE TABLE `creator_collaborations` (
  `id` int(11) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `collaborator_id` int(11) DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `creator_collaborations`
--

INSERT INTO `creator_collaborations` (`id`, `creator_id`, `collaborator_id`, `content_id`, `created_at`, `updated_at`) VALUES
(1, 3, 5, 5, '2023-11-30 08:20:20', '2023-11-30 08:20:20'),
(3, 3, 5, 6, '2023-11-30 08:20:44', '2023-11-30 08:20:44'),
(4, 5, 5, 6, '2023-11-30 18:56:19', '2023-11-30 18:56:19');

-- --------------------------------------------------------

--
-- Table structure for table `payment_transactions`
--

CREATE TABLE `payment_transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rate_proposals`
--

CREATE TABLE `rate_proposals` (
  `id` int(11) NOT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `proposed_rate` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rate_proposals`
--

INSERT INTO `rate_proposals` (`id`, `creator_id`, `proposed_rate`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 6.00, 'rejected', '2023-12-06 13:02:05', '2023-12-06 13:37:20'),
(2, 2, 1500.00, 'approved', '2023-12-06 13:04:27', '2023-12-06 13:39:34');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration_months` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscription_plans`
--

INSERT INTO `subscription_plans` (`id`, `name`, `price`, `duration_months`, `created_at`, `updated_at`) VALUES
(1, 'Basic', 1500.00, 2, '2023-12-05 16:47:13', '2023-12-05 16:47:13'),
(2, 'Recommended', 2500.00, 6, '2023-12-05 16:57:42', '2023-12-05 16:57:42'),
(3, 'Permium', 5000.00, 12, '2023-12-05 16:58:01', '2023-12-05 16:58:01');

-- --------------------------------------------------------

--
-- Table structure for table `topup_requests`
--

CREATE TABLE `topup_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','creator','viewer') NOT NULL DEFAULT 'viewer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `firstname`, `lastname`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'test', 'test', 'test', 'test@test.com', '$2b$10$W1B7QrFIVi.587K/uKOjROWI/77riX4SOxq5ZogwJd.xEgPJvoCXO', 'viewer', '2023-11-29 09:18:53', '2023-11-29 09:18:53'),
(2, 'test2', 'test2', 'test', 'test@test2.com', '$2b$10$ovq1nkBteVNO3WhXZb.US.aJ729i8aQvB/kC7rcNAZtKWB3AudShK', 'viewer', '2023-11-29 09:19:16', '2023-11-29 09:19:16'),
(3, 'test3', 'test3', 'test', 'test@test3.com', '$2b$10$DVRUvcGWlWN1CYWEt5T.6OhSmIUJVrPQXBOEfrCE4LMdgPowVKxr2', 'creator', '2023-11-29 09:19:41', '2023-11-29 09:19:41'),
(4, 'test4', 'test4', 'test', 'test@test4.com', '$2b$10$ss5zOfL/Qy4xz6tlZD95huETRBzCAr7CAjBNPXOaJvioqcshRBcTe', 'admin', '2023-11-29 09:20:51', '2023-11-29 09:20:51'),
(5, 'test5', 'test5', 'test', 'test@test5.com', '$2b$10$yTuT55.iPXZuavmoPfACGuUocSbSRDX1e9tdSK1lGnsDDHW1PyHiu', 'creator', '2023-11-30 08:18:31', '2023-11-30 08:18:31');

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `user_id`, `profile_picture`, `bio`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, '2023-11-29 09:18:53', '2023-11-29 09:18:53'),
(2, 2, NULL, NULL, '2023-11-29 09:19:16', '2023-11-29 09:19:16'),
(3, 3, NULL, NULL, '2023-11-29 09:19:41', '2023-11-29 09:19:41'),
(4, 4, NULL, NULL, '2023-11-29 09:20:51', '2023-11-29 09:20:51'),
(5, 5, NULL, NULL, '2023-11-30 08:18:31', '2023-11-30 08:18:31');

-- --------------------------------------------------------

--
-- Table structure for table `user_subscriptions`
--

CREATE TABLE `user_subscriptions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `subscription_plan_id` int(11) DEFAULT NULL,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `isActive` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_subscriptions`
--

INSERT INTO `user_subscriptions` (`id`, `user_id`, `subscription_plan_id`, `start_date`, `end_date`, `isActive`, `created_at`, `updated_at`) VALUES
(1, 2, 2, '2023-12-05 18:09:52', '2024-06-05 18:09:52', 1, '2023-12-05 18:09:52', '2023-12-05 18:09:52'),
(2, 2, 2, '2023-12-05 18:09:57', '2024-06-05 18:09:57', 0, '2023-12-05 18:09:57', '2023-12-05 18:09:57'),
(3, 2, 2, '2023-12-05 18:11:57', '2024-06-05 18:11:57', 0, '2023-12-05 18:11:57', '2023-12-05 18:11:57'),
(4, 2, 3, '2023-12-05 18:12:10', '2024-12-05 18:12:10', 0, '2023-12-05 18:12:10', '2023-12-05 18:12:10');

-- --------------------------------------------------------

--
-- Table structure for table `user_wallets`
--

CREATE TABLE `user_wallets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_wallets`
--

INSERT INTO `user_wallets` (`id`, `user_id`, `balance`, `created_at`, `updated_at`) VALUES
(1, 1, 470.00, '2023-11-30 19:56:34', '2023-11-30 20:04:21');

-- --------------------------------------------------------

--
-- Table structure for table `video_libary`
--

CREATE TABLE `video_libary` (
  `id` int(11) NOT NULL,
  `video_url` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `video_libary`
--

INSERT INTO `video_libary` (`id`, `video_url`, `created_at`, `updated_at`) VALUES
(1, 'uploads\\z7NLXT0Vg2IhrMU.mp4', '2023-12-07 15:26:28', '2023-12-07 15:26:28'),
(2, 'uploads\\GMYMJ1KIlmy94hb.mp4', '2023-12-07 15:33:51', '2023-12-07 15:33:51'),
(3, 'uploads\\se8NeJPWMWoetBy.mp4', '2023-12-07 15:34:50', '2023-12-07 15:34:50'),
(4, 'uploads\\SQoLWQxysolUSSH.mp4', '2023-12-07 15:35:06', '2023-12-07 15:35:06');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `transaction_type` enum('credit','debit') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wallet_transactions`
--

INSERT INTO `wallet_transactions` (`id`, `user_id`, `transaction_type`, `amount`, `description`, `created_at`) VALUES
(1, 1, 'credit', 0.00, NULL, '2023-11-30 19:56:34'),
(2, 1, 'credit', 500.00, NULL, '2023-11-30 19:56:38'),
(3, 1, 'credit', 50.00, NULL, '2023-11-30 19:59:31'),
(4, 1, 'debit', -20.00, NULL, '2023-11-30 20:00:14'),
(5, 1, 'debit', -30.00, NULL, '2023-11-30 20:00:36'),
(6, 1, 'debit', -30.00, NULL, '2023-11-30 20:04:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_approvals`
--
ALTER TABLE `admin_approvals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_creator_approval` (`creator_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`);

--
-- Indexes for table `content_comments`
--
ALTER TABLE `content_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `content_id` (`content_id`);

--
-- Indexes for table `content_likes`
--
ALTER TABLE `content_likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_KEY` (`user_id`,`content_id`),
  ADD KEY `content_id` (`content_id`);

--
-- Indexes for table `content_videos`
--
ALTER TABLE `content_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `content_id` (`content_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Indexes for table `creator_collaborations`
--
ALTER TABLE `creator_collaborations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_KEY` (`creator_id`,`collaborator_id`,`content_id`),
  ADD KEY `collaborator_id` (`collaborator_id`),
  ADD KEY `content_id` (`content_id`);

--
-- Indexes for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `rate_proposals`
--
ALTER TABLE `rate_proposals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`);

--
-- Indexes for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topup_requests`
--
ALTER TABLE `topup_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `subscription_plan_id` (`subscription_plan_id`);

--
-- Indexes for table `user_wallets`
--
ALTER TABLE `user_wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `video_libary`
--
ALTER TABLE `video_libary`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_approvals`
--
ALTER TABLE `admin_approvals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `content`
--
ALTER TABLE `content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `content_comments`
--
ALTER TABLE `content_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `content_likes`
--
ALTER TABLE `content_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `content_videos`
--
ALTER TABLE `content_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `creator_collaborations`
--
ALTER TABLE `creator_collaborations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rate_proposals`
--
ALTER TABLE `rate_proposals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `topup_requests`
--
ALTER TABLE `topup_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_wallets`
--
ALTER TABLE `user_wallets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `video_libary`
--
ALTER TABLE `video_libary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_approvals`
--
ALTER TABLE `admin_approvals`
  ADD CONSTRAINT `admin_approvals_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `admin_approvals_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `content_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `content_comments`
--
ALTER TABLE `content_comments`
  ADD CONSTRAINT `content_comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `content_comments_ibfk_2` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`);

--
-- Constraints for table `content_likes`
--
ALTER TABLE `content_likes`
  ADD CONSTRAINT `content_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `content_likes_ibfk_2` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`);

--
-- Constraints for table `content_videos`
--
ALTER TABLE `content_videos`
  ADD CONSTRAINT `content_videos_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `content_videos_ibfk_2` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `content_videos_ibfk_3` FOREIGN KEY (`video_id`) REFERENCES `video_libary` (`id`);

--
-- Constraints for table `creator_collaborations`
--
ALTER TABLE `creator_collaborations`
  ADD CONSTRAINT `creator_collaborations_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `creator_collaborations_ibfk_2` FOREIGN KEY (`collaborator_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `creator_collaborations_ibfk_3` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`);

--
-- Constraints for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD CONSTRAINT `payment_transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `rate_proposals`
--
ALTER TABLE `rate_proposals`
  ADD CONSTRAINT `rate_proposals_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `topup_requests`
--
ALTER TABLE `topup_requests`
  ADD CONSTRAINT `topup_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_subscriptions`
--
ALTER TABLE `user_subscriptions`
  ADD CONSTRAINT `user_subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_subscriptions_ibfk_2` FOREIGN KEY (`subscription_plan_id`) REFERENCES `subscription_plans` (`id`);

--
-- Constraints for table `user_wallets`
--
ALTER TABLE `user_wallets`
  ADD CONSTRAINT `user_wallets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD CONSTRAINT `wallet_transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
