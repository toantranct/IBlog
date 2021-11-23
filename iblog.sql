-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 23, 2021 lúc 10:27 AM
-- Phiên bản máy phục vụ: 10.4.20-MariaDB
-- Phiên bản PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `iblog`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `id` bigint(20) NOT NULL,
  `parentId` bigint(20) DEFAULT NULL,
  `title` varchar(75) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `metaTitle` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_vietnamese_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post`
--

CREATE TABLE `post` (
  `id` bigint(20) NOT NULL,
  `authorId` bigint(20) NOT NULL,
  `parentId` bigint(20) DEFAULT NULL,
  `title` varchar(75) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `metaTitle` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `summary` tinytext COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `publishedAt` datetime DEFAULT NULL,
  `content` text COLLATE utf8mb4_vietnamese_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post_category`
--

CREATE TABLE `post_category` (
  `postId` bigint(20) NOT NULL,
  `categoryId` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post_comment`
--

CREATE TABLE `post_comment` (
  `id` bigint(20) NOT NULL,
  `postId` bigint(20) NOT NULL,
  `parentId` bigint(20) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `publishedAt` datetime DEFAULT NULL,
  `content` text COLLATE utf8mb4_vietnamese_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post_tag`
--

CREATE TABLE `post_tag` (
  `postId` bigint(20) NOT NULL,
  `tagId` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tag`
--

CREATE TABLE `tag` (
  `id` bigint(20) NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `metaTitle` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_vietnamese_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `firstName` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `lastName` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `passwordHash` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `registeredAt` datetime NOT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `intro` text COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `profile` text COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category_parent` (`parentId`);

--
-- Chỉ mục cho bảng `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_post_user` (`authorId`),
  ADD KEY `idx_post_parent` (`parentId`);

--
-- Chỉ mục cho bảng `post_category`
--
ALTER TABLE `post_category`
  ADD PRIMARY KEY (`postId`,`categoryId`),
  ADD KEY `idx_pc_category` (`categoryId`),
  ADD KEY `idx_pc_post` (`postId`);

--
-- Chỉ mục cho bảng `post_comment`
--
ALTER TABLE `post_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_comment_post` (`postId`),
  ADD KEY `idx_comment_parent` (`parentId`);

--
-- Chỉ mục cho bảng `post_tag`
--
ALTER TABLE `post_tag`
  ADD PRIMARY KEY (`postId`,`tagId`),
  ADD KEY `idx_pc_category` (`tagId`),
  ADD KEY `idx_pc_post` (`postId`);

--
-- Chỉ mục cho bảng `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_mobile` (`mobile`),
  ADD UNIQUE KEY `uq_email` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `post`
--
ALTER TABLE `post`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `post_comment`
--
ALTER TABLE `post_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tag`
--
ALTER TABLE `tag`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `fk_category_parent` FOREIGN KEY (`parentId`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `fk_post_parent` FOREIGN KEY (`parentId`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_post_user` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `post_category`
--
ALTER TABLE `post_category`
  ADD CONSTRAINT `fk_pc_category` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pc_post` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `post_comment`
--
ALTER TABLE `post_comment`
  ADD CONSTRAINT `fk_comment_parent` FOREIGN KEY (`parentId`) REFERENCES `post_comment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_comment_post` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `post_tag`
--
ALTER TABLE `post_tag`
  ADD CONSTRAINT `fk_pc_postid` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pc_tag` FOREIGN KEY (`tagId`) REFERENCES `tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
