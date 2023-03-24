CREATE TABLE [dbo].[Dim_Tempo]
(
    [uid_dim_tempo] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [data] DATETIME NOT NULL,
    [ano] SMALLINT NOT NULL,
    [mes] VARCHAR(20) NOT NULL,
    [cod_mes] TINYINT NOT NULL,
    [dia] TINYINT NOT NULL,
    [trimestre] VARCHAR(50) NULL,
    [cod_trimestre] TINYINT NULL,
    [semestre] VARCHAR(50) NULL,
    [cod_semestre] TINYINT NULL
);
