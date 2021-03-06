USE [master]
GO
/****** Object:  Database [ViaVarejo]    Script Date: 02/06/2019 23:41:43 ******/
CREATE DATABASE [ViaVarejo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ViaVarejo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ViaVarejo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ViaVarejo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ViaVarejo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ViaVarejo] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ViaVarejo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ViaVarejo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ViaVarejo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ViaVarejo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ViaVarejo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ViaVarejo] SET ARITHABORT OFF 
GO
ALTER DATABASE [ViaVarejo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ViaVarejo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ViaVarejo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ViaVarejo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ViaVarejo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ViaVarejo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ViaVarejo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ViaVarejo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ViaVarejo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ViaVarejo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ViaVarejo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ViaVarejo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ViaVarejo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ViaVarejo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ViaVarejo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ViaVarejo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ViaVarejo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ViaVarejo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ViaVarejo] SET  MULTI_USER 
GO
ALTER DATABASE [ViaVarejo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ViaVarejo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ViaVarejo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ViaVarejo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ViaVarejo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ViaVarejo] SET QUERY_STORE = OFF
GO
USE [ViaVarejo]
GO
/****** Object:  Table [dbo].[HistoricoStatus]    Script Date: 02/06/2019 23:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoricoStatus](
	[IdPedido] [int] NOT NULL,
	[IdStatus] [int] NOT NULL,
	[DataStatus] [datetime] NOT NULL,
 CONSTRAINT [PK_HistoricoStatus] PRIMARY KEY CLUSTERED 
(
	[IdPedido] ASC,
	[IdStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemPedido]    Script Date: 02/06/2019 23:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemPedido](
	[IdPedido] [int] NOT NULL,
	[IdProduto] [int] NOT NULL,
	[PrecoVenda] [money] NOT NULL,
 CONSTRAINT [PK_ItemPedido] PRIMARY KEY CLUSTERED 
(
	[IdPedido] ASC,
	[IdProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedido]    Script Date: 02/06/2019 23:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedido](
	[IdPedido] [int] NOT NULL,
	[IdStatus] [int] NOT NULL,
	[ValorPedido] [money] NOT NULL,
	[DataPrevisaoEntrega] [datetime] NOT NULL,
 CONSTRAINT [PK_Pedido] PRIMARY KEY CLUSTERED 
(
	[IdPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produtos]    Script Date: 02/06/2019 23:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produtos](
	[IdProduto] [int] NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[PrecoVenda] [money] NOT NULL,
 CONSTRAINT [PK_Produtos] PRIMARY KEY CLUSTERED 
(
	[IdProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusPedido]    Script Date: 02/06/2019 23:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusPedido](
	[IdStatus] [int] NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[Ordem] [int] NOT NULL,
 CONSTRAINT [PK_StatusPedido] PRIMARY KEY CLUSTERED 
(
	[IdStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[HistoricoStatus]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_HistoricoStatus] FOREIGN KEY([IdPedido])
REFERENCES [dbo].[Pedido] ([IdPedido])
GO
ALTER TABLE [dbo].[HistoricoStatus] CHECK CONSTRAINT [FK_Pedido_HistoricoStatus]
GO
ALTER TABLE [dbo].[HistoricoStatus]  WITH CHECK ADD  CONSTRAINT [FK_StatusPedido_HistoricoStatus] FOREIGN KEY([IdStatus])
REFERENCES [dbo].[StatusPedido] ([IdStatus])
GO
ALTER TABLE [dbo].[HistoricoStatus] CHECK CONSTRAINT [FK_StatusPedido_HistoricoStatus]
GO
ALTER TABLE [dbo].[ItemPedido]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_ItemPedido] FOREIGN KEY([IdPedido])
REFERENCES [dbo].[Pedido] ([IdPedido])
GO
ALTER TABLE [dbo].[ItemPedido] CHECK CONSTRAINT [FK_Pedido_ItemPedido]
GO
ALTER TABLE [dbo].[ItemPedido]  WITH CHECK ADD  CONSTRAINT [FK_Produto_ItemPedido] FOREIGN KEY([IdProduto])
REFERENCES [dbo].[Produtos] ([IdProduto])
GO
ALTER TABLE [dbo].[ItemPedido] CHECK CONSTRAINT [FK_Produto_ItemPedido]
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK_StatusPedido_Pedido] FOREIGN KEY([IdStatus])
REFERENCES [dbo].[StatusPedido] ([IdStatus])
GO
ALTER TABLE [dbo].[Pedido] CHECK CONSTRAINT [FK_StatusPedido_Pedido]
GO
/****** Object:  StoredProcedure [dbo].[ConsultarHistoricoPedido]    Script Date: 02/06/2019 23:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ConsultarHistoricoPedido 4, null, null --'2019-01-06 00:00:00', '2019-02-07 00:00:00'
CREATE PROCEDURE [dbo].[ConsultarHistoricoPedido]
	@IdPedido INT,
	@IdStatus INT,
	@DtInicialStatus DATETIME = NULL,
	@DtFinalStatus DATETIME = NULL
AS
BEGIN
	SELECT * FROM HistoricoStatus hs (NOLOCK)
		INNER JOIN StatusPedido sp2 (NOLOCK) ON hs.IdStatus=sp2.IdStatus	
	WHERE 1 = 1 
		 AND (@IdPedido IS NULL OR hs.IdPedido = @IdPedido)
		 AND (@IdStatus IS NULL OR hs.IdStatus = @IdStatus)
		 AND (@DtInicialStatus IS NULL OR hs.DataStatus BETWEEN @DtInicialStatus AND @DtFinalStatus)
	ORDER BY hs.DataStatus
END
GO
/****** Object:  StoredProcedure [dbo].[ConsultarHistoricoPedidosAgrupados]    Script Date: 02/06/2019 23:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- [ConsultarHistoricoPedidosAgrupados] 
CREATE PROCEDURE [dbo].[ConsultarHistoricoPedidosAgrupados]
AS
BEGIN
	SELECT hs.IdPedido, MAX(hs.IdStatus) AS IdStatus, 
		  (SELECT Nome FROM StatusPedido sp WHERE sp.IdStatus = MAX(hs.IdStatus)) AS Nome,
		  (SELECT DataStatus FROM HistoricoStatus WHERE IdStatus = MAX(hs.IdStatus) AND IdPedido = hs.IdPedido) AS DataStatus
      FROM HistoricoStatus hs(NOLOCK)
GROUP BY hs.IdPedido
END

GO
/****** Object:  StoredProcedure [dbo].[ConsultarItensPedido]    Script Date: 02/06/2019 23:41:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarItensPedido]
	@IdPedido INT
AS
BEGIN
	SELECT	p.IdPedido, p.ValorPedido, p.DataPrevisaoEntrega, sp1.Nome AS StatusPedido, 
			pr.IdProduto, pr.Nome, pr.PrecoVenda FROM Pedido p (NOLOCK)
		INNER JOIN StatusPedido sp1 (NOLOCK) ON p.IdStatus=sp1.IdStatus
		INNER JOIN ItemPedido itp (NOLOCK) ON itp.IdPedido=p.IdPedido
		INNER JOIN Produtos pr (NOLOCK) ON itp.IdProduto=pr.IdProduto
	WHERE p.IdPedido=@IdPedido
	
END
GO
USE [master]
GO
ALTER DATABASE [ViaVarejo] SET  READ_WRITE 
GO
