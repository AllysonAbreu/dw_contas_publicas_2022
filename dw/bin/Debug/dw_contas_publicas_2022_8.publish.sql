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
PRINT N'Removendo Restrição Padrão restrição sem nome em [dbo].[Dim_Tempo]...';


GO
ALTER TABLE [dbo].[Dim_Tempo] DROP CONSTRAINT [DF__Dim_Tempo__uid_d__05D8E0BE];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_despesa_id_data]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [FK_fato_despesa_id_data];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_receita_id_data]...';


GO
ALTER TABLE [dbo].[Fato_Receita] DROP CONSTRAINT [FK_fato_receita_id_data];


GO
PRINT N'Iniciando a recompilação da tabela [dbo].[Dim_Tempo]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Dim_Tempo] (
    [id]            INT              IDENTITY (1, 1) NOT NULL,
    [uid_dim_tempo] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
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

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Dim_Tempo])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Dim_Tempo] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Dim_Tempo] ([data], [id], [uid_dim_tempo], [ano], [mes], [dia], [trimestre], [cod_trimestre], [semestre], [cod_semestre])
        SELECT   [data],
                 [id],
                 [uid_dim_tempo],
                 [ano],
                 [mes],
                 [dia],
                 [trimestre],
                 [cod_trimestre],
                 [semestre],
                 [cod_semestre]
        FROM     [dbo].[Dim_Tempo]
        ORDER BY [data] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Dim_Tempo] OFF;
    END

DROP TABLE [dbo].[Dim_Tempo];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Dim_Tempo]', N'Dim_Tempo';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Alterando Tabela [dbo].[Fato_Despesa]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] ALTER COLUMN [data_fato] DATETIME NOT NULL;


GO
PRINT N'Alterando Tabela [dbo].[Fato_Receita]...';


GO
ALTER TABLE [dbo].[Fato_Receita] ALTER COLUMN [data_fato] DATETIME NOT NULL;


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_data]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_data] FOREIGN KEY ([data_fato]) REFERENCES [dbo].[Dim_Tempo] ([data]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_receita_id_data]...';


GO
ALTER TABLE [dbo].[Fato_Receita] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_receita_id_data] FOREIGN KEY ([data_fato]) REFERENCES [dbo].[Dim_Tempo] ([data]);


GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_data];

ALTER TABLE [dbo].[Fato_Receita] WITH CHECK CHECK CONSTRAINT [FK_fato_receita_id_data];


GO
PRINT N'Atualização concluída.';


GO
