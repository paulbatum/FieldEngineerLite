-- * This script is a modified version of the Field Engineer setup script
-- * available at: https://code.msdn.microsoft.com/Field-Engineer-501df99d
--
-- Running Locally:
--		1. Update the web.config MS_TableConnectionString with the database you ran this script on
-- 
-- Running against SQL Azure for use from your own mobile service:
--		1. Create the mobile service before running this script
--		2. Do a find and replace on this file from [dbo] to [yourmobileservicename]
--		3. Run the script against the database you configured your mobile service with
--		4. If you are setting up AAD auth and you want some jobs assigned to your AAD users,
--		find the variable declarations for @agent1ID and @agent2ID and replace them with
--		the AAD object IDs of your users



/****** Object:  Table [dbo].[Customer]    Script Date: 5/5/2014 8:08:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Customer](
	[AdditionalContactNumber] [varchar](50) NULL,
	[County] [varchar](50) NULL,
	[FullName] [varchar](50) NULL,
	[HouseNumberOrName] [varchar](50) NULL,
	[Id] [varchar](50) NOT NULL,
	[Latitude] [decimal](9, 6) NULL,
	[Longitude] [decimal](9, 6) NULL,
	[Postcode] [varchar](50) NULL,
	[PrimaryContactNumber] [varchar](50) NULL,
	[Street] [varchar](50) NULL,
	[Town] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Equipment]    Script Date: 5/5/2014 8:08:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Equipment](
	[Description] [varchar](150) NULL,
	[Id] [varchar](50) NOT NULL,
	[EquipmentNumber] [varchar](50) NULL,
	[FullImage] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[ThumbImage] [varchar](50) NULL,
 CONSTRAINT [PK_Equipment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EquipmentIds]    Script Date: 5/5/2014 8:08:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EquipmentIds](
	[JobId] [varchar](50) NOT NULL,
	[EquipmentId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EquipmentIds] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[EquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EquipmentSpecification]    Script Date: 5/5/2014 8:08:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EquipmentSpecification](
	[EquipmentId] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Value] [varchar](50) NULL,
	[Id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EquipmentSpecification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Job]    Script Date: 5/5/2014 8:08:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Job](
	[CustomerId] [varchar](50) NULL,
	[EndTime] [datetimeoffset](7) NULL,
	[EtaTime] [varchar](50) NULL,
	[Id] [varchar](50) NOT NULL,
	[JobNumber] [varchar](50) NULL,
	[StartTime] [datetimeoffset](7) NULL,
	[Status] [varchar](50) NULL,
	[Title] [varchar](50) NULL,
	[AgentId] [nvarchar](50) NULL,
 CONSTRAINT [PK_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JobHistory]    Script Date: 5/5/2014 8:08:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JobHistory](
	[ActionBy] [varchar](50) NULL,
	[Comments] [varchar](50) NULL,
	[JobId] [varchar](50) NULL,
	[TimeStamp] [datetimeoffset](7) NULL,
	[Id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_JobHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO


ALTER TABLE [dbo].[Job] ADD 
    CreatedAt datetimeoffset(7) NULL,
    Deleted bit Not NULL DEFAULT 0 ,
    UpdatedAt datetimeoffset(7) NULL,
    Version timestamp 
GO

ALTER TABLE [dbo].[JobHistory] ADD 
    CreatedAt datetimeoffset(7) NULL,
    Deleted bit Not NULL DEFAULT 0 ,
    UpdatedAt datetimeoffset(7) NULL,
    Version timestamp 
GO

ALTER TABLE [dbo].[Equipment] ADD 
    CreatedAt datetimeoffset(7) NULL,
    Deleted bit Not NULL DEFAULT 0 ,
    UpdatedAt datetimeoffset(7) NULL,
    Version timestamp 
GO

ALTER TABLE [dbo].[EquipmentSpecification] ADD 
    CreatedAt datetimeoffset(7) NULL,
    Deleted bit Not NULL DEFAULT 0 ,
    UpdatedAt datetimeoffset(7) NULL,
    Version timestamp 
GO

ALTER TABLE [dbo].[Customer] ADD 
    CreatedAt datetimeoffset(7) NULL,
    Deleted bit Not NULL DEFAULT 0 ,
    UpdatedAt datetimeoffset(7) NULL,
    Version timestamp 
GO

ALTER TABLE [dbo].[Job] ADD 
  CONSTRAINT DF_Job_CreatedAt 
  DEFAULT (CONVERT([datetimeoffset](3),sysutcdatetime(),0)) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[JobHistory] ADD 
  CONSTRAINT DF_JobHistory_CreatedAt 
  DEFAULT (CONVERT([datetimeoffset](3),sysutcdatetime(),0)) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Equipment] ADD 
  CONSTRAINT DF_Equipment_CreatedAt 
  DEFAULT (CONVERT([datetimeoffset](3),sysutcdatetime(),0)) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[EquipmentSpecification] ADD 
  CONSTRAINT DF_EquipmentSpecification_CreatedAt 
  DEFAULT (CONVERT([datetimeoffset](3),sysutcdatetime(),0)) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Customer] ADD 
  CONSTRAINT DF_Customer_CreatedAt 
  DEFAULT (CONVERT([datetimeoffset](3),sysutcdatetime(),0)) FOR [CreatedAt]
GO


CREATE TRIGGER [dbo].[Job_InsertUpdateDelete] 
  ON [dbo].[Job] AFTER INSERT, UPDATE, DELETE AS BEGIN 
    UPDATE [dbo].[Job] SET [dbo].[Job].[UpdatedAt] = CONVERT(DATETIMEOFFSET(3), SYSUTCDATETIME()) 
    FROM INSERTED 
    WHERE inserted.[Id] = [dbo].[Job].[Id] END
GO

CREATE TRIGGER [dbo].[JobHistory_InsertUpdateDelete] 
  ON [dbo].[JobHistory] AFTER INSERT, UPDATE, DELETE AS BEGIN 
    UPDATE [dbo].[JobHistory] SET [dbo].[JobHistory].[UpdatedAt] = CONVERT(DATETIMEOFFSET(3), SYSUTCDATETIME()) 
    FROM INSERTED 
    WHERE inserted.[Id] = [dbo].[JobHistory].[Id] END
GO

CREATE TRIGGER [dbo].[Equipment_InsertUpdateDelete] 
  ON [dbo].[Equipment] AFTER INSERT, UPDATE, DELETE AS BEGIN 
    UPDATE [dbo].[Equipment] SET [dbo].[Equipment].[UpdatedAt] = CONVERT(DATETIMEOFFSET(3), SYSUTCDATETIME()) 
    FROM INSERTED 
    WHERE inserted.[Id] = [dbo].[Equipment].[Id] END
GO

CREATE TRIGGER [dbo].[EquipmentSpecification_InsertUpdateDelete] 
  ON [dbo].[EquipmentSpecification] AFTER INSERT, UPDATE, DELETE AS BEGIN 
    UPDATE [dbo].[EquipmentSpecification] SET [dbo].[EquipmentSpecification].[UpdatedAt] = CONVERT(DATETIMEOFFSET(3), SYSUTCDATETIME()) 
    FROM INSERTED 
    WHERE inserted.[Id] = [dbo].[EquipmentSpecification].[Id] END
GO

CREATE TRIGGER [dbo].[Customer_InsertUpdateDelete] 
  ON [dbo].[Customer] AFTER INSERT, UPDATE, DELETE AS BEGIN 
    UPDATE [dbo].[Customer] SET [dbo].[Customer].[UpdatedAt] = CONVERT(DATETIMEOFFSET(3), SYSUTCDATETIME()) 
    FROM INSERTED 
    WHERE inserted.[Id] = [dbo].[Customer].[Id] END
GO

SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customer] ([AdditionalContactNumber], [County], [FullName], [HouseNumberOrName], [Id], [Latitude], [Longitude], [Postcode], [PrimaryContactNumber], [Street], [Town]) VALUES (N'09876 987654', N'Maryland', N'Mrs Erma Singleton', N'2111', N'1', CAST(39.611719 AS Decimal(9, 6)), CAST(-77.034073 AS Decimal(9, 6)), N'MD 33821', N'01234 123456', N'Mill Street', N'Arcadia')
INSERT [dbo].[Customer] ([AdditionalContactNumber], [County], [FullName], [HouseNumberOrName], [Id], [Latitude], [Longitude], [Postcode], [PrimaryContactNumber], [Street], [Town]) VALUES (N'09876 987654', N'Maryland', N'Mr Christian Cowley', N'2', N'2', CAST(39.548535 AS Decimal(9, 6)), CAST(-76.837006 AS Decimal(9, 6)), N'MD 33822', N'01234 123456', N'Fabrikam Way', N'Bracknell')
INSERT [dbo].[Customer] ([AdditionalContactNumber], [County], [FullName], [HouseNumberOrName], [Id], [Latitude], [Longitude], [Postcode], [PrimaryContactNumber], [Street], [Town]) VALUES (N'09876 987654', N'Maryland', N'Ms Wendy Pyle', N'49', N'3', CAST(39.582942 AS Decimal(9, 6)), CAST(-76.795807 AS Decimal(9, 6)), N'MD 33823', N'01234 123456', N'Contoso Street', N'Bracknell')
INSERT [dbo].[Customer] ([AdditionalContactNumber], [County], [FullName], [HouseNumberOrName], [Id], [Latitude], [Longitude], [Postcode], [PrimaryContactNumber], [Street], [Town]) VALUES (N'09876 987654', N'Maryland', N'Mrs Abby McNeil', N'19', N'4', CAST(39.679717 AS Decimal(9, 6)), CAST(-77.183762 AS Decimal(9, 6)), N'MD 33823', N'01234 123456', N'Works Drive', N'Bracknell')
INSERT [dbo].[Customer] ([AdditionalContactNumber], [County], [FullName], [HouseNumberOrName], [Id], [Latitude], [Longitude], [Postcode], [PrimaryContactNumber], [Street], [Town]) VALUES (N'09876 987654', N'Maryland', N'Mr Matt Somerville', N'6', N'5', CAST(39.600403 AS Decimal(9, 6)), CAST(-77.156982 AS Decimal(9, 6)), N'MD 33825', N'01234 123456', N'Fabrikam Crescent', N'Bracknell')
INSERT [dbo].[Customer] ([AdditionalContactNumber], [County], [FullName], [HouseNumberOrName], [Id], [Latitude], [Longitude], [Postcode], [PrimaryContactNumber], [Street], [Town]) VALUES (N'09876 987654', N'Maryland', N'Mr Romeo Cazares', N'10', N'6', CAST(39.558065 AS Decimal(9, 6)), CAST(-77.218781 AS Decimal(9, 6)), N'MD 33833', N'01234 123456', N'Contoso BLVD', N'Bracknell')
INSERT [dbo].[Customer] ([AdditionalContactNumber], [County], [FullName], [HouseNumberOrName], [Id], [Latitude], [Longitude], [Postcode], [PrimaryContactNumber], [Street], [Town]) VALUES (N'09876 987654', N'Maryland', N'Mrs Hallie Mooney', N'21', N'7', CAST(39.665976 AS Decimal(9, 6)), CAST(-76.817093 AS Decimal(9, 6)), N'MD 33831', N'01234 123456', N'Adventure Place', N'Bracknell')
INSERT [dbo].[Customer] ([AdditionalContactNumber], [County], [FullName], [HouseNumberOrName], [Id], [Latitude], [Longitude], [Postcode], [PrimaryContactNumber], [Street], [Town]) VALUES (N'09876 987654', N'Maryland', N'Mrs Antoinette Santiago', N'1', N'8', CAST(39.653289 AS Decimal(9, 6)), CAST(-76.571960 AS Decimal(9, 6)), N'MD 33832', N'01234 123456', N'Fabrikam Common', N'Bracknell')
INSERT [dbo].[Equipment] ([Description], [Id], [EquipmentNumber], [FullImage], [Name], [ThumbImage]) VALUES (N'3D Over HDMI defines input/output protocols for major 3D video formats, paving the way for true 3D gaming and 3D home theater applications', N'1', N'HDMI123456', N'Data/EquipmentImages/HDMI_1.jpg', N'DUAL HDMI 1.4 CABLE', N'Data/EquipmentImages/HDMI_1_Thumb.jpg')
INSERT [dbo].[Equipment] ([Description], [Id], [EquipmentNumber], [FullImage], [Name], [ThumbImage]) VALUES (N'High Speed HDMI Cable, 1080p (Full HD) Supports 3D - Audio Return Channel - 4Kx2K - 1440p - 1080p - Blu-Ray - PS3.', N'2', N'HDMI123457', N'Data/EquipmentImages/HDMI_2.jpg', N'HDMI CABLE 6FT For BLURAY', N'Data/EquipmentImages/HDMI_2_Thumb.jpg')
INSERT [dbo].[Equipment] ([Description], [Id], [EquipmentNumber], [FullImage], [Name], [ThumbImage]) VALUES (N'RCA Cable 30ft/10m Composite Video Audio Projector.
      
Single RCA M-M cable.
Length : 30ft/10m.
RCA M-M type video cable.
    ', N'3', N'RCA123456', N'Data/EquipmentImages/RCA_1.jpg', N'RCA Cable', N'Data/EquipmentImages/RCA_1_Thumb.jpg')
INSERT [dbo].[Equipment] ([Description], [Id], [EquipmentNumber], [FullImage], [Name], [ThumbImage]) VALUES (N'90cm / 36" Offset Satellite Dish Antenna

Offset Angle: 24.62°
Aperture Diameter: 90cm/99cm
    ', N'4', N'DISH123456', N'Data/EquipmentImages/Dish_1.jpg', N'Satellite Dish Antenna ', N'Data/EquipmentImages/Dish_1_Thumb.jpg')
INSERT [dbo].[Equipment] ([Description], [Id], [EquipmentNumber], [FullImage], [Name], [ThumbImage]) VALUES (N'Digital Terrestrial Receiver-MPEG4,H.264, HDMI,USB,PVR,RCA.AV CONNECTOR. ', N'5', N'STB123456', N'Data/EquipmentImages/SetTop_1.jpg', N'Set Top Box', N'Data/EquipmentImages/SetTop_1_Thumb.jpg')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1009786142', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1009786143', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1009986142', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1009986143', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1025687089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1025687089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1025687089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1025689089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1025689089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1025689089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1035687089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1035687089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1035687089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1035689089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1035689089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1035689089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1049586320', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1049586320', N'4')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1049586320', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1049586330', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1049586330', N'4')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1049586330', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1102753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1102753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1102753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1102953551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1102953551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1102953551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1103753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1103753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1103753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1103953551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1103953551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'1103953551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2009786142', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2009786742', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2009986142', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2009986742', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2025687089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2025687089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2025687089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2025689089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2025689089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2025689089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2049586320', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2049586320', N'4')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2049586320', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2102411032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2102411032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2102753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2102753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2102753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2102953551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2102953551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2102953551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2202411032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2202411032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2202471032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2202471032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2202491032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2202491032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2212953765', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2212953765', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2212953765', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2212953965', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2212953965', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2212953965', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2222953765', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2222953765', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2222953765', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2222953965', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2222953965', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2222953965', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2272953765', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2272953765', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2272953765', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2292953765', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2292953765', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2292953765', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2702411032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2702411032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2702753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2702753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2702753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2902411032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2902411032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2902753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2902753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'2902753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3009786142', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3009786742', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3009986142', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3009986742', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3025687089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3025687089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3025687089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3025689089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3025689089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3025689089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3049586320', N'2')
GO
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3049586320', N'4')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3049586320', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3102411032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3102411032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3102753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3102753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3102753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3102953551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3102953551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3102953551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3202411032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3202411032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3202471032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3202471032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3202491032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3202491032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3212953765', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3212953765', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3212953765', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3212953965', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3212953965', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3212953965', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3222953765', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3222953765', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3222953765', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3222953965', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3222953965', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3222953965', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3272953765', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3272953765', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3272953765', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3292953765', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3292953765', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3292953765', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3702411032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3702411032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3702753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3702753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3702753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800682315', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800682315', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800682325', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800682325', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800682375', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800682375', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800682395', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800682395', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800683315', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800683315', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800683325', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800683325', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800683375', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800683375', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800683395', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3800683395', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3902411032', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3902411032', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3902753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3902753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'3902753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7009786142', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7009786143', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7025687089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7025687089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7025687089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7035687089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7035687089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7035687089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7049586320', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7049586320', N'4')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7049586320', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7049586330', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7049586330', N'4')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7049586330', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7102753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7102753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7102753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7103753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7103753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'7103753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9009786142', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9009786143', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9025687089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9025687089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9025687089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9035687089', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9035687089', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9035687089', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9049586320', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9049586320', N'4')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9049586320', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9049586330', N'2')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9049586330', N'4')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9049586330', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9102753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9102753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9102753551', N'5')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9103753551', N'1')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9103753551', N'3')
INSERT [dbo].[EquipmentIds] ([JobId], [EquipmentId]) VALUES (N'9103753551', N'5')
GO
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'1', N'Cable Length', N'1.83 Meters', N'1')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'2', N'Shielding type', N'EMI', N'10')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'2', N'HDMI Certified', N'Yes', N'11')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'2', N'HDCP Compliant', N'Yes', N'12')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'2', N'CEC Compliant', N'Yes', N'13')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'3', N'Cable Length', N'H 30ft / 10m ', N'14')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'3', N'Type', N'RCA MALE ', N'15')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'3', N'Connector A ', N'RCA-Male ', N'16')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'3', N'Connector(s) B', N'RCA-Male', N'17')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'4', N'Offset Angle ', N'24.62°', N'18')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'4', N'Aperture Diameter ', N'90cm/99cm', N'19')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'1', N'Cable Diameter', N'5.5mm', N'2')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'4', N'Ku-Band Gain @ 12.5GHz', N'40.32dB ', N'20')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'4', N'F/D Ratio', N'0.6', N'21')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'4', N'Focus Length', N'24 Inch', N'22')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'4', N'Material', N'Steel', N'23')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'4', N'Finish', N'Polyester Powder Coating', N'24')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'4', N'Mounting Type', N'Pole and Wall', N'25')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'5', N'Heatsinking ', N'Yes,Shell outside', N'26')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'5', N'Encrypt ', N'No', N'27')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'5', N'Video Modulator', N'No', N'28')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'5', N'Tuner Type', N'CAM Tuner Design', N'29')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'1', N'Transfer speed', N'10.2 Gigabits ', N'3')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'5', N'Demodulator Type', N'Embed to main chip set', N'30')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'5', N'Power supply', N'DC 5V2A', N'31')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'5', N'Certification', N'CE authentication by CCS.', N'32')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'1', N'Full HDCP', N'Yes', N'4')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'1', N'XBOX 360', N'Yes', N'5')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'2', N'Connector Type', N'HDMI male to HDMI male', N'6')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'2', N'Connector Finish', N'Gold', N'7')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'2', N'Length', N'6ft ', N'8')
INSERT [dbo].[EquipmentSpecification] ([EquipmentId], [Name], [Value], [Id]) VALUES (N'2', N'Conductor Plating', N'Tin', N'9')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'1009786142', N'6', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', N'77f2c0f9-e715-4a13-8069-38e84bcd2a10')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'1009786143', N'17', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'1009986142', N'57', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'1009986143', N'58', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'1025687089', N'7', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', N'77f2c0f9-e715-4a13-8069-38e84bcd2a10')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'1025689089', N'59', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'1035687089', N'18', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'1035689089', N'60', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'2', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'09:00 AM - 10:00 AM', N'1049586320', N'2', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', N'55740676-8702-4277-9964-8be4f3d8c904')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'2', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'09:00 AM - 10:00 AM', N'1049586330', N'19', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'1102753551', N'1', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', N'77f2c0f9-e715-4a13-8069-38e84bcd2a10')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'1102953551', N'61', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'1103753551', N'20', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'1103953551', N'62', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'1823218759', N'5', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', N'55740676-8702-4277-9964-8be4f3d8c904')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'1823218959', N'63', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'1833218759', N'21', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'1833218959', N'64', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'2009786142', N'9', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'2009786742', N'43', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'2009986142', N'65', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'2009986742', N'66', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'2025687089', N'10', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'2025689089', N'67', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'2', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'09:00 AM - 10:00 AM', N'2049586320', N'11', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'2102411032', N'8', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', N'55740676-8702-4277-9964-8be4f3d8c904')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2102753551', N'12', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2102953551', N'68', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'2202411032', N'14', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'2202471032', N'46', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'2202491032', N'69', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2212953765', N'4', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', N'77f2c0f9-e715-4a13-8069-38e84bcd2a10')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2212953965', N'70', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2222953765', N'15', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2222953965', N'71', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2272953765', N'47', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2292953765', N'72', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'2702411032', N'44', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2702753551', N'45', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'2823218759', N'13', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'2823218959', N'75', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'2823278759', N'48', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'2823298759', N'76', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'2902411032', N'73', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'2902753551', N'74', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'3009786142', N'22', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'3009786742', N'49', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'3009986142', N'77', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'3009986742', N'78', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'3025687089', N'23', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'3025689089', N'79', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'2', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'09:00 AM - 10:00 AM', N'3049586320', N'24', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'3102411032', N'25', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3102753551', N'26', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3102953551', N'80', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'3202411032', N'27', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'3202471032', N'52', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'3202491032', N'81', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3212953765', N'28', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3212953965', N'82', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3222953765', N'29', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3222953965', N'83', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3272953765', N'53', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'4', CAST(0x07CB552E16C874380B5CFE AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3292953765', N'84', CAST(0x07F0B802104443380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'3702411032', N'50', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3702753551', N'51', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'3', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'02:30 PM - 03:30 PM', N'3800682315', N'3', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', N'3b4b0f4b-b827-4c85-a321-08d503038065')
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'3', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'02:30 PM - 03:30 PM', N'3800682325', N'16', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'3', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'02:30 PM - 03:30 PM', N'3800682375', N'54', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'3', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'02:30 PM - 03:30 PM', N'3800682395', N'87', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'3', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'02:30 PM - 03:30 PM', N'3800683315', N'31', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'3', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'02:30 PM - 03:30 PM', N'3800683325', N'32', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'3', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'02:30 PM - 03:30 PM', N'3800683375', N'55', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'3', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'02:30 PM - 03:30 PM', N'3800683395', N'88', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'3823218759', N'30', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'3823218959', N'89', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'3823278759', N'56', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'3823298759', N'90', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'8', NULL, N'10:30 AM - 11:30 AM', N'3902411032', N'85', CAST(0x07785543C51473380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'3902753551', N'86', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'7009786142', N'33', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'7009786143', N'34', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'7025687089', N'35', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'7035687089', N'36', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'2', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'09:00 AM - 10:00 AM', N'7049586320', N'37', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'2', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'09:00 AM - 10:00 AM', N'7049586330', N'38', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'7102753551', N'39', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'7103753551', N'40', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'7823218759', N'41', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'7833218759', N'42', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'9009786142', N'91', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'6', NULL, N'08:30 AM - 09:30 AM', N'9009786143', N'92', CAST(0x0724862D2DC874380B5CFE AS DateTimeOffset), N'On Site', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'9025687089', N'93', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'7', NULL, N'08:30 AM - 09:30 AM', N'9035687089', N'94', CAST(0x0706F424AFAE74380B5CFE AS DateTimeOffset), N'Not Started', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'2', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'09:00 AM - 10:00 AM', N'9049586320', N'95', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'2', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'09:00 AM - 10:00 AM', N'9049586330', N'96', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'Completed', N'Replacement of faulty TV receiver equipment', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'9102753551', N'97', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'1', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'08:30 AM - 09:30 AM', N'9103753551', N'98', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'Completed', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'9823218759', N'99', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
INSERT [dbo].[Job] ([CustomerId], [EndTime], [EtaTime], [Id], [JobNumber], [StartTime], [Status], [Title], [AgentId]) VALUES (N'5', NULL, N'09:00 AM - 10:00 AM', N'9833218759', N'100', CAST(0x07B6CC8CB91373380B5CFE AS DateTimeOffset), N'Not Started', N'New customer installation and setup', NULL)
GO
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'1102753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'1')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'1049586320', CAST(0x0797658C9B6445380B0000 AS DateTimeOffset), N'10')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1833218759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'100')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3009786142', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'101')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3009786142', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'102')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'3025687089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'103')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3025687089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'104')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3025687089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'105')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3025687089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'106')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'3025687089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'107')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3025687089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'108')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'3049586320', CAST(0x0797658C9B6445380B0000 AS DateTimeOffset), N'109')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'1049586320', CAST(0x0797DC02104447380B0000 AS DateTimeOffset), N'11')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'3049586320', CAST(0x0797DC02104447380B0000 AS DateTimeOffset), N'110')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'3049586320', CAST(0x0797658C9B6447380B0000 AS DateTimeOffset), N'111')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3049586320', CAST(0x0797DC02104449380B0000 AS DateTimeOffset), N'112')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'3049586320', CAST(0x0797658C9B6449380B0000 AS DateTimeOffset), N'113')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3049586320', CAST(0x0797DC0210444B380B0000 AS DateTimeOffset), N'114')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3049586320', CAST(0x0797658C9B644B380B0000 AS DateTimeOffset), N'115')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3049586320', CAST(0x0797DC0210444D380B0000 AS DateTimeOffset), N'116')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3049586320', CAST(0x0797658C9B644D380B0000 AS DateTimeOffset), N'117')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'3102753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'118')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'3102753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'119')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'1049586320', CAST(0x0797658C9B6447380B0000 AS DateTimeOffset), N'12')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'3102753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'120')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3102753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'121')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'3102753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'122')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3102753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'123')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3102753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'124')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3102753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'125')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3102753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'126')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'3212953765', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'127')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'3212953765', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'128')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3212953765', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'129')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1049586320', CAST(0x0797DC02104449380B0000 AS DateTimeOffset), N'13')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3212953765', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'130')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3212953765', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'131')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3212953765', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'132')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'3222953765', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'133')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'3222953765', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'134')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3222953765', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'135')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3222953765', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'136')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3222953765', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'137')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3222953765', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'138')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3823218759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'139')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1049586320', CAST(0x0797658C9B6449380B0000 AS DateTimeOffset), N'14')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3823218759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'140')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3800683315', CAST(0x0797DC0210444F380B0000 AS DateTimeOffset), N'141')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3800683315', CAST(0x0797658C9B644F380B0000 AS DateTimeOffset), N'142')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3800683325', CAST(0x0797DC0210444F380B0000 AS DateTimeOffset), N'143')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3800683325', CAST(0x0797658C9B644F380B0000 AS DateTimeOffset), N'144')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7009786142', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'145')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'7009786142', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'146')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7009786143', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'147')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'7009786143', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'148')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'7025687089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'149')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1049586320', CAST(0x0797DC0210444B380B0000 AS DateTimeOffset), N'15')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'7025687089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'150')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'7025687089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'151')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'7025687089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'152')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'7025687089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'153')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7025687089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'154')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'7035687089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'155')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'7035687089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'156')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'7035687089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'157')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'7035687089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'158')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'7035687089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'159')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1049586320', CAST(0x0797658C9B644B380B0000 AS DateTimeOffset), N'16')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7035687089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'160')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'7049586320', CAST(0x0797658C9B6445380B0000 AS DateTimeOffset), N'161')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'7049586320', CAST(0x0797DC02104447380B0000 AS DateTimeOffset), N'162')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'7049586320', CAST(0x0797658C9B6447380B0000 AS DateTimeOffset), N'163')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7049586320', CAST(0x0797DC02104449380B0000 AS DateTimeOffset), N'164')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'7049586320', CAST(0x0797658C9B6449380B0000 AS DateTimeOffset), N'165')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'7049586320', CAST(0x0797DC0210444B380B0000 AS DateTimeOffset), N'166')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'7049586320', CAST(0x0797658C9B644B380B0000 AS DateTimeOffset), N'167')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'7049586320', CAST(0x0797DC0210444D380B0000 AS DateTimeOffset), N'168')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'7049586320', CAST(0x0797658C9B644D380B0000 AS DateTimeOffset), N'169')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1049586320', CAST(0x0797DC0210444D380B0000 AS DateTimeOffset), N'17')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'7049586330', CAST(0x0797658C9B6445380B0000 AS DateTimeOffset), N'170')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'7049586330', CAST(0x0797DC02104447380B0000 AS DateTimeOffset), N'171')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'7049586330', CAST(0x0797658C9B6447380B0000 AS DateTimeOffset), N'172')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7049586330', CAST(0x0797DC02104449380B0000 AS DateTimeOffset), N'173')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'7049586330', CAST(0x0797658C9B6449380B0000 AS DateTimeOffset), N'174')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'7049586330', CAST(0x0797DC0210444B380B0000 AS DateTimeOffset), N'175')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'7049586330', CAST(0x0797658C9B644B380B0000 AS DateTimeOffset), N'176')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'7049586330', CAST(0x0797DC0210444D380B0000 AS DateTimeOffset), N'177')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'7049586330', CAST(0x0797658C9B644D380B0000 AS DateTimeOffset), N'178')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'7102753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'179')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1049586320', CAST(0x0797658C9B644D380B0000 AS DateTimeOffset), N'18')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'7102753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'180')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'7102753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'181')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7102753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'182')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'7102753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'183')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'7102753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'184')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'7102753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'185')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'7102753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'186')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'7102753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'187')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'7103753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'188')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'7103753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'189')
GO
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3800682315', CAST(0x0797DC0210444F380B0000 AS DateTimeOffset), N'19')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'7103753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'190')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7103753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'191')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'7103753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'192')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'7103753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'193')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'7103753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'194')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'7103753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'195')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'7103753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'196')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7823218759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'197')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'7823218759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'198')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'7833218759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'199')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'1102753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'2')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3800682315', CAST(0x0797658C9B644F380B0000 AS DateTimeOffset), N'20')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'7833218759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'200')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2009786742', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'201')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2009786742', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'202')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'2702753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'203')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'2702753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'204')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'2702753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'205')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2702753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'206')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'2702753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'207')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2702753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'208')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2702753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'209')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'2212953765', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'21')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2702753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'210')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2702753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'211')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'2272953765', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'212')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'2272953765', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'213')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2272953765', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'214')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2272953765', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'215')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2272953765', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'216')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2272953765', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'217')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2823278759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'218')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2823278759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'219')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'2212953765', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'22')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3009786742', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'220')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3009786742', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'221')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'3702753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'222')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'3702753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'223')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'3702753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'224')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3702753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'225')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'3702753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'226')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3702753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'227')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3702753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'228')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3702753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'229')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2212953765', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'23')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3702753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'230')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'3272953765', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'231')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'3272953765', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'232')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3272953765', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'233')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3272953765', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'234')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3272953765', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'235')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3272953765', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'236')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3800682375', CAST(0x0797DC0210444F380B0000 AS DateTimeOffset), N'237')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3800682375', CAST(0x0797658C9B644F380B0000 AS DateTimeOffset), N'238')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3800683375', CAST(0x0797DC0210444F380B0000 AS DateTimeOffset), N'239')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2212953765', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'24')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3800683375', CAST(0x0797658C9B644F380B0000 AS DateTimeOffset), N'240')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3823278759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'241')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3823278759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'242')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1009986142', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'243')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1009986142', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'244')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1009986143', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'245')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1009986143', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'246')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1025689089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'247')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1025689089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'248')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1025689089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'249')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2212953765', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'25')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1025689089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'250')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'1025689089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'251')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1025689089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'252')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1035689089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'253')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1035689089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'254')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1035689089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'255')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1035689089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'256')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'1035689089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'257')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1035689089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'258')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'1102953551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'259')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2212953765', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'26')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'1102953551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'260')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'1102953551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'261')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1102953551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'262')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1102953551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'263')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1102953551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'264')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1102953551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'265')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1102953551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'266')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1102953551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'267')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'1103953551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'268')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'1103953551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'269')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1823218759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'27')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'1103953551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'270')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1103953551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'271')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1103953551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'272')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1103953551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'273')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1103953551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'274')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1103953551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'275')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1103953551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'276')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1823218959', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'277')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1823218959', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'278')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1833218959', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'279')
GO
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1823218759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'28')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1833218959', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'280')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2009986142', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'281')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2009986142', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'282')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2009986742', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'283')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2009986742', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'284')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'2025689089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'285')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2025689089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'286')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2025689089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'287')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2025689089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'288')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'2025689089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'289')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1009786142', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'29')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2025689089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'290')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'2102953551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'291')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'2102953551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'292')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'2102953551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'293')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2102953551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'294')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'2102953551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'295')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2102953551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'296')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2102953551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'297')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2102953551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'298')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2102953551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'299')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'1102753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'3')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1009786142', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'30')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'2212953965', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'300')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'2212953965', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'301')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2212953965', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'302')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2212953965', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'303')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2212953965', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'304')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2212953965', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'305')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'2222953965', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'306')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'2222953965', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'307')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2222953965', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'308')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2222953965', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'309')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2222953965', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'310')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2222953965', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'311')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'2292953765', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'312')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'2292953765', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'313')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2292953765', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'314')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2292953765', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'315')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2292953765', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'316')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2292953765', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'317')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'2902753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'318')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'2902753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'319')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'2902753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'320')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2902753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'321')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'2902753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'322')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2902753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'323')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2902753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'324')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2902753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'325')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2902753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'326')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2823218959', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'327')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2823218959', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'328')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2823298759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'329')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2823298759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'330')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3009986142', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'331')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3009986142', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'332')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3009986742', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'333')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3009986742', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'334')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'3025689089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'335')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3025689089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'336')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3025689089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'337')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3025689089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'338')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'3025689089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'339')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3025689089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'340')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'3102953551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'341')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'3102953551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'342')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'3102953551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'343')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3102953551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'344')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'3102953551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'345')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3102953551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'346')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3102953551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'347')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3102953551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'348')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3102953551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'349')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'3212953965', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'350')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'3212953965', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'351')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3212953965', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'352')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3212953965', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'353')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3212953965', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'354')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3212953965', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'355')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'3222953965', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'356')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'3222953965', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'357')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3222953965', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'358')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3222953965', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'359')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3222953965', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'360')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3222953965', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'361')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'3292953765', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'362')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'3292953765', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'363')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3292953765', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'364')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3292953765', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'365')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3292953765', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'366')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3292953765', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'367')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'3902753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'368')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'3902753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'369')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2009786142', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'37')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'3902753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'370')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3902753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'371')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'3902753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'372')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'3902753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'373')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'3902753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'374')
GO
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'3902753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'375')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3902753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'376')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3800682395', CAST(0x0797DC0210444F380B0000 AS DateTimeOffset), N'377')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3800682395', CAST(0x0797658C9B644F380B0000 AS DateTimeOffset), N'378')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3800683395', CAST(0x0797DC0210444F380B0000 AS DateTimeOffset), N'379')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2009786142', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'38')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3800683395', CAST(0x0797658C9B644F380B0000 AS DateTimeOffset), N'380')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3823218959', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'381')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3823218959', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'382')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3823298759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'383')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3823298759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'384')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9009786142', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'385')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'9009786142', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'386')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9009786143', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'387')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'9009786143', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'388')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'9025687089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'389')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'2025687089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'39')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'9025687089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'390')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'9025687089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'391')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'9025687089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'392')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'9025687089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'393')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9025687089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'394')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'9035687089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'395')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'9035687089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'396')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'9035687089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'397')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'9035687089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'398')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'9035687089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'399')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1102753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'4')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2025687089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'40')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9035687089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'400')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'9049586320', CAST(0x0797658C9B6445380B0000 AS DateTimeOffset), N'401')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'9049586320', CAST(0x0797DC02104447380B0000 AS DateTimeOffset), N'402')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'9049586320', CAST(0x0797658C9B6447380B0000 AS DateTimeOffset), N'403')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9049586320', CAST(0x0797DC02104449380B0000 AS DateTimeOffset), N'404')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'9049586320', CAST(0x0797658C9B6449380B0000 AS DateTimeOffset), N'405')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'9049586320', CAST(0x0797DC0210444B380B0000 AS DateTimeOffset), N'406')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'9049586320', CAST(0x0797658C9B644B380B0000 AS DateTimeOffset), N'407')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'9049586320', CAST(0x0797DC0210444D380B0000 AS DateTimeOffset), N'408')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'9049586320', CAST(0x0797658C9B644D380B0000 AS DateTimeOffset), N'409')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2025687089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'41')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'9049586330', CAST(0x0797658C9B6445380B0000 AS DateTimeOffset), N'410')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'9049586330', CAST(0x0797DC02104447380B0000 AS DateTimeOffset), N'411')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'9049586330', CAST(0x0797658C9B6447380B0000 AS DateTimeOffset), N'412')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9049586330', CAST(0x0797DC02104449380B0000 AS DateTimeOffset), N'413')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'9049586330', CAST(0x0797658C9B6449380B0000 AS DateTimeOffset), N'414')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'9049586330', CAST(0x0797DC0210444B380B0000 AS DateTimeOffset), N'415')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'9049586330', CAST(0x0797658C9B644B380B0000 AS DateTimeOffset), N'416')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'9049586330', CAST(0x0797DC0210444D380B0000 AS DateTimeOffset), N'417')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'9049586330', CAST(0x0797658C9B644D380B0000 AS DateTimeOffset), N'418')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'9102753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'419')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2025687089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'42')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'9102753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'420')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'9102753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'421')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9102753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'422')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'9102753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'423')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'9102753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'424')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'9102753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'425')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'9102753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'426')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'9102753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'427')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'9103753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'428')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'9103753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'429')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'2025687089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'43')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'9103753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'430')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9103753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'431')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'9103753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'432')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'9103753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'433')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'9103753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'434')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'9103753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'435')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'9103753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'436')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9823218759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'437')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'9823218759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'438')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'9833218759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'439')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2025687089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'44')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'9833218759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'440')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'2049586320', CAST(0x0797658C9B6445380B0000 AS DateTimeOffset), N'45')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'2049586320', CAST(0x0797DC02104447380B0000 AS DateTimeOffset), N'46')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'2049586320', CAST(0x0797658C9B6447380B0000 AS DateTimeOffset), N'47')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2049586320', CAST(0x0797DC02104449380B0000 AS DateTimeOffset), N'48')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'2049586320', CAST(0x0797658C9B6449380B0000 AS DateTimeOffset), N'49')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1102753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'5')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2049586320', CAST(0x0797DC0210444B380B0000 AS DateTimeOffset), N'50')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2049586320', CAST(0x0797658C9B644B380B0000 AS DateTimeOffset), N'51')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2049586320', CAST(0x0797DC0210444D380B0000 AS DateTimeOffset), N'52')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2049586320', CAST(0x0797658C9B644D380B0000 AS DateTimeOffset), N'53')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'2102753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'54')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'2102753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'55')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'2102753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'56')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2102753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'57')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'2102753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'58')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2102753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'59')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1102753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'6')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2102753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'60')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2102753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'61')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2102753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'62')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'2823218759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'63')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2823218759', CAST(0x0797658C9B6457380B0000 AS DateTimeOffset), N'64')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to completed', N'2222953765', CAST(0x0797DC02104451380B0000 AS DateTimeOffset), N'65')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Updated job status to On Site', N'2222953765', CAST(0x0797658C9B6451380B0000 AS DateTimeOffset), N'66')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'2222953765', CAST(0x0797DC02104453380B0000 AS DateTimeOffset), N'67')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'2222953765', CAST(0x0797658C9B6453380B0000 AS DateTimeOffset), N'68')
GO
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'2222953765', CAST(0x0797DC02104455380B0000 AS DateTimeOffset), N'69')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1102753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'7')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'2222953765', CAST(0x0797658C9B6455380B0000 AS DateTimeOffset), N'70')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'3800682325', CAST(0x0797DC0210444F380B0000 AS DateTimeOffset), N'71')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'3800682325', CAST(0x0797658C9B644F380B0000 AS DateTimeOffset), N'72')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1009786143', CAST(0x0797DC02104459380B0000 AS DateTimeOffset), N'73')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1009786143', CAST(0x0797658C9B6459380B0000 AS DateTimeOffset), N'74')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1035687089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'75')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1035687089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'76')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1035687089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'77')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1035687089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'78')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'1035687089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'79')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1102753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'8')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1035687089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'80')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'1049586330', CAST(0x0797658C9B6445380B0000 AS DateTimeOffset), N'81')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'1049586330', CAST(0x0797DC02104447380B0000 AS DateTimeOffset), N'82')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'1049586330', CAST(0x0797658C9B6447380B0000 AS DateTimeOffset), N'83')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1049586330', CAST(0x0797DC02104449380B0000 AS DateTimeOffset), N'84')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1049586330', CAST(0x0797658C9B6449380B0000 AS DateTimeOffset), N'85')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1049586330', CAST(0x0797DC0210444B380B0000 AS DateTimeOffset), N'86')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1049586330', CAST(0x0797658C9B644B380B0000 AS DateTimeOffset), N'87')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1049586330', CAST(0x0797DC0210444D380B0000 AS DateTimeOffset), N'88')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1049586330', CAST(0x0797658C9B644D380B0000 AS DateTimeOffset), N'89')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1102753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'9')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Updated job status to On Site', N'1103753551', CAST(0x0797DC0210443D380B0000 AS DateTimeOffset), N'90')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Sent an ETA of around 08:58 AM', N'1103753551', CAST(0x0797658C9B643D380B0000 AS DateTimeOffset), N'91')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Al Pardo', N'Accepted job on 26/08/2013 08:21 AM', N'1103753551', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'92')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1103753551', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'93')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1103753551', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'94')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1103753551', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'95')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1103753551', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'96')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1103753551', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'97')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup.', N'1103753551', CAST(0x0797DC02104445380B0000 AS DateTimeOffset), N'98')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1833218759', CAST(0x0797DC02104457380B0000 AS DateTimeOffset), N'99')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Job postponed to 20/08/2013 09:07 AM', N'1025687089', CAST(0x0797DC02104441380B0000 AS DateTimeOffset), N'history10')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Sent an ETA of around 08:55 AM', N'1025687089', CAST(0x0797658C9B6441380B0000 AS DateTimeOffset), N'history11')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roland Earls', N'Accepted job on 20/08/2013 08:15 AM', N'1025687089', CAST(0x0797DC02104443380B0000 AS DateTimeOffset), N'history12')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Scheduled job to 20/08/2013 09:00 AM', N'1025687089', CAST(0x0797658C9B6443380B0000 AS DateTimeOffset), N'history13')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Cecelia Joseph', N'Created new order to install and setup', N'1025687089', CAST(0x0797DC0210443F380B0000 AS DateTimeOffset), N'history14')
INSERT [dbo].[JobHistory] ([ActionBy], [Comments], [JobId], [TimeStamp], [Id]) VALUES (N'Roger Timm', N'Job schedule updated to 26/08/2013 09:00 AM', N'1025687089', CAST(0x0797658C9B643F380B0000 AS DateTimeOffset), N'history9')
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Id]    Script Date: 5/5/2014 8:08:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_Id] ON [dbo].[EquipmentSpecification]
(
	[EquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
ALTER TABLE [dbo].[EquipmentIds]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentIds_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([Id])
GO
ALTER TABLE [dbo].[EquipmentIds] CHECK CONSTRAINT [FK_EquipmentIds_Equipment]
GO
ALTER TABLE [dbo].[EquipmentIds]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentIds_Job] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([Id])
GO
ALTER TABLE [dbo].[EquipmentIds] CHECK CONSTRAINT [FK_EquipmentIds_Job]
GO
ALTER TABLE [dbo].[EquipmentSpecification]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentSpecification_Equipment] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipment] ([Id])
GO
ALTER TABLE [dbo].[EquipmentSpecification] CHECK CONSTRAINT [FK_EquipmentSpecification_Equipment]
GO
ALTER TABLE [dbo].[Job]  WITH CHECK ADD  CONSTRAINT [FK_Job_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Job] CHECK CONSTRAINT [FK_Job_Customer]
GO
ALTER TABLE [dbo].[JobHistory]  WITH CHECK ADD  CONSTRAINT [FK_JobHistory_Job] FOREIGN KEY([JobId])
REFERENCES [dbo].[Job] ([Id])
GO
ALTER TABLE [dbo].[JobHistory] CHECK CONSTRAINT [FK_JobHistory_Job]
GO

-- ASSIGN JOBS

DECLARE @agent1ID varchar(50) = '37e865e8-38f1-4e6b-a8ee-b404a188676e'
DECLARE @agent2ID varchar(50) = '3c15184f-5b06-48cc-bcc8-55b6e621d9d0'

UPDATE [dbo].[Job]
   SET 
      [AgentId] = NULL, 
    [Status] = 'Not Started'

UPDATE [dbo].[Job]
   SET       
    [Status] = 'Completed'
    WHERE Id IN (  SELECT TOP 5 PERCENT Id FROM [dbo].[Job] ORDER BY NEWID())

UPDATE [dbo].[Job]
   SET 
      [AgentId] = @agent1ID
 WHERE Id IN (  SELECT TOP 30 PERCENT Id
  FROM [dbo].[Job]
  WHERE AgentId IS NULL  
  ORDER BY NEWID()
  )

UPDATE [dbo].[Job]
   SET 
      [AgentId] = @agent2ID
 WHERE Id IN (  SELECT TOP 20 PERCENT Id
  FROM [dbo].[Job]
  WHERE AgentId IS NULL  
  ORDER BY NEWID()
  )

  UPDATE [dbo].[Job]
   SET       
    [Status] = 'On Site'
    WHERE Id IN (  SELECT TOP 1 Id FROM [dbo].[Job] WHERE [AgentId] = @agent1ID ORDER BY NEWID())

  UPDATE [dbo].[Job]
   SET       
    [Status] = 'On Site'
    WHERE Id IN (  SELECT TOP 1 Id FROM [dbo].[Job] WHERE [AgentId] = @agent2ID ORDER BY NEWID())
GO


