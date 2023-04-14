CREATE TABLE [dbo].[Fato_Receita]
(
	[id] INT IDENTITY(1,1) PRIMARY KEY,
	[uid_fato_receita] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[cod_receita] BIGINT NOT NULL,
	[data_fato] DATETIME NOT NULL,
	[contribuinte_receita] VARCHAR(50) NOT NULL,
	[valor] FLOAT NOT NULL,

	CONSTRAINT FK_fato_receita_id_cod_receita FOREIGN KEY (cod_receita) REFERENCES Dim_Classes_Receitas(cod_classe),
    CONSTRAINT FK_fato_receita_id_data FOREIGN KEY (data_fato) REFERENCES Dim_Tempo(data),
    CONSTRAINT FK_fato_receita_id_contribuintes FOREIGN KEY (contribuinte_receita) REFERENCES Dim_Contribuintes(codigo),
);
