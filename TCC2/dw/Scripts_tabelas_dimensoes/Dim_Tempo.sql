CREATE TABLE [dbo].[Dim_Tempo]
(
    [id] INT IDENTITY(1,1),
    [uid_dim_tempo] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    [data] DATETIME NOT NULL PRIMARY KEY,
    [ano] SMALLINT NOT NULL,
    [mes] VARCHAR(50) NOT NULL,
    [dia] TINYINT NOT NULL,
    [trimestre] VARCHAR(50) NOT NULL,
    [cod_trimestre] TINYINT NULL,
    [semestre] VARCHAR(50) NOT NULL,
    [cod_semestre] TINYINT NULL,
);
