CREATE TABLE [dbo].[Fato_Receita]
(
	[id] INT IDENTITY(1,1) PRIMARY KEY,
	[uid_fato_receita] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[cod_receita] VARCHAR(50) NOT NULL,
	[data_fato] DATETIME NOT NULL,
	[entidade_receita] VARCHAR(50) NOT NULL,
	[valor] FLOAT NOT NULL,
	[fonte_dados] TINYINT NOT NULL,

	CONSTRAINT FK_fato_receita_id_cod_receita FOREIGN KEY (cod_receita) REFERENCES Dim_Classes_Receitas(cod_classe_receita),
    CONSTRAINT FK_fato_receita_id_data FOREIGN KEY (data_fato) REFERENCES Dim_Tempo(data),
    CONSTRAINT FK_fato_receita_id_contribuinte_receita FOREIGN KEY (entidade_receita) REFERENCES Dim_Contribuinte_Receita(codigo),
    CONSTRAINT FK_fato_receita_id_fonte_dados FOREIGN KEY (fonte_dados) REFERENCES DIM_AUX_Fonte_Dados(id)
);
