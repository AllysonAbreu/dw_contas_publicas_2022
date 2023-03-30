CREATE TABLE [dbo].[Fato_Receita]
(
	[id] INT IDENTITY(1,1) PRIMARY KEY,
	[uid_fato_receita] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[cod_receita] VARCHAR(50) NOT NULL,
	[data_fato] DATETIME NOT NULL,
	[entidade_receita] VARCHAR(50) NOT NULL,
	[valor] FLOAT NOT NULL,
	[fonte_dados] VARCHAR(50) NOT NULL,

	CONSTRAINT FK_fato_receita_id_cod_receita FOREIGN KEY (cod_receita) REFERENCES Dim_Classes_Despesas_Receitas(cod_classe),
    CONSTRAINT FK_fato_receita_id_data FOREIGN KEY (data_fato) REFERENCES Dim_Tempo(data),
    CONSTRAINT FK_fato_receita_id_contribuintes FOREIGN KEY (entidade_receita) REFERENCES Dim_Contribuintes(codigo),
);
