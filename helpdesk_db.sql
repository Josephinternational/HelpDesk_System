-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 24, 2026 at 09:12 PM
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
-- Database: `helpdesk_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_tokens`
--

CREATE TABLE `auth_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token_hash` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_tokens`
--

INSERT INTO `auth_tokens` (`id`, `user_id`, `token_hash`, `expires_at`, `created_at`) VALUES
(1, 3, '6f2f2024d76f1c6bf271400e4ecf844b67be49e321fa9166789d174f5affff64', '2026-03-01 20:34:58', '2026-02-22 19:34:58'),
(2, 3, 'dce91b1d5e3389f9a9162c67280f992235f4c567bc3768ee292a407a3cdbb094', '2026-03-01 20:35:02', '2026-02-22 19:35:02'),
(3, 3, 'c7abab98148813da2776fce835400022c4555f315609d46ff65f950d753bb531', '2026-03-01 20:35:04', '2026-02-22 19:35:04'),
(4, 3, 'acf68c6d41b5e0e9675233f10d301613c12570c567e04f95459b95f80b447045', '2026-03-01 20:35:06', '2026-02-22 19:35:06'),
(5, 3, '74b7c47a9efdf5d03588666040f386755d81d3945bdcc70fb03a02ff4fa68b5f', '2026-03-01 20:35:15', '2026-02-22 19:35:15'),
(6, 3, 'dc021b85caf8c81d98b029b3343922e8ee3f8276a584043df2fda6e4767b889d', '2026-03-01 20:35:16', '2026-02-22 19:35:16'),
(7, 3, '0b78378d35a9a28f9df5d052a25e59749f7c1771adbd637cd31ddd7a6abe4446', '2026-03-01 20:35:18', '2026-02-22 19:35:18'),
(8, 3, 'b6e0f43fbf245883b4d898c39efce1ee2266b3a500a5d8edb64be454b8becf48', '2026-03-01 20:35:19', '2026-02-22 19:35:19'),
(9, 3, 'cf581a3f684504b2443c8c5d7b5352c9f4d24eda201aa0f528bb2a48d41e8263', '2026-03-01 20:35:51', '2026-02-22 19:35:51'),
(10, 3, 'e546a119fa041aa333e931b13d109fad0084b9ce5ea7d8daf4331b71a3a1bfa6', '2026-03-01 20:36:06', '2026-02-22 19:36:06'),
(11, 3, '8e7968476fa0599097b5815f8bea3c927c3dc837e1e707d85e04c3e79a78b703', '2026-03-01 20:36:11', '2026-02-22 19:36:11'),
(12, 3, 'd03ef2927ceca0266d9bd11eb08d034524d593beee957211d6625cf832d96f1b', '2026-03-01 20:36:22', '2026-02-22 19:36:22'),
(13, 3, '1fddc34c4c0d1c3f1cdc27ba7a86aeeda6f332bab8bcd7fe871f5d4ad5936e68', '2026-03-01 20:36:26', '2026-02-22 19:36:26'),
(14, 3, '312e6f2327451fd2a8f5ce2c36dc8db14c3bc4d14a0cc5a5d906f3ad427b4b25', '2026-03-01 20:36:27', '2026-02-22 19:36:27'),
(15, 5, 'a1dae914974518ef6e49390c1cc13c2dab5cbb39f2451a948792faa9c4e3a4b1', '2026-03-01 20:36:55', '2026-02-22 19:36:55'),
(16, 5, '70174d968db8706a0f22e6566099e3b729ef0843544928102082fd8c57831ee8', '2026-03-01 20:36:57', '2026-02-22 19:36:57'),
(17, 5, '41b13994af0e334acd2e80b99a8a5f5bfcc4be3a56f2dc5f05efc5af3bade604', '2026-03-01 20:36:58', '2026-02-22 19:36:58'),
(18, 5, 'd854c23e69c14d78e4973a0f155f7c933662ea7fe4f4f9c79a0616f35feeaace', '2026-03-01 20:36:59', '2026-02-22 19:36:59'),
(19, 5, '36e230d3a65ef8cd94aebb77f7814e8a456caaddfc059d9291276115f0e903d7', '2026-03-01 20:39:32', '2026-02-22 19:39:32'),
(20, 5, '9d0f63dc1274dd15d2ac45c776a1428479b1bb6257151993c966be381f3b57e8', '2026-03-01 20:39:38', '2026-02-22 19:39:38'),
(21, 5, 'dc0f03cf162e4d54b79fdbeacfd159cedc62cf7e2a96069e23c5046e248ddf2a', '2026-03-01 20:39:41', '2026-02-22 19:39:41'),
(22, 5, '20732e99ae54b9e42162d1919cc09db85bd7b7fe7e7e0f9ea45f8e5dfecad54e', '2026-03-01 20:39:43', '2026-02-22 19:39:43'),
(23, 5, '8aa44f1e06111f2f5a415f34f11db075f874013aa070341e82dff74843692c33', '2026-03-01 20:39:45', '2026-02-22 19:39:45'),
(24, 3, 'a5f80c63bf76f4b14d3c152a61c23f4b40b30eb9ffc1742f6018bb5d63fc0103', '2026-03-01 20:41:18', '2026-02-22 19:41:18'),
(25, 3, 'baa133baf7be4b8cc9dc78cecb152e4298a7fd1d195862ad0d1bc3ff502d0972', '2026-03-01 20:41:27', '2026-02-22 19:41:27'),
(26, 3, '9272bef3e9fd8a8517cf895e322760350dd97c18273c49fe3027643d146f904c', '2026-03-01 20:41:30', '2026-02-22 19:41:30'),
(27, 3, 'd203984400545a73ab2a5d59b995b2ae97e042a23ec4ceff6da9d125aed78f1c', '2026-03-01 20:41:32', '2026-02-22 19:41:32'),
(28, 3, '792d806fe06d63b9f68c59ffb15a3b8435858aac2d477e71a04bb09c19e50ad1', '2026-03-01 20:41:33', '2026-02-22 19:41:33'),
(29, 3, 'e0b3f119865e728c1c20761024f86ab2c8acbcbe17c8c80d947fd82bcbc5a0cb', '2026-03-01 20:41:35', '2026-02-22 19:41:35'),
(30, 3, 'f1fdd5bdced6cd3d6da2285cba51de0302a23d98a3e85a1ffede48f334830bcd', '2026-03-01 20:41:46', '2026-02-22 19:41:46'),
(31, 3, 'a0c89c95b9d917ca3977891259de266ffb2b00bdbe645ee41b7d12030fb201c9', '2026-03-01 20:41:48', '2026-02-22 19:41:48'),
(32, 3, '4ae696f94214e725b9e426f0ec15f5bd6e3d15b590cbb6d98ceb9a308903b8c5', '2026-03-01 20:41:49', '2026-02-22 19:41:49'),
(33, 3, '1790c0dfdde6334d3b9880abb28e7abceea632e91acfade57d46e1781af007a0', '2026-03-01 20:41:56', '2026-02-22 19:41:56'),
(34, 3, 'db520d90e2e2ce31d65ada50957d37e67da4f77a7e5881a51dea068bbf431f91', '2026-03-01 20:41:57', '2026-02-22 19:41:57'),
(35, 3, '5dbd1dc0af4449dc6c2d14556c6ab2ad245b86821649f627c5e4b00d685c227c', '2026-03-01 20:42:04', '2026-02-22 19:42:04'),
(36, 5, '3df7a2cae18ef0c4c19d0d6f486c6dfeff2202fa17ed1d8f519a16f2c88a4a28', '2026-03-01 21:31:34', '2026-02-22 20:31:34'),
(37, 5, '68892c5da2a3ef3fa15cd6f361d6366f6394f00250e33019e5ab441014e435b6', '2026-03-01 21:31:37', '2026-02-22 20:31:37'),
(38, 5, '09a86728f5a8d67d12c1f36f751fcaa784bb51646fac5ecc5884216a11a913ca', '2026-03-01 21:31:40', '2026-02-22 20:31:40'),
(39, 5, '7706b923b9110d13ad1e34a2ad4b5ef27695d2076cee2c08a72c53424825f806', '2026-03-01 21:31:43', '2026-02-22 20:31:43'),
(40, 5, 'cdcdff4bc9377036ec8a091f1962066165ca5a4f0e653f1019a8ffccd24184fd', '2026-03-01 21:31:44', '2026-02-22 20:31:44'),
(41, 5, '6807c48eebe8458418e7a3c32d47c0b46f606dca25986d8477ccef2bb49c264b', '2026-03-01 21:31:46', '2026-02-22 20:31:46'),
(42, 5, 'e96e59ca7e91a609c3b1e1df7571aca682733161553106a17672c87c52d12d36', '2026-03-01 21:31:47', '2026-02-22 20:31:47'),
(43, 5, '8da4639767400c395f69fd0d3325ce70375d13fdeae0222b4daf169ecae1dc5f', '2026-03-01 21:31:49', '2026-02-22 20:31:49'),
(44, 5, '82a460534b3e13db8f9539c96f1dded097da14f047de1c43b71fbf3fc337036e', '2026-03-01 21:33:29', '2026-02-22 20:33:29'),
(45, 5, '716010451b03e80727b964eb4c95567017bfc0ad96b72500c6dd5e05eb046081', '2026-03-01 21:33:31', '2026-02-22 20:33:31'),
(46, 5, 'bb3aae0c9910041c65c7708d962b14f5591e02847305695dc4687ab5dc5fc152', '2026-03-01 21:33:32', '2026-02-22 20:33:32'),
(47, 5, 'c59f5ceaad71f8f3296d228b183d72d0d47cb824ce0301bf2ad433ffe31291c3', '2026-03-01 21:33:34', '2026-02-22 20:33:34'),
(48, 5, 'c1d3cf67f33888871fc0983f399a303d2a957d3325572397a7703a7405872fa3', '2026-03-01 21:33:35', '2026-02-22 20:33:35'),
(49, 5, 'd5917d166579c8776aa30072e8db13ebca3ebe50600f906d324f5ff200bcf928', '2026-03-01 21:33:36', '2026-02-22 20:33:36'),
(50, 5, 'aa7a5a86b4d0fd2b7831b0457a8d07cef276753670d138a242c575ce3648ebcd', '2026-03-01 21:33:38', '2026-02-22 20:33:38'),
(51, 5, 'b35d7569166cef02adbcc75c617d637571fce580b767e0287130305e56c46964', '2026-03-01 21:33:39', '2026-02-22 20:33:39'),
(52, 5, '4e071a8ba5c550ac076102190b8e0b5f9354135df15c30b575fa273ae9c0f67f', '2026-03-01 21:33:40', '2026-02-22 20:33:40'),
(53, 5, 'bf41dd7071a085a67d9827466f23a90cf0c2f8cc0029c3a760cb36439894e1f5', '2026-03-01 21:33:41', '2026-02-22 20:33:41'),
(54, 5, '05394e90ab127f07d029be08155dc352823aec6588ee7a3ff86f0c5bff331003', '2026-03-01 21:33:43', '2026-02-22 20:33:43'),
(55, 5, '776b77305b0c893bec80c969bf9440715acfa5a9e1676c79484d967691e510f6', '2026-03-01 21:33:44', '2026-02-22 20:33:44'),
(56, 5, 'e96d055e863a434837b57100c46e9b962aca05b267cf529fe1cc081eb30f22bd', '2026-03-01 21:33:45', '2026-02-22 20:33:45'),
(57, 5, 'f4daf372d3409e40b3f2b72f9625a2e3b7491bc43c89175e410e8abb6f2bb88e', '2026-03-01 21:33:46', '2026-02-22 20:33:46'),
(58, 5, '7785a9782e81748ba1647f9c652f36813c6ff365d5501f983cfa80e5b3650db4', '2026-03-01 21:33:47', '2026-02-22 20:33:47'),
(59, 5, '8a93fad886d807cfe3249b37db34168214d8ce72f97c1bfe6b30dfd539318c8e', '2026-03-01 21:33:49', '2026-02-22 20:33:49'),
(60, 5, '96d5db8fdd9364ae5370f630a195c38b0342502b4fbcb25e6e5938225968ae44', '2026-03-01 21:33:50', '2026-02-22 20:33:50'),
(61, 5, '7226f7f341600c3e4b76fcc1922a848bd28f0fca475356def92f7e4b68248dce', '2026-03-01 21:34:32', '2026-02-22 20:34:32'),
(62, 5, 'fb2d84374c1fa945e949a8574e96c0ae6172eff357eed42f7b9dceffc7a56d04', '2026-03-01 21:34:34', '2026-02-22 20:34:34'),
(63, 5, '552195467c5aaeb129f5748527107aae720e3fcd13f58cbc73cf81c9a960708b', '2026-03-01 21:40:29', '2026-02-22 20:40:29'),
(64, 5, 'cdaeec281f7b63cb944b132063eb5442f177428c889c47d0154e9433baa65f50', '2026-03-01 21:40:33', '2026-02-22 20:40:33'),
(65, 5, '1ca1bc8c3dba4d60a8ffd08fda17e8c4c7114c29f3414418149e2132f21868c6', '2026-03-01 21:40:35', '2026-02-22 20:40:35'),
(66, 5, 'a5b1b3b423661f52fb945ac8bff26caf7db17858922b74b661884082098290d9', '2026-03-01 21:40:36', '2026-02-22 20:40:36'),
(67, 5, '53caa539d3fa4ba141ea220636a8fa4eae170384add93d270c9220199d9bccef', '2026-03-01 21:40:39', '2026-02-22 20:40:39'),
(68, 5, '7c0151a5293ed721df814ffb9c653bded7f1b3ee5cd473b02ec7b34a514be993', '2026-03-01 21:40:41', '2026-02-22 20:40:41'),
(69, 5, '2c5bb49181cd353f221ac39c3aa15813dde590853a408ecf04d11245e9d98536', '2026-03-01 21:40:43', '2026-02-22 20:40:43'),
(70, 5, 'fa996c12ec2f8100f59241bd5492dae36e725c5c7a8d12c47f9f4b57d750bfcd', '2026-03-01 21:40:44', '2026-02-22 20:40:44'),
(71, 5, '91a18dc62ee83207e8d0cb7591a8979cdbdb81bc56e91915d46178241680162e', '2026-03-01 21:40:45', '2026-02-22 20:40:45'),
(72, 5, 'a867f48b23bf5b7cd2cec4691250f410ac59e4bcaa4b3f9d025f5655eae19a87', '2026-03-01 21:40:46', '2026-02-22 20:40:46'),
(73, 5, 'a68f9c95e08a275ae906b232775dd2b8ee3b2f41935a2f06e55a97f1e8793329', '2026-03-01 21:41:03', '2026-02-22 20:41:03'),
(74, 5, 'dd1ebb2e92c7934219ce92c70cf5df267ea4f027f6e090388b06c2d26f8c1c2d', '2026-03-01 21:41:04', '2026-02-22 20:41:04'),
(75, 5, 'aae03b0f95608e813c919bdd3c6a86db9c2a93f49698cacfcb62e9210e8bbe15', '2026-03-01 21:41:05', '2026-02-22 20:41:05'),
(76, 5, 'd9501d20eb36759161a8e45854f29677d9d4776e56a611608c9b94cbdc63687e', '2026-03-01 21:50:00', '2026-02-22 20:50:00'),
(77, 5, '1a22eea7b36e5c28a8fd5344c585c8fa2c477c86e7b9390629b2dc4b84c22b62', '2026-03-01 21:50:02', '2026-02-22 20:50:02'),
(78, 5, 'c8d43b4ac6494fa465b93a4ce1d112b11f2421b90c67f270fc9cfe6f219f48a8', '2026-03-01 21:50:04', '2026-02-22 20:50:04'),
(79, 5, 'e8d50fc4727075bd56caf446dcb908ac3a1a84909a68334141c3df547479aeeb', '2026-03-01 21:50:06', '2026-02-22 20:50:06'),
(80, 5, '8d32d00ad9a27f6f103846bbb6f866fa0a1089688358d827db5d7ecc79468ec0', '2026-03-01 21:50:08', '2026-02-22 20:50:08'),
(81, 5, '3c9667d953ed1b9203331d188f35dddf51e33c830655aa812643ee077cfd35e8', '2026-03-01 21:50:11', '2026-02-22 20:50:11'),
(82, 5, 'f3d0de37e1a9c8483855bf1c0de0315dec5bad01be7cafbefc0fecdc6f9f651d', '2026-03-01 22:28:06', '2026-02-22 21:28:06'),
(83, 5, '41b2f743b0cfb62f375435da44da3a64b2d1749cc698d7a2b30974305ea7dec9', '2026-03-01 22:29:52', '2026-02-22 21:29:52'),
(84, 5, 'f4474565f8eb4294857a86c77c403170bffe9594440fc9356456814b1247b343', '2026-03-01 22:36:03', '2026-02-22 21:36:03'),
(85, 5, '5727498c0c3f82ff39ec90be23949fc37f7c4fa4d888466ba773a773952e64c1', '2026-03-01 22:40:47', '2026-02-22 21:40:47'),
(89, 3, '31fb373b94b461c3fa095dc8c098cf9618b12aa208f2d19790f7803d19f5ec4a', '2026-03-01 22:48:39', '2026-02-22 21:48:39'),
(91, 6, '7b728cae4e6932ebd409132310cbcdc1931377678fd11509af519e19956268bd', '2026-03-01 22:50:08', '2026-02-22 21:50:08'),
(96, 3, '7ee695f7bf1c48005927040e2c4f9169ceddf3052e3fe9dafd719a4b428ed172', '2026-03-01 22:56:38', '2026-02-22 21:56:38'),
(97, 3, 'e9f4b23c315e592f8c119cfb91f034e41ec7ae59875d6805cb634e55bc7ab2bf', '2026-03-01 22:59:50', '2026-02-22 21:59:50'),
(98, 3, '4c24199949a9222e1b89ad5b4be812f76916fcfe161ff4859da192593169c4a6', '2026-03-01 23:03:32', '2026-02-22 22:03:32'),
(104, 3, 'c2741d8116f686767ecb741aac08360a53ba6b3cc42dbb560552c56b2cd6464b', '2026-03-02 07:50:37', '2026-02-23 06:50:37'),
(112, 5, 'c1bf9a0d953eb7143cead7586095d99e68df15937a18691fa49967df8aa08c58', '2026-03-02 08:05:14', '2026-02-23 07:05:14'),
(117, 3, '04409a775f7d62228d9518e7240fd5d2abf1fc0a5b7f17cc8137ba34b70fbeb8', '2026-03-02 14:17:58', '2026-02-23 13:17:58'),
(118, 3, '6873075bedbed7144ada6046f409b6da228dfe4039aff0464686a5861ccc6f33', '2026-03-03 09:59:10', '2026-02-24 08:59:11'),
(121, 3, '5ede5e0557f8884157f50d59334c32863000004b2bd7af6244fadfe5a3c0b456', '2026-03-03 10:01:11', '2026-02-24 09:01:11'),
(122, 5, '210efb4026def4489e4fa255d229fd69216524c7503ecdce9e8c4e42871e4f18', '2026-03-03 10:01:29', '2026-02-24 09:01:29'),
(125, 6, '537aa859d188fc2b5bd454ff6b5400da510bf61a7c5a6484a4badd96625052d3', '2026-03-03 19:25:50', '2026-02-24 18:25:50'),
(127, 3, '952d13460e372b5ae74b7dd541b8dbc3476eac491067a4045c7cd99d2d1cf220', '2026-03-03 20:54:53', '2026-02-24 19:54:53');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Network Issue'),
(2, 'Software Problem'),
(3, 'Hardware Problem'),
(4, 'Login Issue'),
(5, 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `ticket_id`, `user_id`, `message`, `created_at`) VALUES
(1, 1, 5, 'Help this boy fast fast', '2026-02-22 21:54:32'),
(2, 3, 5, 'Working on it', '2026-02-23 06:52:29'),
(3, 3, 3, 'worked om it already you can access now', '2026-02-23 06:54:01'),
(4, 3, 3, 'we have worked on it', '2026-02-23 10:28:39');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `user_id`, `token_hash`, `expires_at`, `used_at`, `created_at`) VALUES
(1, 6, '829041950f200e25c0e747e4ea9578920e533cf1d62ec4aecb7afdc1a27964f3', '2026-02-22 23:28:47', NULL, '2026-02-22 21:58:47');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `ticket_no` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `priority` enum('low','medium','high') DEFAULT 'medium',
  `status` enum('open','assigned','in_progress','resolved','closed') DEFAULT 'open',
  `assigned_to` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `ticket_no`, `user_id`, `category_id`, `title`, `description`, `priority`, `status`, `assigned_to`, `created_at`, `updated_at`) VALUES
(1, 'TCK-20260222-E244A2', 5, 1, 'Network', 'I\'m only able to use 2G network ', 'medium', 'resolved', 3, '2026-02-22 21:29:10', '2026-02-23 13:17:52'),
(2, 'TCK-20260222-304E51', 6, 3, 'On/Off', 'i\'m failing to power on my lapton', 'high', 'assigned', 3, '2026-02-22 21:53:21', '2026-02-22 21:56:21'),
(3, 'TCK-20260223-24A28B', 6, 4, 'Login failed', 'Since the time we repoerted in campus i can\'t access my portal', 'medium', 'closed', 3, '2026-02-23 06:43:47', '2026-02-23 06:58:44');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','technician','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password_hash`, `role`, `created_at`) VALUES
(1, 'System Admin', 'admin@gmail.com', '$2y$10$wH9Jm4PzKzvX0UuCqG9b7eXzS1uK0rZKxP5yJvX1mG5C0YvM3zO3K', 'admin', '2026-02-22 19:32:42'),
(2, 'Technician One', 'tech@gmail.com', '$2y$10$wH9Jm4PzKzvX0UuCqG9b7eXzS1uK0rZKxP5yJvX1mG5C0YvM3zO3K', 'technician', '2026-02-22 19:32:42'),
(3, 'Joseph Mwewa', 'josephmwewa2891@gmail.com', '$2y$10$jlpHEHNBWaZOEDmhwxHuG.Lu6DHbnaAVoP2ko1VVtuVQyVeSAZXEW', 'technician', '2026-02-22 19:34:50'),
(5, 'Jackson', 'josephmwewa@gmail.com', '$2y$10$Jnd2BOhUDyGY9UJOi2rtnuOatHK4GL9PINct9m6lzSRPo7PFxPYGS', 'admin', '2026-02-22 19:36:49'),
(6, 'Akim Banda', 'akimbanda@gmail.com', '$2y$10$S5UawXUnbLqzKm/zJeBjvOtvnR1LTGAuaug6.vEeCB9XpfpSM4k0G', 'user', '2026-02-22 21:49:53'),
(7, 'Prenon Mpanga', 'prenonmpanga@gmail.com', '$2y$10$fbcakbrF5s14S27ecbplz.OF8WxT8IU/jZvMeI1Pgq3MyjzAvwMFu', 'user', '2026-02-23 06:56:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `token_hash` (`token_hash`),
  ADD KEY `expires_at` (`expires_at`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `token_hash` (`token_hash`),
  ADD KEY `expires_at` (`expires_at`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_no` (`ticket_no`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD CONSTRAINT `auth_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `fk_password_resets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
