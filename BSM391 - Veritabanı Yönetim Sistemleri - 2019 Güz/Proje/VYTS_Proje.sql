USE [master]
GO
/****** Object:  Database [dbOnur]    Script Date: 16.12.2019 01:45:10 ******/
CREATE DATABASE [dbOnur]
GO
ALTER DATABASE [dbOnur] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbOnur].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbOnur] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbOnur] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbOnur] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbOnur] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbOnur] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbOnur] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbOnur] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbOnur] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbOnur] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbOnur] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbOnur] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbOnur] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbOnur] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbOnur] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbOnur] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbOnur] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [dbOnur] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbOnur] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [dbOnur] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbOnur] SET  MULTI_USER 
GO
ALTER DATABASE [dbOnur] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbOnur] SET QUERY_STORE = ON
GO
ALTER DATABASE [dbOnur] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [dbOnur]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PAUSED_RESUMABLE_INDEX_ABORT_DURATION_MINUTES = 1440;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET VERBOSE_TRUNCATION_WARNINGS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
ALTER AUTHORIZATION ON DATABASE::[dbOnur] TO [onurgule]
GO
USE [dbOnur]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 16.12.2019 01:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
ALTER AUTHORIZATION ON [dbo].[fn_diagramobjects] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Action]    Script Date: 16.12.2019 01:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Action](
	[GID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Date] [datetime] NULL,
	[BID] [int] NOT NULL,
	[UID] [int] NOT NULL,
 CONSTRAINT [PK_Action] PRIMARY KEY CLUSTERED 
(
	[GID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Action] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Budgets]    Script Date: 16.12.2019 01:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Budgets](
	[BID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[BTID] [int] NULL,
	[Oncelik] [int] NOT NULL,
 CONSTRAINT [PK_Budgets] PRIMARY KEY CLUSTERED 
(
	[BID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Budgets] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[BudgetTypes]    Script Date: 16.12.2019 01:45:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BudgetTypes](
	[BTID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_BudgetTypes] PRIMARY KEY CLUSTERED 
(
	[BTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[BudgetTypes] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Diller]    Script Date: 16.12.2019 01:45:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diller](
	[DID] [int] IDENTITY(1,1) NOT NULL,
	[Dil] [nvarchar](10) NULL,
 CONSTRAINT [PK_Diller] PRIMARY KEY CLUSTERED 
(
	[DID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Diller] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Girisler]    Script Date: 16.12.2019 01:45:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Girisler](
	[GID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [int] NOT NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_Girisler] PRIMARY KEY CLUSTERED 
(
	[GID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Girisler] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Iller]    Script Date: 16.12.2019 01:45:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Iller](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sehir] [nvarchar](255) NULL,
 CONSTRAINT [PK_iller] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Iller] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Joins]    Script Date: 16.12.2019 01:45:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Joins](
	[PID] [int] IDENTITY(1,1) NOT NULL,
	[BID] [int] NOT NULL,
	[UID] [int] NOT NULL,
 CONSTRAINT [PK_Joins] PRIMARY KEY CLUSTERED 
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Joins] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Kurlar]    Script Date: 16.12.2019 01:45:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kurlar](
	[KID] [int] IDENTITY(1,1) NOT NULL,
	[PBID] [int] NULL,
	[Kur] [float] NULL,
 CONSTRAINT [PK_Kurlar] PRIMARY KEY CLUSTERED 
(
	[KID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Kurlar] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Oncelikler]    Script Date: 16.12.2019 01:45:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oncelikler](
	[OID] [int] IDENTITY(1,1) NOT NULL,
	[Oncelik] [nchar](10) NULL,
 CONSTRAINT [PK_Oncelikler] PRIMARY KEY CLUSTERED 
(
	[OID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Oncelikler] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[ParaBirimleri]    Script Date: 16.12.2019 01:45:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParaBirimleri](
	[PBID] [int] IDENTITY(1,1) NOT NULL,
	[ParaBirimi] [nvarchar](25) NULL,
	[Simge] [nvarchar](5) NULL,
 CONSTRAINT [PK_ParaBirimleri] PRIMARY KEY CLUSTERED 
(
	[PBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[ParaBirimleri] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 16.12.2019 01:45:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[sysdiagrams] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Users]    Script Date: 16.12.2019 01:45:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Ad] [nvarchar](50) NULL,
	[Soyad] [nvarchar](50) NULL,
	[DefaultBudget] [int] NULL,
	[Yetki] [int] NOT NULL,
	[Sehir] [int] NULL,
	[IslemHacmi] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Users] TO  SCHEMA OWNER 
GO
/****** Object:  Table [dbo].[Yetkiler]    Script Date: 16.12.2019 01:45:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yetkiler](
	[YID] [int] NOT NULL,
	[Yetki] [nvarchar](50) NULL,
 CONSTRAINT [PK_Yetkiler] PRIMARY KEY CLUSTERED 
(
	[YID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER AUTHORIZATION ON [dbo].[Yetkiler] TO  SCHEMA OWNER 
GO
SET IDENTITY_INSERT [dbo].[Action] ON 

INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (35, 1, CAST(15.00 AS Decimal(18, 2)), N'Felaj', CAST(N'2019-12-08T22:32:04.823' AS DateTime), 26, 11)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (36, 1, CAST(6161.00 AS Decimal(18, 2)), N'hehe', CAST(N'2019-12-08T22:35:03.853' AS DateTime), 28, 11)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (37, 0, CAST(66.00 AS Decimal(18, 2)), N'gege', CAST(N'2019-12-08T22:35:30.840' AS DateTime), 28, 11)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (40, 1, CAST(255.00 AS Decimal(18, 2)), N'Falan', CAST(N'2019-12-15T18:04:37.433' AS DateTime), 29, 1)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (41, 0, CAST(55.00 AS Decimal(18, 2)), N'filan', CAST(N'2019-12-15T18:05:20.007' AS DateTime), 29, 1)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (42, 1, CAST(500.00 AS Decimal(18, 2)), N'KYK Bursu', CAST(N'2019-12-15T18:34:41.717' AS DateTime), 30, 12)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (43, 0, CAST(768.00 AS Decimal(18, 2)), N'Harç', CAST(N'2019-12-15T18:35:03.657' AS DateTime), 30, 12)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (44, 1, CAST(200.00 AS Decimal(18, 2)), N'Burs', CAST(N'2019-12-15T18:36:41.070' AS DateTime), 30, 13)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (45, 1, CAST(250.00 AS Decimal(18, 2)), N'Mutfak', CAST(N'2019-12-15T18:37:41.223' AS DateTime), 31, 13)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (46, 1, CAST(200.00 AS Decimal(18, 2)), N'Aylık Bütçe', CAST(N'2019-12-15T18:51:56.820' AS DateTime), 23, 1)
INSERT [dbo].[Action] ([GID], [Type], [Amount], [Description], [Date], [BID], [UID]) VALUES (47, 0, CAST(8.00 AS Decimal(18, 2)), N'Pazartesi günü', CAST(N'2019-12-15T18:52:05.050' AS DateTime), 23, 1)
SET IDENTITY_INSERT [dbo].[Action] OFF
SET IDENTITY_INSERT [dbo].[Budgets] ON 

INSERT [dbo].[Budgets] ([BID], [Name], [CreatedDate], [BTID], [Oncelik]) VALUES (15, N'HaneButcesi', CAST(N'2019-12-08T18:42:54.413' AS DateTime), 1, 3)
INSERT [dbo].[Budgets] ([BID], [Name], [CreatedDate], [BTID], [Oncelik]) VALUES (23, N'Yaman Bütçesi', CAST(N'2019-12-08T19:19:04.410' AS DateTime), 3, 1)
INSERT [dbo].[Budgets] ([BID], [Name], [CreatedDate], [BTID], [Oncelik]) VALUES (26, N'SonikiButcem', CAST(N'2019-12-08T19:31:34.167' AS DateTime), 2, 1)
INSERT [dbo].[Budgets] ([BID], [Name], [CreatedDate], [BTID], [Oncelik]) VALUES (28, N'Sonuc4butcem', CAST(N'2019-12-08T19:34:34.010' AS DateTime), 2, 1)
INSERT [dbo].[Budgets] ([BID], [Name], [CreatedDate], [BTID], [Oncelik]) VALUES (29, N'SonButcesi', CAST(N'2019-12-15T15:04:25.803' AS DateTime), 5, 2)
INSERT [dbo].[Budgets] ([BID], [Name], [CreatedDate], [BTID], [Oncelik]) VALUES (30, N'Universite', CAST(N'2019-12-15T15:34:23.293' AS DateTime), 4, 2)
INSERT [dbo].[Budgets] ([BID], [Name], [CreatedDate], [BTID], [Oncelik]) VALUES (31, N'House', CAST(N'2019-12-15T15:37:09.787' AS DateTime), 1, 1)
INSERT [dbo].[Budgets] ([BID], [Name], [CreatedDate], [BTID], [Oncelik]) VALUES (32, N'Web Server', CAST(N'2019-12-15T15:51:39.103' AS DateTime), 2, 3)
SET IDENTITY_INSERT [dbo].[Budgets] OFF
SET IDENTITY_INSERT [dbo].[BudgetTypes] ON 

INSERT [dbo].[BudgetTypes] ([BTID], [Type]) VALUES (1, N'Ev')
INSERT [dbo].[BudgetTypes] ([BTID], [Type]) VALUES (2, N'Araç')
INSERT [dbo].[BudgetTypes] ([BTID], [Type]) VALUES (3, N'Yemek')
INSERT [dbo].[BudgetTypes] ([BTID], [Type]) VALUES (4, N'Okul')
INSERT [dbo].[BudgetTypes] ([BTID], [Type]) VALUES (5, N'Genel')
SET IDENTITY_INSERT [dbo].[BudgetTypes] OFF
SET IDENTITY_INSERT [dbo].[Diller] ON 

INSERT [dbo].[Diller] ([DID], [Dil]) VALUES (1, N'Türkçe')
INSERT [dbo].[Diller] ([DID], [Dil]) VALUES (2, N'English')
SET IDENTITY_INSERT [dbo].[Diller] OFF
SET IDENTITY_INSERT [dbo].[Girisler] ON 

INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (1, 1, CAST(N'2019-12-07T16:57:49.557' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (2, 1, CAST(N'2019-12-08T17:54:18.263' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (3, 1, CAST(N'2019-12-08T17:55:19.860' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (5, 1, CAST(N'2019-12-08T18:26:43.807' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (6, 1, CAST(N'2019-12-08T19:09:59.983' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (7, 11, CAST(N'2019-12-08T19:26:43.983' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (8, 1, CAST(N'2019-12-08T19:53:50.840' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (9, 1, CAST(N'2019-12-15T14:37:26.000' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (10, 1, CAST(N'2019-12-15T15:28:35.817' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (11, 12, CAST(N'2019-12-15T15:29:32.183' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (12, 13, CAST(N'2019-12-15T15:35:54.807' AS DateTime))
INSERT [dbo].[Girisler] ([GID], [UID], [Date]) VALUES (13, 1, CAST(N'2019-12-15T15:39:23.210' AS DateTime))
SET IDENTITY_INSERT [dbo].[Girisler] OFF
SET IDENTITY_INSERT [dbo].[Iller] ON 

INSERT [dbo].[Iller] ([id], [sehir]) VALUES (1, N'ADANA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (2, N'ADIYAMAN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (3, N'AFYON')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (4, N'AĞRI')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (5, N'AMASYA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (6, N'ANKARA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (7, N'ANTALYA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (8, N'ARTVİN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (9, N'AYDIN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (10, N'BALIKESİR')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (11, N'BİLECİK')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (12, N'BİNGÖL')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (13, N'BİTLİS')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (14, N'BOLU')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (15, N'BURDUR')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (16, N'BURSA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (17, N'ÇANAKKALE')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (18, N'ÇANKIRI')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (19, N'ÇORUM')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (20, N'DENİZLİ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (21, N'DİYARBAKIR')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (22, N'EDİRNE')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (23, N'ELAZIĞ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (24, N'ERZİNCAN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (25, N'ERZURUM')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (26, N'ESKİŞEHİR')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (27, N'GAZİANTEP')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (28, N'GİRESUN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (29, N'GÜMÜŞHANE')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (30, N'HAKKARİ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (31, N'HATAY')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (32, N'ISPARTA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (33, N'İÇEL')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (34, N'İSTANBUL')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (35, N'İZMİR')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (36, N'KARS')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (37, N'KASTAMONU')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (38, N'KAYSERİ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (39, N'KIRKLARELİ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (40, N'KIRŞEHİR')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (41, N'KOCAELİ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (42, N'KONYA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (43, N'KÜTAHYA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (44, N'MALATYA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (45, N'MANİSA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (46, N'KAHRAMANMARAŞ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (47, N'MARDİN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (48, N'MUĞLA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (49, N'MUŞ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (50, N'NEVŞEHİR')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (51, N'NİĞDE')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (52, N'ORDU')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (53, N'RİZE')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (54, N'SAKARYA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (55, N'SAMSUN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (56, N'SİİRT')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (57, N'SİNOP')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (58, N'SİVAS')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (59, N'TEKİRDAĞ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (60, N'TOKAT')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (61, N'TRABZON')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (62, N'TUNCELİ')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (63, N'ŞANLIURFA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (64, N'UŞAK')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (65, N'VAN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (66, N'YOZGAT')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (67, N'ZONGULDAK')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (68, N'AKSARAY')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (69, N'BAYBURT')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (70, N'KARAMAN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (71, N'KIRIKKALE')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (72, N'BATMAN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (73, N'ŞIRNAK')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (74, N'BARTIN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (75, N'ARDAHAN')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (76, N'IĞDIR')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (77, N'YALOVA')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (78, N'KARABÜK')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (79, N'KİLİS')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (80, N'OSMANİYE')
INSERT [dbo].[Iller] ([id], [sehir]) VALUES (81, N'DÜZCE')
SET IDENTITY_INSERT [dbo].[Iller] OFF
SET IDENTITY_INSERT [dbo].[Joins] ON 

INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (14, 15, 7)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (22, 23, 1)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (25, 26, 11)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (27, 28, 11)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (28, 28, 1)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (29, 28, 5)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (30, 29, 1)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (31, 30, 12)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (32, 30, 13)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (33, 31, 13)
INSERT [dbo].[Joins] ([PID], [BID], [UID]) VALUES (34, 32, 1)
SET IDENTITY_INSERT [dbo].[Joins] OFF
SET IDENTITY_INSERT [dbo].[Kurlar] ON 

INSERT [dbo].[Kurlar] ([KID], [PBID], [Kur]) VALUES (1, 1, 1)
INSERT [dbo].[Kurlar] ([KID], [PBID], [Kur]) VALUES (2, 2, 5.78)
INSERT [dbo].[Kurlar] ([KID], [PBID], [Kur]) VALUES (3, 3, 6.39)
SET IDENTITY_INSERT [dbo].[Kurlar] OFF
SET IDENTITY_INSERT [dbo].[Oncelikler] ON 

INSERT [dbo].[Oncelikler] ([OID], [Oncelik]) VALUES (1, N'Acil      ')
INSERT [dbo].[Oncelikler] ([OID], [Oncelik]) VALUES (2, N'Normal    ')
INSERT [dbo].[Oncelikler] ([OID], [Oncelik]) VALUES (3, N'Önemsiz   ')
SET IDENTITY_INSERT [dbo].[Oncelikler] OFF
SET IDENTITY_INSERT [dbo].[ParaBirimleri] ON 

INSERT [dbo].[ParaBirimleri] ([PBID], [ParaBirimi], [Simge]) VALUES (1, N'Türk Lirası', N'₺')
INSERT [dbo].[ParaBirimleri] ([PBID], [ParaBirimi], [Simge]) VALUES (2, N'Amerikan Doları', N'$')
INSERT [dbo].[ParaBirimleri] ([PBID], [ParaBirimi], [Simge]) VALUES (3, N'Euro', N'€')
SET IDENTITY_INSERT [dbo].[ParaBirimleri] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (1, N'onurgule@gmail.com', N'112233Onur', N'Onur Osman', N'Güle', 23, 1, 34, CAST(593.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (2, N'fatiheniskaya@gmail.com', N'112233Fatih', N'Fatih Enis', N'Kaya', NULL, 1, 16, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (4, N'fek@gmail.co', N'fekfek', N'fek', N'fek', NULL, 0, 54, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (5, N'fekkaya@gmail.com', N'112233', N'Fatih', N'Kaya', 28, 0, 54, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (7, N'sau@sau.com', N'112233', N'Sakarya', N'Uni', NULL, 0, 54, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (9, N'deleted@noseta.com', N'123123123', N'Deleted', N'User', NULL, 0, 34, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (11, N'ttt@ttt.com', N'112233', N'TestUser', N'User', 28, 0, 22, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (12, N'mart@nisan.com', N'123123', N'Ocak', N'Subat', 30, 0, 18, CAST(1268.00 AS Decimal(18, 2)))
INSERT [dbo].[Users] ([UID], [Email], [Password], [Ad], [Soyad], [DefaultBudget], [Yetki], [Sehir], [IslemHacmi]) VALUES (13, N'ho@gmail.com', N'123123', N'Hasan', N'Ozdemir', 31, 0, 12, CAST(450.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Users] OFF
INSERT [dbo].[Yetkiler] ([YID], [Yetki]) VALUES (0, N'User')
INSERT [dbo].[Yetkiler] ([YID], [Yetki]) VALUES (1, N'Admin')
INSERT [dbo].[Yetkiler] ([YID], [Yetki]) VALUES (2, N'Advisor')
/****** Object:  Index [IX_Kurlar]    Script Date: 16.12.2019 01:45:18 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Kurlar] ON [dbo].[Kurlar]
(
	[PBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 16.12.2019 01:45:18 ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users]    Script Date: 16.12.2019 01:45:18 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users] ON [dbo].[Users]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[Action] ADD  CONSTRAINT [DF_Action_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Budgets] ADD  CONSTRAINT [DF_Budgets_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Budgets] ADD  CONSTRAINT [DF_Budgets_BTID]  DEFAULT ((5)) FOR [BTID]
GO
ALTER TABLE [dbo].[Budgets] ADD  CONSTRAINT [DF_Budgets_Oncelik]  DEFAULT ((2)) FOR [Oncelik]
GO
ALTER TABLE [dbo].[Girisler] ADD  CONSTRAINT [DF_Girisler_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Yetki]  DEFAULT ((0)) FOR [Yetki]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Hacim]  DEFAULT ((0)) FOR [IslemHacmi]
GO
ALTER TABLE [dbo].[Action]  WITH CHECK ADD  CONSTRAINT [FK_Action_Budgets] FOREIGN KEY([BID])
REFERENCES [dbo].[Budgets] ([BID])
GO
ALTER TABLE [dbo].[Action] CHECK CONSTRAINT [FK_Action_Budgets]
GO
ALTER TABLE [dbo].[Action]  WITH CHECK ADD  CONSTRAINT [FK_Action_Users] FOREIGN KEY([UID])
REFERENCES [dbo].[Users] ([UID])
GO
ALTER TABLE [dbo].[Action] CHECK CONSTRAINT [FK_Action_Users]
GO
ALTER TABLE [dbo].[Budgets]  WITH CHECK ADD  CONSTRAINT [FK_Budgets_BudgetTypes] FOREIGN KEY([BTID])
REFERENCES [dbo].[BudgetTypes] ([BTID])
GO
ALTER TABLE [dbo].[Budgets] CHECK CONSTRAINT [FK_Budgets_BudgetTypes]
GO
ALTER TABLE [dbo].[Budgets]  WITH CHECK ADD  CONSTRAINT [FK_Budgets_Oncelikler] FOREIGN KEY([Oncelik])
REFERENCES [dbo].[Oncelikler] ([OID])
GO
ALTER TABLE [dbo].[Budgets] CHECK CONSTRAINT [FK_Budgets_Oncelikler]
GO
ALTER TABLE [dbo].[Girisler]  WITH CHECK ADD  CONSTRAINT [FK_Girisler_Users] FOREIGN KEY([UID])
REFERENCES [dbo].[Users] ([UID])
GO
ALTER TABLE [dbo].[Girisler] CHECK CONSTRAINT [FK_Girisler_Users]
GO
ALTER TABLE [dbo].[Joins]  WITH CHECK ADD  CONSTRAINT [FK_Joins_Budgets] FOREIGN KEY([BID])
REFERENCES [dbo].[Budgets] ([BID])
GO
ALTER TABLE [dbo].[Joins] CHECK CONSTRAINT [FK_Joins_Budgets]
GO
ALTER TABLE [dbo].[Joins]  WITH CHECK ADD  CONSTRAINT [FK_Joins_Users] FOREIGN KEY([UID])
REFERENCES [dbo].[Users] ([UID])
GO
ALTER TABLE [dbo].[Joins] CHECK CONSTRAINT [FK_Joins_Users]
GO
ALTER TABLE [dbo].[Kurlar]  WITH CHECK ADD  CONSTRAINT [FK_Kurlar_Kurlar] FOREIGN KEY([PBID])
REFERENCES [dbo].[ParaBirimleri] ([PBID])
GO
ALTER TABLE [dbo].[Kurlar] CHECK CONSTRAINT [FK_Kurlar_Kurlar]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Budgets] FOREIGN KEY([DefaultBudget])
REFERENCES [dbo].[Budgets] ([BID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Budgets]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Iller] FOREIGN KEY([Sehir])
REFERENCES [dbo].[Iller] ([id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Iller]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Yetkiler1] FOREIGN KEY([Yetki])
REFERENCES [dbo].[Yetkiler] ([YID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Yetkiler1]
GO
/****** Object:  StoredProcedure [dbo].[ButceOlustur]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ButceOlustur] @Name nvarchar(50), @BTID int, @Oncelik int, @UID int
AS
BEGIN
DECLARE @BID int
INSERT INTO Budgets("Name", BTID, Oncelik) VALUES(@Name, @BTID, @Oncelik);
SET @BID = SCOPE_IDENTITY();
INSERT INTO Joins(BID, "UID") VALUES(@BID,@UID);
END
GO
ALTER AUTHORIZATION ON [dbo].[ButceOlustur] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[ButceSil]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ButceSil] @BID int    --Ya da CREATE PROC StokDurumu 
AS
DELETE FROM Budgets WHERE BID = @BID
GO
ALTER AUTHORIZATION ON [dbo].[ButceSil] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[GirisYap]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GirisYap] @Email nvarchar(100), @Password nvarchar(50)
AS
BEGIN
INSERT INTO Girisler(UID) VALUES((SELECT UID FROM Users u WHERE u.Email = @Email AND u.Password = @Password))
SELECT * FROM Users u WHERE u.Email = @Email AND u.Password = @Password
END
GO
ALTER AUTHORIZATION ON [dbo].[GirisYap] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[KayitOl]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KayitOl] @Ad nvarchar(50), @Soyad nvarchar(50), @Email nvarchar(100), @Password nvarchar(50), @Sehir int
AS
IF((SELECT COUNT(*) FROM Users WHERE Email = @Email) > 0)
BEGIN
RAISERROR ('Email bulunmakta...',10,1)
END
ELSE
BEGIN
INSERT INTO Users(Ad, Soyad, Email, "Password", Sehir) VALUES(@Ad,@Soyad,@Email,@Password,@Sehir)
END
GO
ALTER AUTHORIZATION ON [dbo].[KayitOl] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
ALTER AUTHORIZATION ON [dbo].[sp_alterdiagram] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
ALTER AUTHORIZATION ON [dbo].[sp_creatediagram] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
ALTER AUTHORIZATION ON [dbo].[sp_dropdiagram] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
ALTER AUTHORIZATION ON [dbo].[sp_helpdiagramdefinition] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
ALTER AUTHORIZATION ON [dbo].[sp_helpdiagrams] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
ALTER AUTHORIZATION ON [dbo].[sp_renamediagram] TO  SCHEMA OWNER 
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
ALTER AUTHORIZATION ON [dbo].[sp_upgraddiagrams] TO  SCHEMA OWNER 
GO
/****** Object:  Trigger [dbo].[IslemHacmiGuncelleme]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Trigger [dbo].[IslemHacmiGuncelleme] ON [dbo].[Action]
AFTER INSERT
AS
UPDATE Users SET IslemHacmi = IslemHacmi + (SELECT Amount FROM inserted) WHERE UID IN (SELECT UID FROM inserted)
GO
ALTER TABLE [dbo].[Action] ENABLE TRIGGER [IslemHacmiGuncelleme]
GO
/****** Object:  Trigger [dbo].[BudgetSilimi]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[BudgetSilimi]
    ON [dbo].[Budgets]
    INSTEAD OF DELETE
AS
    DELETE FROM dbo.Joins WHERE BID IN (SELECT BID FROM deleted);
	DELETE FROM dbo.Action WHERE BID IN (SELECT BID FROM deleted);
	DELETE FROM dbo.Budgets WHERE BID IN (SELECT BID FROM deleted);
GO
ALTER TABLE [dbo].[Budgets] ENABLE TRIGGER [BudgetSilimi]
GO
/****** Object:  Trigger [dbo].[AutoDefaultBudget]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[AutoDefaultBudget] ON [dbo].[Joins]
AFTER INSERT
AS
IF ((SELECT DefaultBudget FROM Users u WHERE u.UID IN (SELECT UID FROM inserted)) IS NULL)
BEGIN
UPDATE Users SET DefaultBudget = (SELECT BID FROM inserted) WHERE UID IN (SELECT UID FROM inserted)
END
GO
ALTER TABLE [dbo].[Joins] ENABLE TRIGGER [AutoDefaultBudget]
GO
/****** Object:  Trigger [dbo].[UserSilimi]    Script Date: 16.12.2019 01:45:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UserSilimi]
    ON [dbo].[Users]
    INSTEAD OF DELETE
AS
    DELETE FROM dbo.Joins WHERE UID IN (SELECT UID FROM deleted);
	UPDATE Action SET UID = 9 WHERE UID IN (SELECT UID FROM deleted);
	DELETE FROM dbo.Girisler WHERE UID IN (SELECT UID FROM deleted);
	DELETE FROM dbo.Users WHERE UID IN (SELECT UID FROM deleted);
GO
ALTER TABLE [dbo].[Users] ENABLE TRIGGER [UserSilimi]
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
USE [master]
GO
ALTER DATABASE [dbOnur] SET  READ_WRITE 
GO
