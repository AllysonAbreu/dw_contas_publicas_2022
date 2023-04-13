/*
Script de implantação para DW_Contas_Publicas

Este código foi gerado por uma ferramenta.
As alterações feitas nesse arquivo poderão causar comportamento incorreto e serão perdidas se
o código for gerado novamente.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DW_Contas_Publicas"
:setvar DefaultFilePrefix "DW_Contas_Publicas"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.DEVSERV\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.DEVSERV\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detecta o modo SQLCMD e desabilita a execução do script se o modo SQLCMD não tiver suporte.
Para reabilitar o script após habilitar o modo SQLCMD, execute o comando a seguir:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'O modo SQLCMD deve ser habilitado para executar esse script com êxito.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Criando Tabela [dbo].[Dim_Classes_Despesas_Receitas]...';


GO
CREATE TABLE [dbo].[Dim_Classes_Despesas_Receitas] (
    [id]                     INT              IDENTITY (1, 1) NOT NULL,
    [uid_dim_classe_receita] UNIQUEIDENTIFIER NOT NULL,
    [cod_classe]             VARCHAR (50)     NOT NULL,
    [descricao]              VARCHAR (150)    NOT NULL,
    PRIMARY KEY CLUSTERED ([cod_classe] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Dim_Contribuintes]...';


GO
CREATE TABLE [dbo].[Dim_Contribuintes] (
    [id]                INT              IDENTITY (1, 1) NOT NULL,
    [uid_contribuintes] UNIQUEIDENTIFIER NOT NULL,
    [codigo]            VARCHAR (50)     NOT NULL,
    [cpf_cnpj]          VARCHAR (50)     NOT NULL,
    [contribuinte]      VARCHAR (500)    NOT NULL,
    [fonte_dados]       VARCHAR (50)     NOT NULL,
    PRIMARY KEY CLUSTERED ([codigo] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Dim_Tempo]...';


GO
CREATE TABLE [dbo].[Dim_Tempo] (
    [id]            INT              IDENTITY (1, 1) NOT NULL,
    [uid_dim_tempo] UNIQUEIDENTIFIER NOT NULL,
    [data]          DATETIME         NOT NULL,
    [ano]           SMALLINT         NOT NULL,
    [mes]           VARCHAR (50)     NOT NULL,
    [dia]           TINYINT          NOT NULL,
    [trimestre]     VARCHAR (50)     NOT NULL,
    [cod_trimestre] TINYINT          NULL,
    [semestre]      VARCHAR (50)     NOT NULL,
    [cod_semestre]  TINYINT          NULL,
    PRIMARY KEY CLUSTERED ([data] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Fato_Despesa]...';


GO
CREATE TABLE [dbo].[Fato_Despesa] (
    [id]               INT              IDENTITY (1, 1) NOT NULL,
    [uid_fato_despesa] UNIQUEIDENTIFIER NOT NULL,
    [entidade_despesa] VARCHAR (50)     NOT NULL,
    [classe_despesa]   VARCHAR (50)     NOT NULL,
    [data_fato]        DATETIME         NOT NULL,
    [valor]            FLOAT (53)       NOT NULL,
    [liquidado]        FLOAT (53)       NOT NULL,
    [pago]             FLOAT (53)       NOT NULL,
    [saldo]            FLOAT (53)       NOT NULL,
    [fonte_dados]      VARCHAR (50)     NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Fato_Receita]...';


GO
CREATE TABLE [dbo].[Fato_Receita] (
    [id]               INT              IDENTITY (1, 1) NOT NULL,
    [uid_fato_receita] UNIQUEIDENTIFIER NOT NULL,
    [cod_receita]      VARCHAR (50)     NOT NULL,
    [data_fato]        DATETIME         NOT NULL,
    [entidade_receita] VARCHAR (50)     NOT NULL,
    [valor]            FLOAT (53)       NOT NULL,
    [fonte_dados]      VARCHAR (50)     NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
PRINT N'Criando Restrição Padrão restrição sem nome em [dbo].[Dim_Classes_Despesas_Receitas]...';


GO
ALTER TABLE [dbo].[Dim_Classes_Despesas_Receitas]
    ADD DEFAULT NEWID() FOR [uid_dim_classe_receita];


GO
PRINT N'Criando Restrição Padrão restrição sem nome em [dbo].[Dim_Contribuintes]...';


GO
ALTER TABLE [dbo].[Dim_Contribuintes]
    ADD DEFAULT NEWID() FOR [uid_contribuintes];


GO
PRINT N'Criando Restrição Padrão restrição sem nome em [dbo].[Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Dim_Tempo]
    ADD DEFAULT NEWID() FOR [uid_dim_tempo];


GO
PRINT N'Criando Restrição Padrão restrição sem nome em [dbo].[Fato_Despesa]...';


GO
ALTER TABLE [dbo].[Fato_Despesa]
    ADD DEFAULT NEWID() FOR [uid_fato_despesa];


GO
PRINT N'Criando Restrição Padrão restrição sem nome em [dbo].[Fato_Receita]...';


GO
ALTER TABLE [dbo].[Fato_Receita]
    ADD DEFAULT NEWID() FOR [uid_fato_receita];


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_data]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_data] FOREIGN KEY ([data_fato]) REFERENCES [dbo].[Dim_Tempo] ([data]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_classe_despesa]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_classe_despesa] FOREIGN KEY ([classe_despesa]) REFERENCES [dbo].[Dim_Classes_Despesas_Receitas] ([cod_classe]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_contribuintes]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_contribuintes] FOREIGN KEY ([entidade_despesa]) REFERENCES [dbo].[Dim_Contribuintes] ([codigo]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_receita_id_cod_receita]...';


GO
ALTER TABLE [dbo].[Fato_Receita] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_receita_id_cod_receita] FOREIGN KEY ([cod_receita]) REFERENCES [dbo].[Dim_Classes_Despesas_Receitas] ([cod_classe]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_receita_id_data]...';


GO
ALTER TABLE [dbo].[Fato_Receita] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_receita_id_data] FOREIGN KEY ([data_fato]) REFERENCES [dbo].[Dim_Tempo] ([data]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_receita_id_contribuintes]...';


GO
ALTER TABLE [dbo].[Fato_Receita] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_receita_id_contribuintes] FOREIGN KEY ([entidade_receita]) REFERENCES [dbo].[Dim_Contribuintes] ([codigo]);


GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_data];

ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_classe_despesa];

ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_contribuintes];

ALTER TABLE [dbo].[Fato_Receita] WITH CHECK CHECK CONSTRAINT [FK_fato_receita_id_cod_receita];

ALTER TABLE [dbo].[Fato_Receita] WITH CHECK CHECK CONSTRAINT [FK_fato_receita_id_data];

ALTER TABLE [dbo].[Fato_Receita] WITH CHECK CHECK CONSTRAINT [FK_fato_receita_id_contribuintes];


GO
PRINT N'Atualização concluída.';


GO
