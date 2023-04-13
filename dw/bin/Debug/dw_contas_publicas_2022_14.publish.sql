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
/*
Ignorando a coluna [dbo].[Fato_Despesa].[liquidado]; poderá ocorrer perda de dados.

Ignorando a coluna [dbo].[Fato_Despesa].[pago]; poderá ocorrer perda de dados.

Ignorando a coluna [dbo].[Fato_Despesa].[valor]; poderá ocorrer perda de dados.

A coluna [dbo].[Fato_Despesa].[valor_empenhado] na tabela [dbo].[Fato_Despesa] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.

A coluna [dbo].[Fato_Despesa].[valor_fixado] na tabela [dbo].[Fato_Despesa] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.

A coluna [dbo].[Fato_Despesa].[valor_liquidado] na tabela [dbo].[Fato_Despesa] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.

A coluna [dbo].[Fato_Despesa].[valor_pago] na tabela [dbo].[Fato_Despesa] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.
*/

IF EXISTS (select top 1 1 from [dbo].[Fato_Despesa])
    RAISERROR (N'Linhas foram detectadas. A atualização de esquema está sendo encerrada porque pode ocorrer perda de dados.', 16, 127) WITH NOWAIT

GO
PRINT N'Removendo Restrição Padrão restrição sem nome em [dbo].[Fato_Despesa]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [DF__Fato_Desp__uid_f__477199F1];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_despesa_id_data]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [FK_fato_despesa_id_data];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_despesa_id_contribuintes]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [FK_fato_despesa_id_contribuintes];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_despesa_id_elemento]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [FK_fato_despesa_id_elemento];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_despesa_id_subelemento]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [FK_fato_despesa_id_subelemento];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_despesa_id_funcao]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [FK_fato_despesa_id_funcao];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_despesa_id_subfuncao]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [FK_fato_despesa_id_subfuncao];


GO
PRINT N'Removendo Chave Estrangeira [dbo].[FK_fato_despesa_id_natureza]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] DROP CONSTRAINT [FK_fato_despesa_id_natureza];


GO
PRINT N'Iniciando a recompilação da tabela [dbo].[Fato_Despesa]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Fato_Despesa] (
    [id]               INT              IDENTITY (1, 1) NOT NULL,
    [uid_fato_despesa] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
    [credor_despesa]   VARCHAR (50)     NOT NULL,
    [fonte_recurso]    VARCHAR (150)    NOT NULL,
    [orgao_interno]    VARCHAR (200)    NOT NULL,
    [orgao_vinculado]  VARCHAR (250)    NOT NULL,
    [data_fato]        DATETIME         NOT NULL,
    [cod_elemento]     BIGINT           NOT NULL,
    [cod_subelemento]  BIGINT           NOT NULL,
    [cod_funcao]       BIGINT           NOT NULL,
    [cod_subfuncao]    BIGINT           NOT NULL,
    [cod_natureza]     BIGINT           NOT NULL,
    [valor_fixado]     FLOAT (53)       NOT NULL,
    [valor_empenhado]  FLOAT (53)       NOT NULL,
    [valor_liquidado]  FLOAT (53)       NOT NULL,
    [valor_pago]       FLOAT (53)       NOT NULL,
    [saldo]            FLOAT (53)       NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Fato_Despesa])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Fato_Despesa] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Fato_Despesa] ([id], [uid_fato_despesa], [credor_despesa], [fonte_recurso], [orgao_interno], [orgao_vinculado], [data_fato], [cod_elemento], [cod_subelemento], [cod_funcao], [cod_subfuncao], [cod_natureza], [saldo])
        SELECT   [id],
                 [uid_fato_despesa],
                 [credor_despesa],
                 [fonte_recurso],
                 [orgao_interno],
                 [orgao_vinculado],
                 [data_fato],
                 [cod_elemento],
                 [cod_subelemento],
                 [cod_funcao],
                 [cod_subfuncao],
                 [cod_natureza],
                 [saldo]
        FROM     [dbo].[Fato_Despesa]
        ORDER BY [id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Fato_Despesa] OFF;
    END

DROP TABLE [dbo].[Fato_Despesa];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Fato_Despesa]', N'Fato_Despesa';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_data]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_data] FOREIGN KEY ([data_fato]) REFERENCES [dbo].[Dim_Tempo] ([data]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_contribuintes]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_contribuintes] FOREIGN KEY ([credor_despesa]) REFERENCES [dbo].[Dim_Contribuintes] ([codigo]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_elemento]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_elemento] FOREIGN KEY ([cod_elemento]) REFERENCES [dbo].[Dim_Classe_Elemento_Despesa] ([cod_classe]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_subelemento]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_subelemento] FOREIGN KEY ([cod_subelemento]) REFERENCES [dbo].[Dim_Classe_Subelemento_Despesa] ([cod_classe]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_funcao]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_funcao] FOREIGN KEY ([cod_funcao]) REFERENCES [dbo].[Dim_Classe_Funcao_Despesa] ([cod_classe]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_subfuncao]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_subfuncao] FOREIGN KEY ([cod_subfuncao]) REFERENCES [dbo].[Dim_Classe_Subfuncao_Despesa] ([cod_classe]);


GO
PRINT N'Criando Chave Estrangeira [dbo].[FK_fato_despesa_id_natureza]...';


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH NOCHECK
    ADD CONSTRAINT [FK_fato_despesa_id_natureza] FOREIGN KEY ([cod_natureza]) REFERENCES [dbo].[Dim_Classe_Natureza_Despesa] ([cod_classe]);


GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_data];

ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_contribuintes];

ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_elemento];

ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_subelemento];

ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_funcao];

ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_subfuncao];

ALTER TABLE [dbo].[Fato_Despesa] WITH CHECK CHECK CONSTRAINT [FK_fato_despesa_id_natureza];


GO
PRINT N'Atualização concluída.';


GO
