CREATE TABLE [dbo].[Dim_Tempo]
(
    [uid_dim_tempo] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    [id] INT IDENTITY(1,1),
    [data] DATETIME NOT NULL PRIMARY KEY,
    [ano] SMALLINT NOT NULL,
    [mes] TINYINT NOT NULL,
    [dia] TINYINT NOT NULL,
    [cod_trimestre] TINYINT NULL,
    [cod_semestre] TINYINT NULL,
    CONSTRAINT FK_dim_tempo_id_mes FOREIGN KEY (mes) REFERENCES DIM_AUX_Meses(id),
    CONSTRAINT FK_dim_tempo_id_trimestre FOREIGN KEY (cod_trimestre) REFERENCES DIM_AUX_Trimestre(id),
    CONSTRAINT FK_dim_tempo_id_semestre FOREIGN KEY (cod_semestre) REFERENCES DIM_AUX_Semestre(id)
);
