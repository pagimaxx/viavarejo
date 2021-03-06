USE [master]
GO
/****** Object:  Database [Hangfire]    Script Date: 02/06/2019 23:34:54 ******/
CREATE DATABASE [Hangfire]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hangfire', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Hangfire.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hangfire_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Hangfire_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Hangfire] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hangfire].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hangfire] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hangfire] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hangfire] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hangfire] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hangfire] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hangfire] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hangfire] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hangfire] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hangfire] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hangfire] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hangfire] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hangfire] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hangfire] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hangfire] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hangfire] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Hangfire] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hangfire] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hangfire] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hangfire] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hangfire] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hangfire] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hangfire] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hangfire] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hangfire] SET  MULTI_USER 
GO
ALTER DATABASE [Hangfire] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hangfire] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hangfire] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hangfire] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hangfire] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Hangfire] SET QUERY_STORE = OFF
GO
USE [Hangfire]
GO
/****** Object:  Schema [HangFire]    Script Date: 02/06/2019 23:34:54 ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CX_HangFire_Counter]    Script Date: 02/06/2019 23:34:55 ******/
CREATE CLUSTERED INDEX [CX_HangFire_Counter] ON [HangFire].[Counter]
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](100) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 02/06/2019 23:34:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded', 57, NULL)
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-06-03', 59, CAST(N'2019-07-03T02:26:04.627' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-06-03-01', 42, CAST(N'2019-06-04T01:41:05.290' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-06-03-02', 17, CAST(N'2019-06-04T02:26:04.627' AS DateTime))
INSERT [HangFire].[Counter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded', 1, NULL)
INSERT [HangFire].[Counter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded', 1, NULL)
INSERT [HangFire].[Counter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-06-03', 1, CAST(N'2019-07-03T02:27:04.677' AS DateTime))
INSERT [HangFire].[Counter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-06-03', 1, CAST(N'2019-07-03T02:28:04.957' AS DateTime))
INSERT [HangFire].[Counter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-06-03-02', 1, CAST(N'2019-06-04T02:27:04.677' AS DateTime))
INSERT [HangFire].[Counter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-06-03-02', 1, CAST(N'2019-06-04T02:28:04.957' AS DateTime))
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'CreatedAt', N'2019-06-03T02:08:33.3027166Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'Cron', N'* * * * *', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'Job', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":"[]"}', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'LastExecution', N'2019-06-03T02:28:04.6416273Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'LastJobId', N'72', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'NextExecution', N'2019-06-03T02:29:00.0000000Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'Queue', N'default', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'TimeZoneId', N'UTC', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:AtualizarPedidos', N'V', N'2', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'CreatedAt', N'2019-06-03T01:24:46.4635677Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'Cron', N'* * * * *', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'Job', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":"[\"\\\"Easy!\\\"\"]"}', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'LastExecution', N'2019-06-03T02:28:04.6416273Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'LastJobId', N'73', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'NextExecution', N'2019-06-03T02:29:00.0000000Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'Queue', N'default', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'TimeZoneId', N'UTC', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Console.Write', N'V', N'2', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:delete logs', N'CreatedAt', N'2019-06-03T01:38:05.5012777Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:delete logs', N'Cron', N'* * 30 * *', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:delete logs', N'Job', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":"[]"}', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:delete logs', N'NextExecution', N'2019-06-30T00:00:00.0000000Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:delete logs', N'Queue', N'default', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:delete logs', N'TimeZoneId', N'UTC', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:delete logs', N'V', N'2', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:PedidoCriado', N'CreatedAt', N'2019-06-03T01:38:19.2745708Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:PedidoCriado', N'Cron', N'* * 30 * *', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:PedidoCriado', N'Job', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":"[]"}', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:PedidoCriado', N'NextExecution', N'2019-06-30T00:00:00.0000000Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:PedidoCriado', N'Queue', N'default', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:PedidoCriado', N'TimeZoneId', N'UTC', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:PedidoCriado', N'V', N'2', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'CreatedAt', N'2019-06-03T01:30:29.4580217Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'Cron', N'* * * * *', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'Job', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":"[]"}', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'LastExecution', N'2019-06-03T01:41:04.5346079Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'LastJobId', N'40', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'NextExecution', N'2019-06-03T01:42:00.0000000Z', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'Queue', N'default', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'TimeZoneId', N'UTC', NULL)
INSERT [HangFire].[Hash] ([Key], [Field], [Value], [ExpireAt]) VALUES (N'recurring-job:Startup.VerificaPedidoCriado', N'V', N'2', NULL)
SET IDENTITY_INSERT [HangFire].[Job] ON 

INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (1, 3, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:08:00.267' AS DateTime), CAST(N'2019-06-04T01:08:00.547' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (2, 6, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:08:28.397' AS DateTime), CAST(N'2019-06-04T01:08:29.897' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (3, 9, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:09:44.290' AS DateTime), CAST(N'2019-06-04T01:09:44.623' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (4, 18, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:22:43.590' AS DateTime), CAST(N'2019-06-04T01:23:07.207' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (5, 21, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:23:31.873' AS DateTime), CAST(N'2019-06-04T01:23:32.123' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (6, 24, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:24:45.980' AS DateTime), CAST(N'2019-06-04T01:24:46.580' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (7, 27, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:25:01.470' AS DateTime), CAST(N'2019-06-04T01:25:01.537' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (8, 30, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:26:01.543' AS DateTime), CAST(N'2019-06-04T01:26:01.577' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (9, 33, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:27:01.583' AS DateTime), CAST(N'2019-06-04T01:27:01.617' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (10, 36, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:27:11.890' AS DateTime), CAST(N'2019-06-04T01:27:12.120' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (11, 39, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:28:12.070' AS DateTime), CAST(N'2019-06-04T01:28:12.107' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (12, 42, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:28:57.433' AS DateTime), CAST(N'2019-06-04T01:28:57.683' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (13, 45, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:29:12.610' AS DateTime), CAST(N'2019-06-04T01:29:12.640' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (14, 48, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:30:12.650' AS DateTime), CAST(N'2019-06-04T01:30:12.730' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (15, 51, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:30:29.273' AS DateTime), CAST(N'2019-06-04T01:30:29.517' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (16, 55, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:31:14.487' AS DateTime), CAST(N'2019-06-04T01:31:14.570' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (17, 57, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:31:14.560' AS DateTime), CAST(N'2019-06-04T01:31:14.590' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (18, 62, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:32:14.593' AS DateTime), CAST(N'2019-06-04T01:32:14.670' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (19, 63, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:32:14.650' AS DateTime), CAST(N'2019-06-04T01:32:14.677' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (20, 68, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:33:14.683' AS DateTime), CAST(N'2019-06-04T01:33:14.757' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (21, 69, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:33:14.737' AS DateTime), CAST(N'2019-06-04T01:33:14.760' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (22, 73, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:34:14.763' AS DateTime), CAST(N'2019-06-04T01:34:14.820' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (23, 75, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:34:14.810' AS DateTime), CAST(N'2019-06-04T01:34:14.827' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (24, 80, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:35:14.840' AS DateTime), CAST(N'2019-06-04T01:35:14.930' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (25, 81, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:35:14.907' AS DateTime), CAST(N'2019-06-04T01:35:14.937' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (26, 86, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:36:14.940' AS DateTime), CAST(N'2019-06-04T01:36:15.050' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (27, 87, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:36:15.027' AS DateTime), CAST(N'2019-06-04T01:36:15.057' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (28, 92, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:37:00.063' AS DateTime), CAST(N'2019-06-04T01:37:00.113' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (29, 93, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:37:00.107' AS DateTime), CAST(N'2019-06-04T01:37:00.117' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (30, 98, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:38:00.123' AS DateTime), CAST(N'2019-06-04T01:38:00.180' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (31, 99, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:38:00.167' AS DateTime), CAST(N'2019-06-04T01:38:00.187' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (32, 102, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:38:05.320' AS DateTime), CAST(N'2019-06-04T01:38:05.553' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (33, 105, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:38:18.683' AS DateTime), CAST(N'2019-06-04T01:38:19.503' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (34, 110, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:39:04.240' AS DateTime), CAST(N'2019-06-04T01:39:04.307' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (35, 111, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:39:04.283' AS DateTime), CAST(N'2019-06-04T01:39:04.307' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (36, 116, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:40:04.347' AS DateTime), CAST(N'2019-06-04T01:40:04.453' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (37, 117, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:40:04.420' AS DateTime), CAST(N'2019-06-04T01:40:04.460' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (38, 124, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T01:41:03.777' AS DateTime), CAST(N'2019-06-04T01:41:05.290' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (39, 125, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T01:41:04.727' AS DateTime), CAST(N'2019-06-04T01:41:05.290' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (40, 126, N'Succeeded', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"VerificaPedidoCriado","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T01:41:05.223' AS DateTime), CAST(N'2019-06-04T01:41:05.293' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (41, 129, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T02:07:54.253' AS DateTime), CAST(N'2019-06-04T02:07:55.287' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (42, 132, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:07:55.270' AS DateTime), CAST(N'2019-06-04T02:07:55.460' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (43, 135, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:08:10.480' AS DateTime), CAST(N'2019-06-04T02:08:10.517' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (44, 138, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T02:08:32.600' AS DateTime), CAST(N'2019-06-04T02:08:33.470' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (45, 146, N'Processing', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:09:03.277' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (46, 143, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:09:03.297' AS DateTime), CAST(N'2019-06-04T02:09:03.310' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (47, 149, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Hello world from Hangfire!\""]', CAST(N'2019-06-03T02:16:17.283' AS DateTime), CAST(N'2019-06-04T02:16:17.833' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (48, 148, N'Processing', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:16:17.777' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (49, 152, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:16:17.823' AS DateTime), CAST(N'2019-06-04T02:16:17.857' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (50, 265, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:17:02.867' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (51, 157, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:17:02.877' AS DateTime), CAST(N'2019-06-04T02:17:03.023' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (52, 288, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:18:02.957' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (53, 168, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:18:02.997' AS DateTime), CAST(N'2019-06-04T02:18:03.207' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (54, 323, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:19:03.200' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (55, 183, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:19:03.237' AS DateTime), CAST(N'2019-06-04T02:19:03.373' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (56, 327, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:20:03.313' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (57, 198, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:20:03.327' AS DateTime), CAST(N'2019-06-04T02:20:03.397' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (58, 361, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:21:03.393' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (59, 217, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:21:03.430' AS DateTime), CAST(N'2019-06-04T02:21:03.633' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (60, 357, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:22:03.583' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (61, 236, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:22:03.617' AS DateTime), CAST(N'2019-06-04T02:22:03.817' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (62, 313, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:23:03.760' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (63, 259, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:23:03.797' AS DateTime), CAST(N'2019-06-04T02:23:04.157' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (64, 359, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:24:03.933' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (65, 282, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:24:04.013' AS DateTime), CAST(N'2019-06-04T02:24:04.187' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (66, 342, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:25:04.087' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (67, 301, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:25:04.127' AS DateTime), CAST(N'2019-06-04T02:25:04.370' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (68, 380, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:26:04.403' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (69, 332, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:26:04.440' AS DateTime), CAST(N'2019-06-04T02:26:04.627' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (70, 369, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:27:04.570' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (71, 347, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:27:04.583' AS DateTime), CAST(N'2019-06-04T02:27:04.687' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (72, 376, N'Scheduled', N'{"Type":"JobsHangfire.Startup, JobsHangfire, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"RunAsync","ParameterTypes":"[]","Arguments":null}', N'[]', CAST(N'2019-06-03T02:28:04.647' AS DateTime), NULL)
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (73, 374, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"Write","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Easy!\""]', CAST(N'2019-06-03T02:28:04.687' AS DateTime), CAST(N'2019-06-04T02:28:04.990' AS DateTime))
SET IDENTITY_INSERT [HangFire].[Job] OFF
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (1, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (1, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (2, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (2, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (3, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (3, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (4, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (4, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'Time', N'1559525101')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'Time', N'1559525161')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (9, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (9, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (9, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (9, N'Time', N'1559525221')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (10, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (10, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (11, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (11, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (11, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (11, N'Time', N'1559525292')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (12, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (12, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (13, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (13, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (13, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (13, N'Time', N'1559525352')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (14, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (14, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (14, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (14, N'Time', N'1559525412')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (15, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (15, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (16, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (16, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (16, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (16, N'Time', N'1559525474')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (17, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (17, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (17, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (17, N'Time', N'1559525474')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (18, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (18, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (18, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (18, N'Time', N'1559525534')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (19, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (19, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (19, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (19, N'Time', N'1559525534')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (20, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (20, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (20, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (20, N'Time', N'1559525594')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (21, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (21, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (21, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (21, N'Time', N'1559525594')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (22, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (22, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (22, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (22, N'Time', N'1559525654')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (23, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (23, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (23, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (23, N'Time', N'1559525654')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (24, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (24, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (24, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (24, N'Time', N'1559525714')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (25, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (25, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (25, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (25, N'Time', N'1559525714')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (26, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (26, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (26, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (26, N'Time', N'1559525774')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (27, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (27, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (27, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (27, N'Time', N'1559525774')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (28, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (28, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (28, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (28, N'Time', N'1559525820')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (29, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (29, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (29, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (29, N'Time', N'1559525820')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (30, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (30, N'CurrentUICulture', N'"pt-BR"')
GO
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (30, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (30, N'Time', N'1559525880')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (31, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (31, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (31, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (31, N'Time', N'1559525880')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (32, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (32, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (33, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (33, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (34, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (34, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (34, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (34, N'Time', N'1559525944')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (35, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (35, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (35, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (35, N'Time', N'1559525944')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (36, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (36, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (36, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (36, N'Time', N'1559526004')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (37, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (37, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (37, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (37, N'Time', N'1559526004')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (38, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (38, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (39, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (39, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (39, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (39, N'Time', N'1559526064')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (40, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (40, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (40, N'RecurringJobId', N'"Startup.VerificaPedidoCriado"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (40, N'Time', N'1559526064')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (41, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (41, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (42, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (42, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (42, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (42, N'Time', N'1559527674')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (43, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (43, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (43, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (43, N'Time', N'1559527690')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (44, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (44, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (45, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (45, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (45, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (45, N'Time', N'1559527743')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (46, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (46, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (46, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (46, N'Time', N'1559527743')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (47, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (47, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (48, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (48, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (48, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (48, N'Time', N'1559528177')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (49, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (49, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (49, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (49, N'Time', N'1559528177')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'RetryCount', N'5')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (50, N'Time', N'1559528222')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (51, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (51, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (51, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (51, N'Time', N'1559528222')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'RetryCount', N'5')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (52, N'Time', N'1559528282')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (53, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (53, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (53, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (53, N'Time', N'1559528282')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'RetryCount', N'5')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (54, N'Time', N'1559528343')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (55, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (55, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (55, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (55, N'Time', N'1559528343')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'RetryCount', N'5')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (56, N'Time', N'1559528403')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (57, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (57, N'CurrentUICulture', N'"pt-BR"')
GO
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (57, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (57, N'Time', N'1559528403')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'RetryCount', N'5')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (58, N'Time', N'1559528463')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (59, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (59, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (59, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (59, N'Time', N'1559528463')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'RetryCount', N'5')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (60, N'Time', N'1559528523')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (61, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (61, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (61, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (61, N'Time', N'1559528523')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'RetryCount', N'4')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (62, N'Time', N'1559528583')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (63, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (63, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (63, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (63, N'Time', N'1559528583')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'RetryCount', N'4')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (64, N'Time', N'1559528643')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (65, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (65, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (65, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (65, N'Time', N'1559528643')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'RetryCount', N'3')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (66, N'Time', N'1559528704')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (67, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (67, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (67, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (67, N'Time', N'1559528704')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'RetryCount', N'4')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (68, N'Time', N'1559528764')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (69, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (69, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (69, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (69, N'Time', N'1559528764')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (70, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (70, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (70, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (70, N'RetryCount', N'2')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (70, N'Time', N'1559528824')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (71, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (71, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (71, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (71, N'Time', N'1559528824')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (72, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (72, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (72, N'RecurringJobId', N'"AtualizarPedidos"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (72, N'RetryCount', N'1')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (72, N'Time', N'1559528884')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (73, N'CurrentCulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (73, N'CurrentUICulture', N'"pt-BR"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (73, N'RecurringJobId', N'"Console.Write"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (73, N'Time', N'1559528884')
SET IDENTITY_INSERT [HangFire].[JobQueue] ON 

INSERT [HangFire].[JobQueue] ([Id], [JobId], [Queue], [FetchedAt]) VALUES (47, 45, N'default', NULL)
INSERT [HangFire].[JobQueue] ([Id], [JobId], [Queue], [FetchedAt]) VALUES (50, 48, N'default', NULL)
SET IDENTITY_INSERT [HangFire].[JobQueue] OFF
INSERT [HangFire].[Schema] ([Version]) VALUES (7)
INSERT [HangFire].[Server] ([Id], [Data], [LastHeartbeat]) VALUES (N'laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9', N'{"WorkerCount":20,"Queues":["default"],"StartedAt":"2019-06-03T02:16:17.2010003Z"}', CAST(N'2019-06-03T02:28:17.720' AS DateTime))
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'recurring-jobs', 1559528940, N'AtualizarPedidos', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'recurring-jobs', 1559528940, N'Console.Write', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'recurring-jobs', 1561852800, N'delete logs', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'recurring-jobs', 1561852800, N'PedidoCriado', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'recurring-jobs', -1, N'Startup.VerificaPedidoCriado', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'50', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'52', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'54', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'56', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'58', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'60', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'62', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'64', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'66', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'68', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'70', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'retries', 0, N'72', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559529009, N'50', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559528964, N'52', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559529065, N'54', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559529145, N'56', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559529205, N'58', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559529115, N'60', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559528954, N'62', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559528971, N'64', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559528927, N'66', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559529050, N'68', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559528941, N'70', NULL)
INSERT [HangFire].[Set] ([Key], [Score], [Value], [ExpireAt]) VALUES (N'schedule', 1559528915, N'72', NULL)
SET IDENTITY_INSERT [HangFire].[State] ON 

INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (1, 1, N'Enqueued', NULL, CAST(N'2019-06-03T01:08:00.353' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:08:00.2187213Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (2, 1, N'Processing', NULL, CAST(N'2019-06-03T01:08:00.510' AS DateTime), N'{"StartedAt":"2019-06-03T01:08:00.4407462Z","ServerId":"laptop-70j3qrbr:20412:bfd90970-2a6f-4bc9-b392-6a00d45dfb51","WorkerId":"b2c37d45-7b73-452d-a749-338bd1db3cf7"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (3, 1, N'Succeeded', NULL, CAST(N'2019-06-03T01:08:00.543' AS DateTime), N'{"SucceededAt":"2019-06-03T01:08:00.5345782Z","PerformanceDuration":"19","Latency":"248"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (4, 2, N'Enqueued', NULL, CAST(N'2019-06-03T01:08:29.090' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:08:28.1690520Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (5, 2, N'Processing', NULL, CAST(N'2019-06-03T01:08:29.723' AS DateTime), N'{"StartedAt":"2019-06-03T01:08:29.4929071Z","ServerId":"laptop-70j3qrbr:22204:a366e01b-46ec-4879-96f4-ac52fc4916a6","WorkerId":"802f5245-5b14-43ab-831b-cd14268f2d91"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (6, 2, N'Succeeded', NULL, CAST(N'2019-06-03T01:08:29.887' AS DateTime), N'{"SucceededAt":"2019-06-03T01:08:29.8503244Z","PerformanceDuration":"67","Latency":"1385"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (7, 3, N'Enqueued', NULL, CAST(N'2019-06-03T01:09:44.377' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:09:44.2264370Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (8, 3, N'Processing', NULL, CAST(N'2019-06-03T01:09:44.577' AS DateTime), N'{"StartedAt":"2019-06-03T01:09:44.5205773Z","ServerId":"laptop-70j3qrbr:24492:52526cd8-6c7c-408a-9263-d2d593a444c0","WorkerId":"94f09043-cdd1-49e3-97ec-e4b7549d5c30"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (9, 3, N'Succeeded', NULL, CAST(N'2019-06-03T01:09:44.620' AS DateTime), N'{"SucceededAt":"2019-06-03T01:09:44.6101438Z","PerformanceDuration":"26","Latency":"293"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (10, 4, N'Enqueued', NULL, CAST(N'2019-06-03T01:22:43.823' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:22:43.4831956Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (11, 4, N'Processing', NULL, CAST(N'2019-06-03T01:22:44.123' AS DateTime), N'{"StartedAt":"2019-06-03T01:22:44.0440164Z","ServerId":"laptop-70j3qrbr:27928:fe7408ac-4e24-475c-bd17-3d890a32de66","WorkerId":"07f490e5-6381-4e8c-8d04-998cf48b0644"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (12, 4, N'Succeeded', NULL, CAST(N'2019-06-03T01:22:44.183' AS DateTime), N'{"SucceededAt":"2019-06-03T01:22:44.1747711Z","PerformanceDuration":"41","Latency":"543"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (13, 4, N'Enqueued', N'Triggered via Dashboard UI', CAST(N'2019-06-03T01:23:03.400' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:23:03.3958853Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (14, 4, N'Processing', NULL, CAST(N'2019-06-03T01:23:03.410' AS DateTime), N'{"StartedAt":"2019-06-03T01:23:03.4048886Z","ServerId":"laptop-70j3qrbr:27928:fe7408ac-4e24-475c-bd17-3d890a32de66","WorkerId":"07f490e5-6381-4e8c-8d04-998cf48b0644"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (15, 4, N'Succeeded', NULL, CAST(N'2019-06-03T01:23:03.413' AS DateTime), N'{"SucceededAt":"2019-06-03T01:23:03.4120702Z","PerformanceDuration":"0","Latency":"19821"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (16, 4, N'Enqueued', N'Triggered via Dashboard UI', CAST(N'2019-06-03T01:23:07.190' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:23:07.1874567Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (17, 4, N'Processing', NULL, CAST(N'2019-06-03T01:23:07.197' AS DateTime), N'{"StartedAt":"2019-06-03T01:23:07.1938602Z","ServerId":"laptop-70j3qrbr:27928:fe7408ac-4e24-475c-bd17-3d890a32de66","WorkerId":"07f490e5-6381-4e8c-8d04-998cf48b0644"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (18, 4, N'Succeeded', NULL, CAST(N'2019-06-03T01:23:07.207' AS DateTime), N'{"SucceededAt":"2019-06-03T01:23:07.2043045Z","PerformanceDuration":"1","Latency":"23613"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (19, 5, N'Enqueued', NULL, CAST(N'2019-06-03T01:23:31.943' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:23:31.8296009Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (20, 5, N'Processing', NULL, CAST(N'2019-06-03T01:23:32.087' AS DateTime), N'{"StartedAt":"2019-06-03T01:23:32.0490744Z","ServerId":"laptop-70j3qrbr:31504:386d69e1-524d-49b9-b67e-6970aafe9dff","WorkerId":"33a4229a-ea18-477e-aef2-4f4ea5808b59"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (21, 5, N'Succeeded', NULL, CAST(N'2019-06-03T01:23:32.120' AS DateTime), N'{"SucceededAt":"2019-06-03T01:23:32.1127764Z","PerformanceDuration":"18","Latency":"221"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (22, 6, N'Enqueued', NULL, CAST(N'2019-06-03T01:24:46.293' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:24:45.8653669Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (23, 6, N'Processing', NULL, CAST(N'2019-06-03T01:24:46.513' AS DateTime), N'{"StartedAt":"2019-06-03T01:24:46.4495566Z","ServerId":"laptop-70j3qrbr:30392:ed3c464c-c90d-4ad3-ab9c-cc7d400ed1c7","WorkerId":"c7bedbba-5973-400d-ba42-6037348f0216"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (24, 6, N'Succeeded', NULL, CAST(N'2019-06-03T01:24:46.577' AS DateTime), N'{"SucceededAt":"2019-06-03T01:24:46.5583408Z","PerformanceDuration":"36","Latency":"541"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (25, 7, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:25:01.500' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:25:01.4992667Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (26, 7, N'Processing', NULL, CAST(N'2019-06-03T01:25:01.517' AS DateTime), N'{"StartedAt":"2019-06-03T01:25:01.5105780Z","ServerId":"laptop-70j3qrbr:30392:ed3c464c-c90d-4ad3-ab9c-cc7d400ed1c7","WorkerId":"c7bedbba-5973-400d-ba42-6037348f0216"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (27, 7, N'Succeeded', NULL, CAST(N'2019-06-03T01:25:01.537' AS DateTime), N'{"SucceededAt":"2019-06-03T01:25:01.5309966Z","PerformanceDuration":"2","Latency":"58"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (28, 8, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:26:01.547' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:26:01.5473607Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (29, 8, N'Processing', NULL, CAST(N'2019-06-03T01:26:01.570' AS DateTime), N'{"StartedAt":"2019-06-03T01:26:01.5673321Z","ServerId":"laptop-70j3qrbr:30392:ed3c464c-c90d-4ad3-ab9c-cc7d400ed1c7","WorkerId":"3c807a7e-792c-4431-b014-32ecd12b4072"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (30, 8, N'Succeeded', NULL, CAST(N'2019-06-03T01:26:01.577' AS DateTime), N'{"SucceededAt":"2019-06-03T01:26:01.5743556Z","PerformanceDuration":"1","Latency":"29"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (31, 9, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:27:01.590' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:27:01.5882603Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (32, 9, N'Processing', NULL, CAST(N'2019-06-03T01:27:01.613' AS DateTime), N'{"StartedAt":"2019-06-03T01:27:01.6085583Z","ServerId":"laptop-70j3qrbr:30392:ed3c464c-c90d-4ad3-ab9c-cc7d400ed1c7","WorkerId":"5bfd6617-fed4-49ad-9272-b8c2ef1c8189"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (33, 9, N'Succeeded', NULL, CAST(N'2019-06-03T01:27:01.617' AS DateTime), N'{"SucceededAt":"2019-06-03T01:27:01.6161325Z","PerformanceDuration":"1","Latency":"31"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (34, 10, N'Enqueued', NULL, CAST(N'2019-06-03T01:27:11.960' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:27:11.8248120Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (35, 10, N'Processing', NULL, CAST(N'2019-06-03T01:27:12.083' AS DateTime), N'{"StartedAt":"2019-06-03T01:27:12.0449687Z","ServerId":"laptop-70j3qrbr:26812:48e78ef9-4b97-48ed-9183-067b99611154","WorkerId":"f9c52851-fc32-435c-a9e5-b2c29d678f28"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (36, 10, N'Succeeded', NULL, CAST(N'2019-06-03T01:27:12.117' AS DateTime), N'{"SucceededAt":"2019-06-03T01:27:12.1092635Z","PerformanceDuration":"18","Latency":"200"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (37, 11, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:28:12.080' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:28:12.0803081Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (38, 11, N'Processing', NULL, CAST(N'2019-06-03T01:28:12.103' AS DateTime), N'{"StartedAt":"2019-06-03T01:28:12.1017286Z","ServerId":"laptop-70j3qrbr:26812:48e78ef9-4b97-48ed-9183-067b99611154","WorkerId":"f9c52851-fc32-435c-a9e5-b2c29d678f28"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (39, 11, N'Succeeded', NULL, CAST(N'2019-06-03T01:28:12.107' AS DateTime), N'{"SucceededAt":"2019-06-03T01:28:12.1071837Z","PerformanceDuration":"1","Latency":"35"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (40, 12, N'Enqueued', NULL, CAST(N'2019-06-03T01:28:57.500' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:28:57.3892282Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (41, 12, N'Processing', NULL, CAST(N'2019-06-03T01:28:57.647' AS DateTime), N'{"StartedAt":"2019-06-03T01:28:57.5999778Z","ServerId":"laptop-70j3qrbr:22064:a61d301f-1315-4992-9670-edd38e5205c1","WorkerId":"3452d07d-3601-45bc-a9ab-ef65ac246b0e"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (42, 12, N'Succeeded', NULL, CAST(N'2019-06-03T01:28:57.680' AS DateTime), N'{"SucceededAt":"2019-06-03T01:28:57.6722205Z","PerformanceDuration":"19","Latency":"220"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (43, 13, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:29:12.620' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:29:12.6203651Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (44, 13, N'Processing', NULL, CAST(N'2019-06-03T01:29:12.637' AS DateTime), N'{"StartedAt":"2019-06-03T01:29:12.6361904Z","ServerId":"laptop-70j3qrbr:22064:a61d301f-1315-4992-9670-edd38e5205c1","WorkerId":"3452d07d-3601-45bc-a9ab-ef65ac246b0e"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (45, 13, N'Succeeded', NULL, CAST(N'2019-06-03T01:29:12.640' AS DateTime), N'{"SucceededAt":"2019-06-03T01:29:12.6398524Z","PerformanceDuration":"0","Latency":"29"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (46, 14, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:30:12.663' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:30:12.6635716Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (47, 14, N'Processing', NULL, CAST(N'2019-06-03T01:30:12.720' AS DateTime), N'{"StartedAt":"2019-06-03T01:30:12.7175558Z","ServerId":"laptop-70j3qrbr:22064:a61d301f-1315-4992-9670-edd38e5205c1","WorkerId":"370d84cc-bca9-4d0f-ad6d-8218d22b5074"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (48, 14, N'Succeeded', NULL, CAST(N'2019-06-03T01:30:12.730' AS DateTime), N'{"SucceededAt":"2019-06-03T01:30:12.7269738Z","PerformanceDuration":"2","Latency":"74"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (49, 15, N'Enqueued', NULL, CAST(N'2019-06-03T01:30:29.343' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:30:29.2169992Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (50, 15, N'Processing', NULL, CAST(N'2019-06-03T01:30:29.480' AS DateTime), N'{"StartedAt":"2019-06-03T01:30:29.4402945Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"a5912c82-60c0-40b4-af03-98480d952672"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (51, 15, N'Succeeded', NULL, CAST(N'2019-06-03T01:30:29.513' AS DateTime), N'{"SucceededAt":"2019-06-03T01:30:29.5051018Z","PerformanceDuration":"18","Latency":"213"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (52, 16, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:31:14.513' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:31:14.5122306Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (53, 16, N'Processing', NULL, CAST(N'2019-06-03T01:31:14.563' AS DateTime), N'{"StartedAt":"2019-06-03T01:31:14.5599604Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"e40ed323-e12e-493f-b428-8bfff5cac400"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (55, 16, N'Succeeded', NULL, CAST(N'2019-06-03T01:31:14.570' AS DateTime), N'{"SucceededAt":"2019-06-03T01:31:14.5692560Z","PerformanceDuration":"2","Latency":"79"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (54, 17, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:31:14.567' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:31:14.5652574Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (56, 17, N'Processing', NULL, CAST(N'2019-06-03T01:31:14.573' AS DateTime), N'{"StartedAt":"2019-06-03T01:31:14.5730568Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"f1ffd57d-31f3-429a-839e-695dbc9191b4"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (57, 17, N'Succeeded', NULL, CAST(N'2019-06-03T01:31:14.590' AS DateTime), N'{"SucceededAt":"2019-06-03T01:31:14.5870503Z","PerformanceDuration":"8","Latency":"18"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (58, 18, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:32:14.607' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:32:14.6049795Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (60, 18, N'Processing', NULL, CAST(N'2019-06-03T01:32:14.657' AS DateTime), N'{"StartedAt":"2019-06-03T01:32:14.6542862Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"1dce9773-e5f2-495f-948b-05e00aa84c48"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (62, 18, N'Succeeded', NULL, CAST(N'2019-06-03T01:32:14.670' AS DateTime), N'{"SucceededAt":"2019-06-03T01:32:14.6682053Z","PerformanceDuration":"3","Latency":"71"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (59, 19, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:32:14.653' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:32:14.6544472Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (61, 19, N'Processing', NULL, CAST(N'2019-06-03T01:32:14.667' AS DateTime), N'{"StartedAt":"2019-06-03T01:32:14.6662028Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"eff04bfe-6bba-4ee0-8d66-5203948aa575"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (63, 19, N'Succeeded', NULL, CAST(N'2019-06-03T01:32:14.677' AS DateTime), N'{"SucceededAt":"2019-06-03T01:32:14.6751634Z","PerformanceDuration":"1","Latency":"23"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (64, 20, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:33:14.693' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:33:14.6931289Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (66, 20, N'Processing', NULL, CAST(N'2019-06-03T01:33:14.743' AS DateTime), N'{"StartedAt":"2019-06-03T01:33:14.7402926Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"5045348b-1b61-46ee-8400-6ca7ad69d25d"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (68, 20, N'Succeeded', NULL, CAST(N'2019-06-03T01:33:14.757' AS DateTime), N'{"SucceededAt":"2019-06-03T01:33:14.7538089Z","PerformanceDuration":"4","Latency":"66"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (65, 21, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:33:14.740' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:33:14.7407773Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (67, 21, N'Processing', NULL, CAST(N'2019-06-03T01:33:14.753' AS DateTime), N'{"StartedAt":"2019-06-03T01:33:14.7500309Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"94b65b94-0200-4d7c-8c65-e2850e5d7af9"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (69, 21, N'Succeeded', NULL, CAST(N'2019-06-03T01:33:14.760' AS DateTime), N'{"SucceededAt":"2019-06-03T01:33:14.7584948Z","PerformanceDuration":"1","Latency":"19"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (70, 22, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:34:14.770' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:34:14.7706373Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (71, 22, N'Processing', NULL, CAST(N'2019-06-03T01:34:14.810' AS DateTime), N'{"StartedAt":"2019-06-03T01:34:14.8092375Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"f5315081-3d20-4593-aa03-871ee88c224c"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (73, 22, N'Succeeded', NULL, CAST(N'2019-06-03T01:34:14.820' AS DateTime), N'{"SucceededAt":"2019-06-03T01:34:14.8191072Z","PerformanceDuration":"1","Latency":"54"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (72, 23, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:34:14.813' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:34:14.8146693Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (74, 23, N'Processing', NULL, CAST(N'2019-06-03T01:34:14.823' AS DateTime), N'{"StartedAt":"2019-06-03T01:34:14.8225654Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"da0b78ce-6dbe-4a4f-a21a-7a0eeca9fcf1"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (75, 23, N'Succeeded', NULL, CAST(N'2019-06-03T01:34:14.827' AS DateTime), N'{"SucceededAt":"2019-06-03T01:34:14.8264179Z","PerformanceDuration":"0","Latency":"15"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (76, 24, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:35:14.853' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:35:14.8524623Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (78, 24, N'Processing', NULL, CAST(N'2019-06-03T01:35:14.917' AS DateTime), N'{"StartedAt":"2019-06-03T01:35:14.9119123Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"37f3a2ed-3075-43e5-ba2e-0bb389c8809e"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (80, 24, N'Succeeded', NULL, CAST(N'2019-06-03T01:35:14.930' AS DateTime), N'{"SucceededAt":"2019-06-03T01:35:14.9278287Z","PerformanceDuration":"5","Latency":"82"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (77, 25, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:35:14.913' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:35:14.9114339Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (79, 25, N'Processing', NULL, CAST(N'2019-06-03T01:35:14.923' AS DateTime), N'{"StartedAt":"2019-06-03T01:35:14.9215738Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"2044a353-b95f-4629-b5f8-c73bcba28f59"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (81, 25, N'Succeeded', NULL, CAST(N'2019-06-03T01:35:14.937' AS DateTime), N'{"SucceededAt":"2019-06-03T01:35:14.9324788Z","PerformanceDuration":"2","Latency":"23"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (82, 26, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:36:14.957' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:36:14.9552702Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (83, 26, N'Processing', NULL, CAST(N'2019-06-03T01:36:15.033' AS DateTime), N'{"StartedAt":"2019-06-03T01:36:15.0292879Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"f82b0735-acd1-413e-94ab-27fa39cfa630"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (86, 26, N'Succeeded', NULL, CAST(N'2019-06-03T01:36:15.047' AS DateTime), N'{"SucceededAt":"2019-06-03T01:36:15.0449243Z","PerformanceDuration":"4","Latency":"100"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (84, 27, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:36:15.033' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:36:15.0337730Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (85, 27, N'Processing', NULL, CAST(N'2019-06-03T01:36:15.047' AS DateTime), N'{"StartedAt":"2019-06-03T01:36:15.0433963Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"8041f101-523a-4488-ac01-7dca58592354"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (87, 27, N'Succeeded', NULL, CAST(N'2019-06-03T01:36:15.057' AS DateTime), N'{"SucceededAt":"2019-06-03T01:36:15.0532996Z","PerformanceDuration":"2","Latency":"24"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (88, 28, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:37:00.080' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:37:00.0790140Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (90, 28, N'Processing', NULL, CAST(N'2019-06-03T01:37:00.110' AS DateTime), N'{"StartedAt":"2019-06-03T01:37:00.1070033Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"f9adba36-972a-4850-9652-74f0d75661f7"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (92, 28, N'Succeeded', NULL, CAST(N'2019-06-03T01:37:00.113' AS DateTime), N'{"SucceededAt":"2019-06-03T01:37:00.1132775Z","PerformanceDuration":"2","Latency":"48"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (89, 29, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:37:00.107' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:37:00.1068667Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (91, 29, N'Processing', NULL, CAST(N'2019-06-03T01:37:00.110' AS DateTime), N'{"StartedAt":"2019-06-03T01:37:00.1104029Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"3841a8bd-7d97-4a21-95e9-cc5bd3259ca2"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (93, 29, N'Succeeded', NULL, CAST(N'2019-06-03T01:37:00.117' AS DateTime), N'{"SucceededAt":"2019-06-03T01:37:00.1141076Z","PerformanceDuration":"0","Latency":"6"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (94, 30, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:38:00.133' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:38:00.1329224Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (96, 30, N'Processing', NULL, CAST(N'2019-06-03T01:38:00.173' AS DateTime), N'{"StartedAt":"2019-06-03T01:38:00.1685133Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"44fb8f30-3f7e-411e-97bb-d4f0cda9b7bd"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (98, 30, N'Succeeded', NULL, CAST(N'2019-06-03T01:38:00.180' AS DateTime), N'{"SucceededAt":"2019-06-03T01:38:00.1783534Z","PerformanceDuration":"2","Latency":"52"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (95, 31, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:38:00.170' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:38:00.1693491Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (97, 31, N'Processing', NULL, CAST(N'2019-06-03T01:38:00.177' AS DateTime), N'{"StartedAt":"2019-06-03T01:38:00.1761029Z","ServerId":"laptop-70j3qrbr:14804:d6e86a26-6ba1-4998-acd9-a265c04bff7c","WorkerId":"e4d1038c-8dc8-4cac-a467-28b0e3d1ec3e"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (99, 31, N'Succeeded', NULL, CAST(N'2019-06-03T01:38:00.187' AS DateTime), N'{"SucceededAt":"2019-06-03T01:38:00.1830444Z","PerformanceDuration":"1","Latency":"14"}')
GO
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (100, 32, N'Enqueued', NULL, CAST(N'2019-06-03T01:38:05.393' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:38:05.2762154Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (101, 32, N'Processing', NULL, CAST(N'2019-06-03T01:38:05.520' AS DateTime), N'{"StartedAt":"2019-06-03T01:38:05.4806413Z","ServerId":"laptop-70j3qrbr:31732:4419358a-8adf-4906-9ff9-f46d40fe6a60","WorkerId":"fdc3af1c-4cbc-498d-990c-58f8f7771cce"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (102, 32, N'Succeeded', NULL, CAST(N'2019-06-03T01:38:05.550' AS DateTime), N'{"SucceededAt":"2019-06-03T01:38:05.5440400Z","PerformanceDuration":"18","Latency":"205"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (103, 33, N'Enqueued', NULL, CAST(N'2019-06-03T01:38:18.833' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:38:18.5848487Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (104, 33, N'Processing', NULL, CAST(N'2019-06-03T01:38:19.350' AS DateTime), N'{"StartedAt":"2019-06-03T01:38:19.2419882Z","ServerId":"laptop-70j3qrbr:28804:e5cbcf1a-a407-45ef-87a5-9b6b7c901ca1","WorkerId":"78100902-4b6d-4ed0-ae60-79ed2e349e50"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (105, 33, N'Succeeded', NULL, CAST(N'2019-06-03T01:38:19.483' AS DateTime), N'{"SucceededAt":"2019-06-03T01:38:19.4543648Z","PerformanceDuration":"76","Latency":"695"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (106, 34, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:39:04.257' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:39:04.2556313Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (108, 34, N'Processing', NULL, CAST(N'2019-06-03T01:39:04.290' AS DateTime), N'{"StartedAt":"2019-06-03T01:39:04.2878243Z","ServerId":"laptop-70j3qrbr:28804:e5cbcf1a-a407-45ef-87a5-9b6b7c901ca1","WorkerId":"78100902-4b6d-4ed0-ae60-79ed2e349e50"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (110, 34, N'Succeeded', NULL, CAST(N'2019-06-03T01:39:04.307' AS DateTime), N'{"SucceededAt":"2019-06-03T01:39:04.3030346Z","PerformanceDuration":"7","Latency":"55"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (107, 35, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:39:04.287' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:39:04.2872991Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (109, 35, N'Processing', NULL, CAST(N'2019-06-03T01:39:04.297' AS DateTime), N'{"StartedAt":"2019-06-03T01:39:04.2923940Z","ServerId":"laptop-70j3qrbr:28804:e5cbcf1a-a407-45ef-87a5-9b6b7c901ca1","WorkerId":"12d848bc-5b83-4ae8-abde-9490e585af3e"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (111, 35, N'Succeeded', NULL, CAST(N'2019-06-03T01:39:04.307' AS DateTime), N'{"SucceededAt":"2019-06-03T01:39:04.3045206Z","PerformanceDuration":"3","Latency":"18"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (112, 36, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:40:04.363' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:40:04.3645839Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (114, 36, N'Processing', NULL, CAST(N'2019-06-03T01:40:04.430' AS DateTime), N'{"StartedAt":"2019-06-03T01:40:04.4247787Z","ServerId":"laptop-70j3qrbr:28804:e5cbcf1a-a407-45ef-87a5-9b6b7c901ca1","WorkerId":"d0ddc1ad-a79e-415d-b21a-56636c878c1d"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (116, 36, N'Succeeded', NULL, CAST(N'2019-06-03T01:40:04.453' AS DateTime), N'{"SucceededAt":"2019-06-03T01:40:04.4470256Z","PerformanceDuration":"11","Latency":"88"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (113, 37, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:40:04.423' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:40:04.4239725Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (115, 37, N'Processing', NULL, CAST(N'2019-06-03T01:40:04.440' AS DateTime), N'{"StartedAt":"2019-06-03T01:40:04.4346005Z","ServerId":"laptop-70j3qrbr:28804:e5cbcf1a-a407-45ef-87a5-9b6b7c901ca1","WorkerId":"ba7f15e2-2ddd-4ee6-b18c-dd7ae192cab7"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (117, 37, N'Succeeded', NULL, CAST(N'2019-06-03T01:40:04.457' AS DateTime), N'{"SucceededAt":"2019-06-03T01:40:04.4549509Z","PerformanceDuration":"2","Latency":"32"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (118, 38, N'Enqueued', NULL, CAST(N'2019-06-03T01:41:04.283' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:41:03.6700001Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (119, 38, N'Processing', NULL, CAST(N'2019-06-03T01:41:04.687' AS DateTime), N'{"StartedAt":"2019-06-03T01:41:04.5865787Z","ServerId":"laptop-70j3qrbr:15148:d836e7e7-8b08-4264-80da-0196fe677806","WorkerId":"fcd2aa54-95db-4f89-bc7e-e49a3b187ea5"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (124, 38, N'Succeeded', NULL, CAST(N'2019-06-03T01:41:05.263' AS DateTime), N'{"SucceededAt":"2019-06-03T01:41:05.2325401Z","PerformanceDuration":"529","Latency":"925"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (120, 39, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:41:05.007' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:41:05.0054753Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (121, 39, N'Processing', NULL, CAST(N'2019-06-03T01:41:05.227' AS DateTime), N'{"StartedAt":"2019-06-03T01:41:05.2225709Z","ServerId":"laptop-70j3qrbr:15148:d836e7e7-8b08-4264-80da-0196fe677806","WorkerId":"03327269-6471-40a2-bdd1-f2696207c686"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (125, 39, N'Succeeded', NULL, CAST(N'2019-06-03T01:41:05.263' AS DateTime), N'{"SucceededAt":"2019-06-03T01:41:05.2371100Z","PerformanceDuration":"2","Latency":"508"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (122, 40, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T01:41:05.227' AS DateTime), N'{"EnqueuedAt":"2019-06-03T01:41:05.2271368Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (123, 40, N'Processing', NULL, CAST(N'2019-06-03T01:41:05.240' AS DateTime), N'{"StartedAt":"2019-06-03T01:41:05.2378297Z","ServerId":"laptop-70j3qrbr:15148:d836e7e7-8b08-4264-80da-0196fe677806","WorkerId":"e8c1bfab-0a51-44bb-a8d5-2688ffd4d246"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (126, 40, N'Succeeded', NULL, CAST(N'2019-06-03T01:41:05.290' AS DateTime), N'{"SucceededAt":"2019-06-03T01:41:05.2880433Z","PerformanceDuration":"36","Latency":"28"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (127, 41, N'Enqueued', NULL, CAST(N'2019-06-03T02:07:54.690' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:07:54.1570297Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (128, 41, N'Processing', NULL, CAST(N'2019-06-03T02:07:55.193' AS DateTime), N'{"StartedAt":"2019-06-03T02:07:54.9744754Z","ServerId":"laptop-70j3qrbr:29296:b76d3cea-2161-4114-a054-7cdd358e88f7","WorkerId":"58f97f4d-9b68-4d3e-b1d9-c3a27af1506a"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (129, 41, N'Succeeded', NULL, CAST(N'2019-06-03T02:07:55.277' AS DateTime), N'{"SucceededAt":"2019-06-03T02:07:55.2602035Z","PerformanceDuration":"54","Latency":"952"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (130, 42, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:07:55.333' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:07:55.3333405Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (131, 42, N'Processing', NULL, CAST(N'2019-06-03T02:07:55.377' AS DateTime), N'{"StartedAt":"2019-06-03T02:07:55.3719801Z","ServerId":"laptop-70j3qrbr:29296:b76d3cea-2161-4114-a054-7cdd358e88f7","WorkerId":"58f97f4d-9b68-4d3e-b1d9-c3a27af1506a"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (132, 42, N'Succeeded', NULL, CAST(N'2019-06-03T02:07:55.460' AS DateTime), N'{"SucceededAt":"2019-06-03T02:07:55.4410722Z","PerformanceDuration":"19","Latency":"151"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (133, 43, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:08:10.487' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:08:10.4851788Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (134, 43, N'Processing', NULL, CAST(N'2019-06-03T02:08:10.500' AS DateTime), N'{"StartedAt":"2019-06-03T02:08:10.4945404Z","ServerId":"laptop-70j3qrbr:29296:b76d3cea-2161-4114-a054-7cdd358e88f7","WorkerId":"a81d3ac5-3f53-4457-b149-3f67da285f15"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (135, 43, N'Succeeded', NULL, CAST(N'2019-06-03T02:08:10.517' AS DateTime), N'{"SucceededAt":"2019-06-03T02:08:10.5114745Z","PerformanceDuration":"2","Latency":"29"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (136, 44, N'Enqueued', NULL, CAST(N'2019-06-03T02:08:33.043' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:08:32.4665636Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (137, 44, N'Processing', NULL, CAST(N'2019-06-03T02:08:33.373' AS DateTime), N'{"StartedAt":"2019-06-03T02:08:33.2736395Z","ServerId":"laptop-70j3qrbr:27400:8cf431c2-1212-4f6f-a29f-e0a5e9542bc2","WorkerId":"cd9e8624-734a-4f09-9bb2-54518d76244b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (138, 44, N'Succeeded', NULL, CAST(N'2019-06-03T02:08:33.463' AS DateTime), N'{"SucceededAt":"2019-06-03T02:08:33.4363658Z","PerformanceDuration":"52","Latency":"783"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (139, 45, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:09:03.290' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:09:03.2903825Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (140, 45, N'Processing', NULL, CAST(N'2019-06-03T02:09:03.297' AS DateTime), N'{"StartedAt":"2019-06-03T02:09:03.2953375Z","ServerId":"laptop-70j3qrbr:27400:8cf431c2-1212-4f6f-a29f-e0a5e9542bc2","WorkerId":"cd9e8624-734a-4f09-9bb2-54518d76244b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (146, 45, N'Processing', NULL, CAST(N'2019-06-03T02:16:17.760' AS DateTime), N'{"StartedAt":"2019-06-03T02:16:17.6552044Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"53467e9a-e2d4-4e66-a517-7a7fe1946c13"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (141, 46, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:09:03.297' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:09:03.2976534Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (142, 46, N'Processing', NULL, CAST(N'2019-06-03T02:09:03.303' AS DateTime), N'{"StartedAt":"2019-06-03T02:09:03.3019805Z","ServerId":"laptop-70j3qrbr:27400:8cf431c2-1212-4f6f-a29f-e0a5e9542bc2","WorkerId":"9559f40e-6be7-461c-9e03-ea3dedcebc02"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (143, 46, N'Succeeded', NULL, CAST(N'2019-06-03T02:09:03.310' AS DateTime), N'{"SucceededAt":"2019-06-03T02:09:03.3085921Z","PerformanceDuration":"0","Latency":"10"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (144, 47, N'Enqueued', NULL, CAST(N'2019-06-03T02:16:17.593' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:16:17.1951572Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (145, 47, N'Processing', NULL, CAST(N'2019-06-03T02:16:17.760' AS DateTime), N'{"StartedAt":"2019-06-03T02:16:17.7273248Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (149, 47, N'Succeeded', NULL, CAST(N'2019-06-03T02:16:17.810' AS DateTime), N'{"SucceededAt":"2019-06-03T02:16:17.7893969Z","PerformanceDuration":"22","Latency":"483"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (147, 48, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:16:17.790' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:16:17.7899010Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (148, 48, N'Processing', NULL, CAST(N'2019-06-03T02:16:17.833' AS DateTime), N'{"StartedAt":"2019-06-03T02:16:17.8224170Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"9ec4546e-6086-442d-ad1d-0047bd2251da"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (150, 49, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:16:17.833' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:16:17.8321051Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (151, 49, N'Processing', NULL, CAST(N'2019-06-03T02:16:17.850' AS DateTime), N'{"StartedAt":"2019-06-03T02:16:17.8371927Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (152, 49, N'Succeeded', NULL, CAST(N'2019-06-03T02:16:17.857' AS DateTime), N'{"SucceededAt":"2019-06-03T02:16:17.8544249Z","PerformanceDuration":"0","Latency":"30"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (153, 50, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:17:02.870' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:17:02.8702145Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (154, 50, N'Processing', NULL, CAST(N'2019-06-03T02:17:02.877' AS DateTime), N'{"StartedAt":"2019-06-03T02:17:02.8761764Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"9d060fcd-6637-4610-8eec-722bc28bbf95"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (158, 50, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:17:03.183' AS DateTime), N'{"FailedAt":"2019-06-03T02:17:03.1049547Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (159, 50, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:17:03.183' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:17:38.1211607Z","ScheduledAt":"2019-06-03T02:17:03.1211607Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (160, 50, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:17:47.757' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:17:47.7506936Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (161, 50, N'Processing', NULL, CAST(N'2019-06-03T02:17:47.783' AS DateTime), N'{"StartedAt":"2019-06-03T02:17:47.7821879Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (162, 50, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:17:47.950' AS DateTime), N'{"FailedAt":"2019-06-03T02:17:47.9401822Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (163, 50, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:17:47.953' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:18:21.9474395Z","ScheduledAt":"2019-06-03T02:17:47.9474395Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (172, 50, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:18:32.830' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:18:32.8258257Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (174, 50, N'Processing', NULL, CAST(N'2019-06-03T02:18:32.837' AS DateTime), N'{"StartedAt":"2019-06-03T02:18:32.8349496Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (175, 50, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:18:33.370' AS DateTime), N'{"FailedAt":"2019-06-03T02:18:33.3507656Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (176, 50, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:18:33.377' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:20:19.3629409Z","ScheduledAt":"2019-06-03T02:18:33.3629415Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (201, 50, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:20:32.980' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:20:32.9695187Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (202, 50, N'Processing', NULL, CAST(N'2019-06-03T02:20:33.047' AS DateTime), N'{"StartedAt":"2019-06-03T02:20:33.0420555Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (203, 50, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:20:33.230' AS DateTime), N'{"FailedAt":"2019-06-03T02:20:33.2157607Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (204, 50, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:20:33.230' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:23:09.2267852Z","ScheduledAt":"2019-06-03T02:20:33.2267852Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (262, 50, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:23:18.363' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:23:18.3594377Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (263, 50, N'Processing', NULL, CAST(N'2019-06-03T02:23:18.377' AS DateTime), N'{"StartedAt":"2019-06-03T02:23:18.3709116Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (264, 50, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:23:18.623' AS DateTime), N'{"FailedAt":"2019-06-03T02:23:18.6173255Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (265, 50, N'Scheduled', N'Retry attempt 5 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:23:18.627' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:30:09.6208019Z","ScheduledAt":"2019-06-03T02:23:18.6208025Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (155, 51, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:17:02.880' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:17:02.8800579Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (156, 51, N'Processing', NULL, CAST(N'2019-06-03T02:17:02.943' AS DateTime), N'{"StartedAt":"2019-06-03T02:17:02.9272775Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"e86a1077-fa19-4693-bfec-23f419557c79"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (157, 51, N'Succeeded', NULL, CAST(N'2019-06-03T02:17:03.020' AS DateTime), N'{"SucceededAt":"2019-06-03T02:17:03.0044001Z","PerformanceDuration":"15","Latency":"111"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (164, 52, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:18:02.970' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:18:02.9709676Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (165, 52, N'Processing', NULL, CAST(N'2019-06-03T02:18:02.997' AS DateTime), N'{"StartedAt":"2019-06-03T02:18:02.9938540Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"1fc276a3-3e4a-44b6-9ea7-b8e4586f7937"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (169, 52, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:18:03.340' AS DateTime), N'{"FailedAt":"2019-06-03T02:18:03.3320570Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (170, 52, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:18:03.340' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:18:19.3340880Z","ScheduledAt":"2019-06-03T02:18:03.3340880Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (171, 52, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:18:32.810' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:18:32.8055437Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (173, 52, N'Processing', NULL, CAST(N'2019-06-03T02:18:32.830' AS DateTime), N'{"StartedAt":"2019-06-03T02:18:32.8298524Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (177, 52, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:18:33.373' AS DateTime), N'{"FailedAt":"2019-06-03T02:18:33.2825711Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (178, 52, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:18:33.377' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:19:13.3632914Z","ScheduledAt":"2019-06-03T02:18:33.3632914Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (186, 52, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:19:17.860' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:19:17.8549768Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (187, 52, N'Processing', NULL, CAST(N'2019-06-03T02:19:17.877' AS DateTime), N'{"StartedAt":"2019-06-03T02:19:17.8698430Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (188, 52, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:19:18.150' AS DateTime), N'{"FailedAt":"2019-06-03T02:19:18.1431244Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (189, 52, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:19:18.150' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:21:10.1463875Z","ScheduledAt":"2019-06-03T02:19:18.1463875Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (220, 52, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:21:18.097' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:21:18.0943819Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (221, 52, N'Processing', NULL, CAST(N'2019-06-03T02:21:18.110' AS DateTime), N'{"StartedAt":"2019-06-03T02:21:18.1054223Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (222, 52, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:21:18.353' AS DateTime), N'{"FailedAt":"2019-06-03T02:21:18.3457992Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (223, 52, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:21:18.353' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:24:10.3489547Z","ScheduledAt":"2019-06-03T02:21:18.3489547Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (285, 52, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:24:18.507' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:24:18.5062618Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (286, 52, N'Processing', NULL, CAST(N'2019-06-03T02:24:18.513' AS DateTime), N'{"StartedAt":"2019-06-03T02:24:18.5113363Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (287, 52, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:24:18.677' AS DateTime), N'{"FailedAt":"2019-06-03T02:24:18.6713962Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (288, 52, N'Scheduled', N'Retry attempt 5 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:24:18.680' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:29:24.6744790Z","ScheduledAt":"2019-06-03T02:24:18.6744790Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (166, 53, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:18:03.000' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:18:03.0003997Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (167, 53, N'Processing', NULL, CAST(N'2019-06-03T02:18:03.083' AS DateTime), N'{"StartedAt":"2019-06-03T02:18:03.0488389Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"d8c54ca3-cdd7-42f1-83dc-0bd0f30390b7"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (168, 53, N'Succeeded', NULL, CAST(N'2019-06-03T02:18:03.203' AS DateTime), N'{"SucceededAt":"2019-06-03T02:18:03.1833141Z","PerformanceDuration":"20","Latency":"165"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (179, 54, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:19:03.213' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:19:03.2137071Z","Queue":"default"}')
GO
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (180, 54, N'Processing', NULL, CAST(N'2019-06-03T02:19:03.237' AS DateTime), N'{"StartedAt":"2019-06-03T02:19:03.2352117Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (184, 54, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:19:03.417' AS DateTime), N'{"FailedAt":"2019-06-03T02:19:03.4093675Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (185, 54, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:19:03.417' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:19:35.4111401Z","ScheduledAt":"2019-06-03T02:19:03.4111406Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (190, 54, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:19:47.907' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:19:47.9020000Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (191, 54, N'Processing', NULL, CAST(N'2019-06-03T02:19:47.950' AS DateTime), N'{"StartedAt":"2019-06-03T02:19:47.9475237Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (192, 54, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:19:48.230' AS DateTime), N'{"FailedAt":"2019-06-03T02:19:48.2189408Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (193, 54, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:19:48.230' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:20:50.2261225Z","ScheduledAt":"2019-06-03T02:19:48.2261225Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (209, 54, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:21:03.080' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:21:03.0797353Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (210, 54, N'Processing', NULL, CAST(N'2019-06-03T02:21:03.087' AS DateTime), N'{"StartedAt":"2019-06-03T02:21:03.0850914Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (211, 54, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:21:03.260' AS DateTime), N'{"FailedAt":"2019-06-03T02:21:03.2526873Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (212, 54, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:21:03.260' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:22:43.2559630Z","ScheduledAt":"2019-06-03T02:21:03.2559636Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (242, 54, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:22:48.233' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:22:48.2306883Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (244, 54, N'Processing', NULL, CAST(N'2019-06-03T02:22:48.283' AS DateTime), N'{"StartedAt":"2019-06-03T02:22:48.2485924Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"1fc276a3-3e4a-44b6-9ea7-b8e4586f7937"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (249, 54, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:22:48.813' AS DateTime), N'{"FailedAt":"2019-06-03T02:22:48.8079461Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (250, 54, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:22:48.813' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:25:56.8095919Z","ScheduledAt":"2019-06-03T02:22:48.8095919Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (316, 54, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:26:03.713' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:26:03.7092318Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (318, 54, N'Processing', NULL, CAST(N'2019-06-03T02:26:03.777' AS DateTime), N'{"StartedAt":"2019-06-03T02:26:03.7613393Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (322, 54, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:26:04.263' AS DateTime), N'{"FailedAt":"2019-06-03T02:26:04.1636937Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (323, 54, N'Scheduled', N'Retry attempt 5 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:26:04.267' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:31:05.2174105Z","ScheduledAt":"2019-06-03T02:26:04.2174105Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (181, 55, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:19:03.240' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:19:03.2406582Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (182, 55, N'Processing', NULL, CAST(N'2019-06-03T02:19:03.300' AS DateTime), N'{"StartedAt":"2019-06-03T02:19:03.2849331Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (183, 55, N'Succeeded', NULL, CAST(N'2019-06-03T02:19:03.373' AS DateTime), N'{"SucceededAt":"2019-06-03T02:19:03.3372215Z","PerformanceDuration":"12","Latency":"87"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (194, 56, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:20:03.320' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:20:03.3186432Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (195, 56, N'Processing', NULL, CAST(N'2019-06-03T02:20:03.327' AS DateTime), N'{"StartedAt":"2019-06-03T02:20:03.3265382Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (199, 56, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:20:03.493' AS DateTime), N'{"FailedAt":"2019-06-03T02:20:03.4882803Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (200, 56, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:20:03.493' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:20:36.4903892Z","ScheduledAt":"2019-06-03T02:20:03.4903892Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (205, 56, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:20:48.060' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:20:48.0595004Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (206, 56, N'Processing', NULL, CAST(N'2019-06-03T02:20:48.077' AS DateTime), N'{"StartedAt":"2019-06-03T02:20:48.0736669Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (207, 56, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:20:48.237' AS DateTime), N'{"FailedAt":"2019-06-03T02:20:48.2261264Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (208, 56, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:20:48.237' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:21:52.2335152Z","ScheduledAt":"2019-06-03T02:20:48.2335152Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (228, 56, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:22:03.143' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:22:03.1405348Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (229, 56, N'Processing', NULL, CAST(N'2019-06-03T02:22:03.157' AS DateTime), N'{"StartedAt":"2019-06-03T02:22:03.1550539Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (230, 56, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:22:03.327' AS DateTime), N'{"FailedAt":"2019-06-03T02:22:03.3163352Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (231, 56, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:22:03.327' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:22:49.3233599Z","ScheduledAt":"2019-06-03T02:22:03.3233599Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (251, 56, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:23:03.333' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:23:03.3306189Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (252, 56, N'Processing', NULL, CAST(N'2019-06-03T02:23:03.343' AS DateTime), N'{"StartedAt":"2019-06-03T02:23:03.3402832Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"9d060fcd-6637-4610-8eec-722bc28bbf95"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (253, 56, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:23:03.537' AS DateTime), N'{"FailedAt":"2019-06-03T02:23:03.5290281Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (254, 56, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:23:03.537' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:25:59.5320444Z","ScheduledAt":"2019-06-03T02:23:03.5320444Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (319, 56, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:26:03.863' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:26:03.8376023Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (321, 56, N'Processing', NULL, CAST(N'2019-06-03T02:26:03.950' AS DateTime), N'{"StartedAt":"2019-06-03T02:26:03.9434988Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"adf4f3ec-0eb7-4b08-9ef9-7fcfbb16742d"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (326, 56, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:26:04.353' AS DateTime), N'{"FailedAt":"2019-06-03T02:26:04.3356564Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (327, 56, N'Scheduled', N'Retry attempt 5 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:26:04.353' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:32:25.3477795Z","ScheduledAt":"2019-06-03T02:26:04.3477795Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (196, 57, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:20:03.330' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:20:03.3287984Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (197, 57, N'Processing', NULL, CAST(N'2019-06-03T02:20:03.353' AS DateTime), N'{"StartedAt":"2019-06-03T02:20:03.3447018Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"d8c54ca3-cdd7-42f1-83dc-0bd0f30390b7"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (198, 57, N'Succeeded', NULL, CAST(N'2019-06-03T02:20:03.397' AS DateTime), N'{"SucceededAt":"2019-06-03T02:20:03.3813359Z","PerformanceDuration":"1","Latency":"52"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (213, 58, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:21:03.407' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:21:03.4065560Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (214, 58, N'Processing', NULL, CAST(N'2019-06-03T02:21:03.430' AS DateTime), N'{"StartedAt":"2019-06-03T02:21:03.4285634Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (218, 58, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:21:03.727' AS DateTime), N'{"FailedAt":"2019-06-03T02:21:03.7199213Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (219, 58, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:21:03.727' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:21:25.7218652Z","ScheduledAt":"2019-06-03T02:21:03.7218652Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (224, 58, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:21:33.123' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:21:33.1223763Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (225, 58, N'Processing', NULL, CAST(N'2019-06-03T02:21:33.130' AS DateTime), N'{"StartedAt":"2019-06-03T02:21:33.1272882Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (226, 58, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:21:33.293' AS DateTime), N'{"FailedAt":"2019-06-03T02:21:33.2863599Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (227, 58, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:21:33.293' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:22:39.2892919Z","ScheduledAt":"2019-06-03T02:21:33.2892919Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (239, 58, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:22:48.183' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:22:48.1782145Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (241, 58, N'Processing', NULL, CAST(N'2019-06-03T02:22:48.227' AS DateTime), N'{"StartedAt":"2019-06-03T02:22:48.2249768Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (245, 58, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:22:48.750' AS DateTime), N'{"FailedAt":"2019-06-03T02:22:48.6837331Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (246, 58, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:22:48.753' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:23:40.7363934Z","ScheduledAt":"2019-06-03T02:22:48.7363940Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (270, 58, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:23:48.430' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:23:48.4256132Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (272, 58, N'Processing', NULL, CAST(N'2019-06-03T02:23:48.470' AS DateTime), N'{"StartedAt":"2019-06-03T02:23:48.4688880Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (274, 58, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:23:48.843' AS DateTime), N'{"FailedAt":"2019-06-03T02:23:48.7838018Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (275, 58, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:23:48.843' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:27:16.8385695Z","ScheduledAt":"2019-06-03T02:23:48.8385700Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (353, 58, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:27:19.123' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:27:19.1213051Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (355, 58, N'Processing', NULL, CAST(N'2019-06-03T02:27:19.167' AS DateTime), N'{"StartedAt":"2019-06-03T02:27:19.1527807Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"1fc276a3-3e4a-44b6-9ea7-b8e4586f7937"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (360, 58, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:27:19.543' AS DateTime), N'{"FailedAt":"2019-06-03T02:27:19.5354026Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (361, 58, N'Scheduled', N'Retry attempt 5 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:27:19.543' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:33:25.5381748Z","ScheduledAt":"2019-06-03T02:27:19.5381748Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (215, 59, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:21:03.437' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:21:03.4353265Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (216, 59, N'Processing', NULL, CAST(N'2019-06-03T02:21:03.513' AS DateTime), N'{"StartedAt":"2019-06-03T02:21:03.4828053Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"d8c54ca3-cdd7-42f1-83dc-0bd0f30390b7"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (217, 59, N'Succeeded', NULL, CAST(N'2019-06-03T02:21:03.633' AS DateTime), N'{"SucceededAt":"2019-06-03T02:21:03.6188439Z","PerformanceDuration":"16","Latency":"172"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (232, 60, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:22:03.593' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:22:03.5941103Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (233, 60, N'Processing', NULL, CAST(N'2019-06-03T02:22:03.620' AS DateTime), N'{"StartedAt":"2019-06-03T02:22:03.6160893Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (237, 60, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:22:03.870' AS DateTime), N'{"FailedAt":"2019-06-03T02:22:03.8642798Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (238, 60, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:22:03.870' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:22:41.8660678Z","ScheduledAt":"2019-06-03T02:22:03.8660678Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (240, 60, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:22:48.220' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:22:48.2134630Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (243, 60, N'Processing', NULL, CAST(N'2019-06-03T02:22:48.233' AS DateTime), N'{"StartedAt":"2019-06-03T02:22:48.2317095Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (247, 60, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:22:48.797' AS DateTime), N'{"FailedAt":"2019-06-03T02:22:48.7542759Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (248, 60, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:22:48.797' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:23:26.7783121Z","ScheduledAt":"2019-06-03T02:22:48.7783127Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (266, 60, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:23:33.390' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:23:33.3866653Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (267, 60, N'Processing', NULL, CAST(N'2019-06-03T02:23:33.403' AS DateTime), N'{"StartedAt":"2019-06-03T02:23:33.3976904Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (268, 60, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:23:33.643' AS DateTime), N'{"FailedAt":"2019-06-03T02:23:33.6379938Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (269, 60, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:23:33.647' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:25:13.6412741Z","ScheduledAt":"2019-06-03T02:23:33.6412746Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (304, 60, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:25:18.600' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:25:18.5979491Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (305, 60, N'Processing', NULL, CAST(N'2019-06-03T02:25:18.613' AS DateTime), N'{"StartedAt":"2019-06-03T02:25:18.6088331Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (306, 60, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:25:18.963' AS DateTime), N'{"FailedAt":"2019-06-03T02:25:18.9573683Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (307, 60, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:25:18.963' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:27:06.9594578Z","ScheduledAt":"2019-06-03T02:25:18.9594578Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (350, 60, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:27:19.097' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:27:19.0957905Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (352, 60, N'Processing', NULL, CAST(N'2019-06-03T02:27:19.120' AS DateTime), N'{"StartedAt":"2019-06-03T02:27:19.1186951Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (356, 60, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:27:19.433' AS DateTime), N'{"FailedAt":"2019-06-03T02:27:19.3910782Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (357, 60, N'Scheduled', N'Retry attempt 5 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:27:19.433' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:31:55.4162794Z","ScheduledAt":"2019-06-03T02:27:19.4162800Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (234, 61, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:22:03.623' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:22:03.6237483Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (235, 61, N'Processing', NULL, CAST(N'2019-06-03T02:22:03.740' AS DateTime), N'{"StartedAt":"2019-06-03T02:22:03.7023216Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (236, 61, N'Succeeded', NULL, CAST(N'2019-06-03T02:22:03.817' AS DateTime), N'{"SucceededAt":"2019-06-03T02:22:03.7924695Z","PerformanceDuration":"21","Latency":"153"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (255, 62, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:23:03.773' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:23:03.7734828Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (256, 62, N'Processing', NULL, CAST(N'2019-06-03T02:23:03.797' AS DateTime), N'{"StartedAt":"2019-06-03T02:23:03.7956336Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (260, 62, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:23:04.173' AS DateTime), N'{"FailedAt":"2019-06-03T02:23:04.1677146Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (261, 62, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:23:04.173' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:23:43.1691976Z","ScheduledAt":"2019-06-03T02:23:04.1691976Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (271, 62, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:23:48.467' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:23:48.4633647Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (273, 62, N'Processing', NULL, CAST(N'2019-06-03T02:23:48.477' AS DateTime), N'{"StartedAt":"2019-06-03T02:23:48.4730791Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (276, 62, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:23:48.857' AS DateTime), N'{"FailedAt":"2019-06-03T02:23:48.8386110Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (277, 62, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:23:48.857' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:24:52.8518228Z","ScheduledAt":"2019-06-03T02:23:48.8518228Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (293, 62, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:25:03.567' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:25:03.5612171Z","Queue":"default"}')
GO
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (294, 62, N'Processing', NULL, CAST(N'2019-06-03T02:25:03.597' AS DateTime), N'{"StartedAt":"2019-06-03T02:25:03.5935744Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (295, 62, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:25:03.760' AS DateTime), N'{"FailedAt":"2019-06-03T02:25:03.7480778Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (296, 62, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:25:03.760' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:25:37.7552198Z","ScheduledAt":"2019-06-03T02:25:03.7552204Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (308, 62, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:25:48.637' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:25:48.6310744Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (310, 62, N'Processing', NULL, CAST(N'2019-06-03T02:25:48.677' AS DateTime), N'{"StartedAt":"2019-06-03T02:25:48.6729759Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"9d060fcd-6637-4610-8eec-722bc28bbf95"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (312, 62, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:25:50.033' AS DateTime), N'{"FailedAt":"2019-06-03T02:25:49.9634458Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (313, 62, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:25:50.040' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:29:14.0222131Z","ScheduledAt":"2019-06-03T02:25:50.0222137Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (257, 63, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:23:03.803' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:23:03.8022902Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (258, 63, N'Processing', NULL, CAST(N'2019-06-03T02:23:03.923' AS DateTime), N'{"StartedAt":"2019-06-03T02:23:03.8749521Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"1fc276a3-3e4a-44b6-9ea7-b8e4586f7937"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (259, 63, N'Succeeded', NULL, CAST(N'2019-06-03T02:23:04.157' AS DateTime), N'{"SucceededAt":"2019-06-03T02:23:04.1156879Z","PerformanceDuration":"84","Latency":"234"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (278, 64, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:24:03.947' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:24:03.9461976Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (279, 64, N'Processing', NULL, CAST(N'2019-06-03T02:24:04.020' AS DateTime), N'{"StartedAt":"2019-06-03T02:24:04.0164856Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"1fc276a3-3e4a-44b6-9ea7-b8e4586f7937"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (283, 64, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:24:04.330' AS DateTime), N'{"FailedAt":"2019-06-03T02:24:04.3192372Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (284, 64, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:24:04.330' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:24:42.3266111Z","ScheduledAt":"2019-06-03T02:24:04.3266111Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (289, 64, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:24:48.523' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:24:48.5227334Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (290, 64, N'Processing', NULL, CAST(N'2019-06-03T02:24:48.537' AS DateTime), N'{"StartedAt":"2019-06-03T02:24:48.5327698Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (291, 64, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:24:48.787' AS DateTime), N'{"FailedAt":"2019-06-03T02:24:48.7803300Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (292, 64, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:24:48.787' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:25:56.7836625Z","ScheduledAt":"2019-06-03T02:24:48.7836625Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (317, 64, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:26:03.757' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:26:03.7476672Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (320, 64, N'Processing', NULL, CAST(N'2019-06-03T02:26:03.873' AS DateTime), N'{"StartedAt":"2019-06-03T02:26:03.8450696Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"1fc276a3-3e4a-44b6-9ea7-b8e4586f7937"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (324, 64, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:26:04.347' AS DateTime), N'{"FailedAt":"2019-06-03T02:26:04.3050513Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (325, 64, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:26:04.347' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:27:08.3433262Z","ScheduledAt":"2019-06-03T02:26:04.3433262Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (351, 64, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:27:19.120' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:27:19.1151561Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (354, 64, N'Processing', NULL, CAST(N'2019-06-03T02:27:19.123' AS DateTime), N'{"StartedAt":"2019-06-03T02:27:19.1216925Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (358, 64, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:27:19.540' AS DateTime), N'{"FailedAt":"2019-06-03T02:27:19.5239952Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (359, 64, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:27:19.543' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:29:31.5368015Z","ScheduledAt":"2019-06-03T02:27:19.5368015Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (280, 65, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:24:04.020' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:24:04.0209696Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (281, 65, N'Processing', NULL, CAST(N'2019-06-03T02:24:04.070' AS DateTime), N'{"StartedAt":"2019-06-03T02:24:04.0316522Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"dff1c537-bb89-4503-bcd7-afd890b62d76"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (282, 65, N'Succeeded', NULL, CAST(N'2019-06-03T02:24:04.187' AS DateTime), N'{"SucceededAt":"2019-06-03T02:24:04.1636090Z","PerformanceDuration":"29","Latency":"121"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (297, 66, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:25:04.100' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:25:04.1001004Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (298, 66, N'Processing', NULL, CAST(N'2019-06-03T02:25:04.127' AS DateTime), N'{"StartedAt":"2019-06-03T02:25:04.1255952Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"1fc276a3-3e4a-44b6-9ea7-b8e4586f7937"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (302, 66, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:25:04.427' AS DateTime), N'{"FailedAt":"2019-06-03T02:25:04.4210154Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (303, 66, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:25:04.427' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:25:44.4228791Z","ScheduledAt":"2019-06-03T02:25:04.4228791Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (309, 66, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:25:48.670' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:25:48.6665441Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (311, 66, N'Processing', NULL, CAST(N'2019-06-03T02:25:48.687' AS DateTime), N'{"StartedAt":"2019-06-03T02:25:48.6791205Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (314, 66, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:25:50.043' AS DateTime), N'{"FailedAt":"2019-06-03T02:25:49.9999577Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (315, 66, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:25:50.043' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:26:58.0225846Z","ScheduledAt":"2019-06-03T02:25:50.0225846Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (339, 66, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:27:04.067' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:27:04.0639424Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (340, 66, N'Processing', NULL, CAST(N'2019-06-03T02:27:04.080' AS DateTime), N'{"StartedAt":"2019-06-03T02:27:04.0757224Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (341, 66, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:27:04.320' AS DateTime), N'{"FailedAt":"2019-06-03T02:27:04.3135682Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (342, 66, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:27:04.320' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:28:47.3170025Z","ScheduledAt":"2019-06-03T02:27:04.3170025Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (299, 67, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:25:04.133' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:25:04.1323064Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (300, 67, N'Processing', NULL, CAST(N'2019-06-03T02:25:04.253' AS DateTime), N'{"StartedAt":"2019-06-03T02:25:04.2076369Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (301, 67, N'Succeeded', NULL, CAST(N'2019-06-03T02:25:04.370' AS DateTime), N'{"SucceededAt":"2019-06-03T02:25:04.3446938Z","PerformanceDuration":"23","Latency":"193"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (328, 68, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:26:04.410' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:26:04.4087866Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (329, 68, N'Processing', NULL, CAST(N'2019-06-03T02:26:04.440' AS DateTime), N'{"StartedAt":"2019-06-03T02:26:04.4373351Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (333, 68, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:26:04.637' AS DateTime), N'{"FailedAt":"2019-06-03T02:26:04.6204055Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (334, 68, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:26:04.640' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:26:39.6331338Z","ScheduledAt":"2019-06-03T02:26:04.6331343Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (335, 68, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:26:49.000' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:26:48.9886492Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (336, 68, N'Processing', NULL, CAST(N'2019-06-03T02:26:49.060' AS DateTime), N'{"StartedAt":"2019-06-03T02:26:49.0581636Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (337, 68, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:26:49.247' AS DateTime), N'{"FailedAt":"2019-06-03T02:26:49.2345596Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (338, 68, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:26:49.247' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:27:23.2413209Z","ScheduledAt":"2019-06-03T02:26:49.2413209Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (362, 68, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:27:34.177' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:27:34.1753587Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (363, 68, N'Processing', NULL, CAST(N'2019-06-03T02:27:34.187' AS DateTime), N'{"StartedAt":"2019-06-03T02:27:34.1860300Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (364, 68, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:27:34.443' AS DateTime), N'{"FailedAt":"2019-06-03T02:27:34.4353907Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (365, 68, N'Scheduled', N'Retry attempt 3 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:27:34.443' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:28:23.4389850Z","ScheduledAt":"2019-06-03T02:27:34.4389850Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (377, 68, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:28:34.233' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:28:34.2303823Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (378, 68, N'Processing', NULL, CAST(N'2019-06-03T02:28:34.250' AS DateTime), N'{"StartedAt":"2019-06-03T02:28:34.2485970Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (379, 68, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:28:34.410' AS DateTime), N'{"FailedAt":"2019-06-03T02:28:34.4001418Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (380, 68, N'Scheduled', N'Retry attempt 4 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:28:34.410' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:30:50.4074372Z","ScheduledAt":"2019-06-03T02:28:34.4074372Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (330, 69, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:26:04.443' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:26:04.4443103Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (331, 69, N'Processing', NULL, CAST(N'2019-06-03T02:26:04.540' AS DateTime), N'{"StartedAt":"2019-06-03T02:26:04.5167556Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (332, 69, N'Succeeded', NULL, CAST(N'2019-06-03T02:26:04.627' AS DateTime), N'{"SucceededAt":"2019-06-03T02:26:04.6237528Z","PerformanceDuration":"15","Latency":"168"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (343, 70, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:27:04.573' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:27:04.5745564Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (344, 70, N'Processing', NULL, CAST(N'2019-06-03T02:27:04.583' AS DateTime), N'{"StartedAt":"2019-06-03T02:27:04.5817027Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (348, 70, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:27:04.743' AS DateTime), N'{"FailedAt":"2019-06-03T02:27:04.7369914Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (349, 70, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:27:04.743' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:27:42.7389506Z","ScheduledAt":"2019-06-03T02:27:04.7389506Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (366, 70, N'Enqueued', N'Triggered by DelayedJobScheduler', CAST(N'2019-06-03T02:27:49.200' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:27:49.1990314Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (367, 70, N'Processing', NULL, CAST(N'2019-06-03T02:27:49.207' AS DateTime), N'{"StartedAt":"2019-06-03T02:27:49.2035404Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (368, 70, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:27:49.367' AS DateTime), N'{"FailedAt":"2019-06-03T02:27:49.3586635Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (369, 70, N'Scheduled', N'Retry attempt 2 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:27:49.367' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:29:01.3617406Z","ScheduledAt":"2019-06-03T02:27:49.3617411Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (345, 71, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:27:04.583' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:27:04.5838839Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (346, 71, N'Processing', NULL, CAST(N'2019-06-03T02:27:04.620' AS DateTime), N'{"StartedAt":"2019-06-03T02:27:04.6149169Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"e9788bc1-bd07-4c81-ac67-612c0742b52a"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (347, 71, N'Succeeded', NULL, CAST(N'2019-06-03T02:27:04.687' AS DateTime), N'{"SucceededAt":"2019-06-03T02:27:04.6547476Z","PerformanceDuration":"11","Latency":"60"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (370, 72, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:28:04.660' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:28:04.6608529Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (371, 72, N'Processing', NULL, CAST(N'2019-06-03T02:28:04.687' AS DateTime), N'{"StartedAt":"2019-06-03T02:28:04.6857447Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"831f622c-42f8-45c6-9947-df095e05777b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (375, 72, N'Failed', N'An exception occurred during performance of the job.', CAST(N'2019-06-03T02:28:05.143' AS DateTime), N'{"FailedAt":"2019-06-03T02:28:05.1360730Z","ExceptionType":"System.InvalidOperationException","ExceptionMessage":"This instance has already started one or more requests. Properties can only be modified before sending the first request.","ExceptionDetails":"System.InvalidOperationException: This instance has already started one or more requests. Properties can only be modified before sending the first request.\r\n   at System.Net.Http.HttpClient.CheckDisposedOrStarted()\r\n   at System.Net.Http.HttpClient.set_BaseAddress(Uri value)\r\n   at JobsHangfire.Startup.RunAsync() in C:\\_dev\\JobsHangfire\\JobsHangfire\\JobsHangfire\\Startup.cs:line 87\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (376, 72, N'Scheduled', N'Retry attempt 1 of 10: This instance has already started one or more req…', CAST(N'2019-06-03T02:28:05.143' AS DateTime), N'{"EnqueueAt":"2019-06-03T02:28:35.1387280Z","ScheduledAt":"2019-06-03T02:28:05.1387285Z"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (372, 73, N'Enqueued', N'Triggered by recurring job scheduler', CAST(N'2019-06-03T02:28:04.693' AS DateTime), N'{"EnqueuedAt":"2019-06-03T02:28:04.6923353Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (373, 73, N'Processing', NULL, CAST(N'2019-06-03T02:28:04.793' AS DateTime), N'{"StartedAt":"2019-06-03T02:28:04.7626824Z","ServerId":"laptop-70j3qrbr:23436:499b892d-adbb-4f43-a1ca-c5c4e41eb3c9","WorkerId":"b28fce16-17ac-4050-b350-3165a8bbb8ed"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (374, 73, N'Succeeded', NULL, CAST(N'2019-06-03T02:28:04.987' AS DateTime), N'{"SucceededAt":"2019-06-03T02:28:04.8867208Z","PerformanceDuration":"14","Latency":"185"}')
SET IDENTITY_INSERT [HangFire].[State] OFF
/****** Object:  Index [IX_HangFire_AggregatedCounter_ExpireAt]    Script Date: 02/06/2019 23:34:55 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_AggregatedCounter_ExpireAt] ON [HangFire].[AggregatedCounter]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Hash_ExpireAt]    Script Date: 02/06/2019 23:34:55 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Hash_ExpireAt] ON [HangFire].[Hash]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_ExpireAt]    Script Date: 02/06/2019 23:34:55 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_ExpireAt] ON [HangFire].[Job]
(
	[ExpireAt] ASC
)
INCLUDE ( 	[StateName]) 
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Job_StateName]    Script Date: 02/06/2019 23:34:55 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Job_StateName] ON [HangFire].[Job]
(
	[StateName] ASC
)
WHERE ([StateName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_List_ExpireAt]    Script Date: 02/06/2019 23:34:55 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_List_ExpireAt] ON [HangFire].[List]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Server_LastHeartbeat]    Script Date: 02/06/2019 23:34:55 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Server_LastHeartbeat] ON [HangFire].[Server]
(
	[LastHeartbeat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_HangFire_Set_ExpireAt]    Script Date: 02/06/2019 23:34:55 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_ExpireAt] ON [HangFire].[Set]
(
	[ExpireAt] ASC
)
WHERE ([ExpireAt] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HangFire_Set_Score]    Script Date: 02/06/2019 23:34:55 ******/
CREATE NONCLUSTERED INDEX [IX_HangFire_Set_Score] ON [HangFire].[Set]
(
	[Key] ASC,
	[Score] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
USE [master]
GO
ALTER DATABASE [Hangfire] SET  READ_WRITE 
GO
