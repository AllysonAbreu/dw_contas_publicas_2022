CREATE TABLE [dbo].[Fato_Despesa]
(
	[id] INT IDENTITY(1,1) PRIMARY KEY,
	[uid_fato_despesa] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[entidade_despesa] VARCHAR(50) NOT NULL,
	[classe_despesa] VARCHAR(50) NOT NULL,
	[data_fato] DATETIME NOT NULL,
	[valor] FLOAT NOT NULL,
	[liquidado] FLOAT NOT NULL,
	[pago] FLOAT NOT NULL,
	[saldo] FLOAT NOT NULL,
	[fonte_dados] TINYINT NOT NULL,

    CONSTRAINT FK_fato_despesa_id_data FOREIGN KEY (data_fato) REFERENCES Dim_Tempo(data),
    CONSTRAINT FK_fato_despesa_classe_despesa FOREIGN KEY (classe_despesa) REFERENCES Dim_Classes_Despesas(cod_classe_despesa),
    CONSTRAINT FK_fato_despesa_id_contribuintes FOREIGN KEY (entidade_despesa) REFERENCES Dim_Contribuintes(codigo),
    CONSTRAINT FK_fato_despesa_id_fonte_dados FOREIGN KEY (fonte_dados) REFERENCES DIM_AUX_Fonte_Dados(id)
)