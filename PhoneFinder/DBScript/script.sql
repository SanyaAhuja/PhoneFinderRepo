USE [master]
GO
/****** Object:  Database [PhoneFinderDB]    Script Date: 7/24/2019 3:34:05 PM ******/
CREATE DATABASE [PhoneFinderDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestDB', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\TestDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestDB_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\TestDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PhoneFinderDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PhoneFinderDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PhoneFinderDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [PhoneFinderDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PhoneFinderDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PhoneFinderDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PhoneFinderDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PhoneFinderDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PhoneFinderDB] SET  MULTI_USER 
GO
ALTER DATABASE [PhoneFinderDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PhoneFinderDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PhoneFinderDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PhoneFinderDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [PhoneFinderDB]
GO
/****** Object:  StoredProcedure [dbo].[GetId]    Script Date: 7/24/2019 3:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE[dbo].[GetId]
AS
BEGIN


	 select id, imagepath, name,BrandId,OSId from Phone
END
GO
/****** Object:  StoredProcedure [dbo].[GetMenu]    Script Date: 7/24/2019 3:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMenu]
as
begin
	select * from Brand
	select * from OS
	select id, imagepath, name from Phone
end

GO
/****** Object:  StoredProcedure [dbo].[getPhone]    Script Date: 7/24/2019 3:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getPhone]
				@Id INT
AS
BEGIN
		SET NOCOUNT ON;
		SELECT
			--Phone.BrandId,
			Brand.Name,
			Phone.Name as phonename,
			Phone.Price,
			Phone.Dimension,
			Phone.ReleasedDate,
			Phone.ImagePath,
			OS.Name osname
			--Brand.Id
			--Phone.OSId
			
			FROM Phone
			INNER JOIN Brand ON Phone.BrandId = Brand.Id
			INNER JOIN OS on Phone.OSId = OS.OSId
			WHERE Phone.Id=@Id;
			 
END;
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 7/24/2019 3:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[Id] [int] NULL,
	[Name] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OS]    Script Date: 7/24/2019 3:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OS](
	[OSId] [nchar](10) NULL,
	[Name] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Phone]    Script Date: 7/24/2019 3:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phone](
	[Id] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[BrandId] [int] NULL,
	[OSId] [int] NULL,
	[Price] [int] NULL,
	[Dimension] [nvarchar](50) NULL,
	[ReleasedDate] [datetime] NULL,
	[IsTouch] [bit] NULL,
	[ImagePath] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[Brand] ([Id], [Name]) VALUES (1, N'Samsung')
INSERT [dbo].[Brand] ([Id], [Name]) VALUES (2, N'Apple')
INSERT [dbo].[Brand] ([Id], [Name]) VALUES (3, N'OnePlus')
INSERT [dbo].[Brand] ([Id], [Name]) VALUES (4, N'Google')
INSERT [dbo].[Brand] ([Id], [Name]) VALUES (5, N'Blackberry')
INSERT [dbo].[OS] ([OSId], [Name]) VALUES (N'1         ', N'Android')
INSERT [dbo].[OS] ([OSId], [Name]) VALUES (N'2         ', N'iOS')
INSERT [dbo].[OS] ([OSId], [Name]) VALUES (N'3         ', N'Blackberry')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (1, N'Samsung Galaxy Fold', 1, 1, 97000, N' 160.9*117.9*6.9mm', CAST(0x0000AA5F00000000 AS DateTime), 1, N'Content\Images\samsung galaxy fold.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (2, N' Samsung S10', 1, 1, 69999, N'149.9*70.4*7.8 mm', CAST(0x0000AA0300000000 AS DateTime), 1, N'Content\Images\samsung s10.jpeg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (3, N'Samsung M10', 1, 1, 8182, N'155.6*75.6*7.7mm', CAST(0x0000A9E700000000 AS DateTime), 1, N'Content\Images\samsung m10.jpeg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (4, N'Samsung Galaxy J6', 1, 1, 10350, N'149.3*70.2*8.2mm', CAST(0x0000A8D300000000 AS DateTime), 1, N'Content\Images\samsung-galaxy-j6-.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (5, N'Samsung Galaxy S9', 1, 1, 44400, N'147.7*68.7 *8.5mm', CAST(0x0000A87A00000000 AS DateTime), 1, N'Content\Images\samsung s9.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (6, N'iPhone XS', 2, 2, 94900, N'143.6*70.9*7.7mm', CAST(0x0000A94E00000000 AS DateTime), 1, N'Content\Images\iphone-xs.png')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (7, N'iPhone XR', 2, 2, 54999, N'150.9*75.7*8.3mm', CAST(0x0000A8D300000000 AS DateTime), 1, N'Content\Images\iphone-xr.png')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (8, N'iPhone 8', 2, 2, 56999, N'138.4*67.3*7.3mm', CAST(0x0000A7E100000000 AS DateTime), 1, N'Content\Images\iphone8.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (9, N'iPhone 7', 2, 2, 45999, N'138.3*67.1*7.1mm', CAST(0x0000A67400000000 AS DateTime), 1, N'Content\Images\iphone7.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (10, N'iPhone 6', 2, 2, 32999, N'138.1*67 *6.9mm', CAST(0x0000A39900000000 AS DateTime), 1, N'Content\Images\iphone 6.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (11, N'OnePlus 7', 3, 1, 32999, N'157.7*74.8*8.2 mm', CAST(0x0000AA5F00000000 AS DateTime), 1, N'Content\Images\oneplus7.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (12, N'OnePlus 6', 3, 1, 27999, N'155.7 *75.4*7.8mm', CAST(0x0000A8D300000000 AS DateTime), 1, N'Content\Images\oneplus-6.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (13, N'OnePlus 5', 3, 1, 24999, N'154.8*74.1*7.3mm', CAST(0x0000A78500000000 AS DateTime), 1, N'Content\Images\oneplus 5.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (14, N'OnePlus 3', 3, 1, 20999, N'152.7*74.7*7.4mm', CAST(0x0000A61800000000 AS DateTime), 1, N'Content\Images\oneplus-3.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (15, N'OnePlus 2', 3, 1, 17999, N'151.8*74.9*9.9mm', CAST(0x0000A4E700000000 AS DateTime), 1, N'Content\Images\OnePlus-2.png')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (16, N'Google Pixel 3a', 4, 1, 39899, N'151.3*70.1*8.2mm', CAST(0x0000AA4000000000 AS DateTime), 1, N'Content\Images\google pixel 3a.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (17, N'Google Pixel 3', 4, 1, 56598, N'145.6*68.2*7.9mm', CAST(0x0000A96C00000000 AS DateTime), 1, N'Content\Images\google pixel 3.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (18, N'Google Pixel 2', 4, 1, 45200, N'145.7*69.7*7.8mm', CAST(0x0000A7FF00000000 AS DateTime), 1, N'Content\Images\google pixel 2.jpeg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (19, N'Google Pixel XL', 4, 1, 47590, N'154.7*75.7*8.5mm', CAST(0x0000A69200000000 AS DateTime), 1, N'Content\Images\google-pixel-xl.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (20, N'Google Pixel', 4, 1, 57000, N'143.8*69.5*8.5mm', CAST(0x0000A69200000000 AS DateTime), 1, N'Content\Images\google pixel.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (21, N'Blackberry KEY2LE', 5, 3, 31990, N'150.3*71.8*8.4mm', CAST(0x0000A92F00000000 AS DateTime), 0, N'Content\Images\Blackberry-Key2le.png')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (22, N'Blackberry Passport', 5, 3, 16725, N'128*90.3*9.3mm', CAST(0x0000A33D00000000 AS DateTime), 0, N'Content\Images\blackberry_passport.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (23, N'Blackberry Q10', 5, 3, 8499, N'119.6*66.8*10.4mm', CAST(0x0000A13900000000 AS DateTime), 0, N'Content\Images\blackberry-q10.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (24, N'Blackberry Curve 9350', 5, 3, 9999, N'109*60*11mm', CAST(0x00009F5100000000 AS DateTime), 0, N'Content\Images\blackberry curve 9320.jpg')
INSERT [dbo].[Phone] ([Id], [Name], [BrandId], [OSId], [Price], [Dimension], [ReleasedDate], [IsTouch], [ImagePath]) VALUES (25, N'Blackberry Bold touch', 5, 3, 7999, N'115*66*10.5mm', CAST(0x00009ED600000000 AS DateTime), 0, N'Content\Images\blackberry-bold.png')
USE [master]
GO
ALTER DATABASE [PhoneFinderDB] SET  READ_WRITE 
GO
