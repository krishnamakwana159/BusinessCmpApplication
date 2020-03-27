USE [master]
GO
/****** Object:  Database [BusinessCmpDb]    Script Date: 27-03-2020 21:21:05 ******/
CREATE DATABASE [BusinessCmpDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BusinessCmpDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BusinessCmpDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BusinessCmpDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BusinessCmpDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BusinessCmpDb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BusinessCmpDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BusinessCmpDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BusinessCmpDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BusinessCmpDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BusinessCmpDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BusinessCmpDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BusinessCmpDb] SET  MULTI_USER 
GO
ALTER DATABASE [BusinessCmpDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BusinessCmpDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BusinessCmpDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BusinessCmpDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BusinessCmpDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BusinessCmpDb] SET QUERY_STORE = OFF
GO
USE [BusinessCmpDb]
GO
/****** Object:  Table [dbo].[Units]    Script Date: 27-03-2020 21:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Units](
	[UnitId] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Units] PRIMARY KEY CLUSTERED 
(
	[UnitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 27-03-2020 21:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectTitle] [varchar](20) NOT NULL,
	[UnitId] [int] NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 27-03-2020 21:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Address] [varchar](30) NOT NULL,
	[ContactNo] [bigint] NOT NULL,
	[Gender] [varchar](10) NOT NULL,
	[UnitId] [int] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmplpoyeeDetails]    Script Date: 27-03-2020 21:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmplpoyeeDetails](
	[EmployeeDetailId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
 CONSTRAINT [PK_EmplpoyeeDetails] PRIMARY KEY CLUSTERED 
(
	[EmployeeDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vProjectEmployeeDetails]    Script Date: 27-03-2020 21:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vProjectEmployeeDetails]
AS
SELECT        dbo.Projects.ProjectTitle, dbo.Units.UnitName, dbo.Employees.Name, dbo.Employees.Address, dbo.Employees.ContactNo, dbo.Employees.Gender, dbo.EmplpoyeeDetails.EmployeeDetailId, dbo.Employees.EmployeeId, 
                         dbo.Projects.ProjectId
FROM            dbo.Projects INNER JOIN
                         dbo.Units ON dbo.Projects.UnitId = dbo.Units.UnitId INNER JOIN
                         dbo.Employees ON dbo.Units.UnitId = dbo.Employees.UnitId INNER JOIN
                         dbo.EmplpoyeeDetails ON dbo.Projects.ProjectId = dbo.EmplpoyeeDetails.ProjectId AND dbo.Employees.EmployeeId = dbo.EmplpoyeeDetails.EmployeeId
GO
/****** Object:  Table [dbo].[ProjectManagers]    Script Date: 27-03-2020 21:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectManagers](
	[ProjectManagerId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeDetailId] [int] NOT NULL,
 CONSTRAINT [PK_ProjectManagers] PRIMARY KEY CLUSTERED 
(
	[ProjectManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vManagerDetails]    Script Date: 27-03-2020 21:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vManagerDetails]
AS
SELECT        dbo.Projects.ProjectTitle, dbo.Units.UnitName, dbo.Employees.Name, dbo.Employees.Address, dbo.Employees.ContactNo, dbo.Employees.Gender, dbo.ProjectManagers.ProjectManagerId
FROM            dbo.ProjectManagers INNER JOIN
                         dbo.EmplpoyeeDetails ON dbo.ProjectManagers.EmployeeDetailId = dbo.EmplpoyeeDetails.EmployeeDetailId INNER JOIN
                         dbo.Employees ON dbo.EmplpoyeeDetails.EmployeeId = dbo.Employees.EmployeeId INNER JOIN
                         dbo.Projects ON dbo.EmplpoyeeDetails.ProjectId = dbo.Projects.ProjectId INNER JOIN
                         dbo.Units ON dbo.Employees.UnitId = dbo.Units.UnitId AND dbo.Projects.UnitId = dbo.Units.UnitId
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Units] FOREIGN KEY([UnitId])
REFERENCES [dbo].[Units] ([UnitId])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Units]
GO
ALTER TABLE [dbo].[EmplpoyeeDetails]  WITH CHECK ADD  CONSTRAINT [FK_EmplpoyeeDetails_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[EmplpoyeeDetails] CHECK CONSTRAINT [FK_EmplpoyeeDetails_Employees]
GO
ALTER TABLE [dbo].[EmplpoyeeDetails]  WITH CHECK ADD  CONSTRAINT [FK_EmplpoyeeDetails_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[EmplpoyeeDetails] CHECK CONSTRAINT [FK_EmplpoyeeDetails_Projects]
GO
ALTER TABLE [dbo].[ProjectManagers]  WITH CHECK ADD  CONSTRAINT [FK_ProjectManagers_EmplpoyeeDetails] FOREIGN KEY([EmployeeDetailId])
REFERENCES [dbo].[EmplpoyeeDetails] ([EmployeeDetailId])
GO
ALTER TABLE [dbo].[ProjectManagers] CHECK CONSTRAINT [FK_ProjectManagers_EmplpoyeeDetails]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_Units] FOREIGN KEY([UnitId])
REFERENCES [dbo].[Units] ([UnitId])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_Units]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[58] 4[3] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProjectManagers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EmplpoyeeDetails"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 119
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Employees"
            Begin Extent = 
               Top = 6
               Left = 478
               Bottom = 171
               Right = 648
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Projects"
            Begin Extent = 
               Top = 176
               Left = 480
               Bottom = 289
               Right = 650
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Units"
            Begin Extent = 
               Top = 101
               Left = 761
               Bottom = 197
               Right = 931
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vManagerDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vManagerDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vManagerDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[67] 4[5] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Projects"
            Begin Extent = 
               Top = 72
               Left = 706
               Bottom = 185
               Right = 876
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Units"
            Begin Extent = 
               Top = 177
               Left = 409
               Bottom = 273
               Right = 579
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Employees"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 189
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EmplpoyeeDetails"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 131
               Right = 457
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProjectEmployeeDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProjectEmployeeDetails'
GO
USE [master]
GO
ALTER DATABASE [BusinessCmpDb] SET  READ_WRITE 
GO
