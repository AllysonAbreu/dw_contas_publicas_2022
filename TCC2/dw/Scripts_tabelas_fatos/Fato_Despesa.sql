CREATE TABLE [dbo].[Fato_Despesa]
(
	[id] INT IDENTITY(1,1) PRIMARY KEY,
	[uid_fato_despesa] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[credor_despesa] VARCHAR(50) NOT NULL,
	[fonte_recurso] VARCHAR(150) NOT NULL,
	[orgao_interno] VARCHAR(200) NOT NULL,
	[orgao_vinculado] VARCHAR(250) NOT NULL,
	[data_fato] DATETIME NOT NULL,
	[cod_elemento] BIGINT NOT NULL,
	[cod_subelemento] BIGINT NOT NULL,
	[cod_funcao] BIGINT NOT NULL,
	[cod_subfuncao] BIGINT NOT NULL,
	[cod_natureza] BIGINT NOT NULL,
	[valor] FLOAT NOT NULL,
	[liquidado] FLOAT NOT NULL,
	[pago] FLOAT NOT NULL,
	[saldo] FLOAT NOT NULL,

    CONSTRAINT FK_fato_despesa_id_data FOREIGN KEY (data_fato) REFERENCES Dim_Tempo(data),
    CONSTRAINT FK_fato_despesa_id_contribuintes FOREIGN KEY (credor_despesa) REFERENCES Dim_Contribuintes(codigo),
    CONSTRAINT FK_fato_despesa_id_elemento FOREIGN KEY (cod_elemento) REFERENCES Dim_Classe_Elemento_Despesa(cod_classe),
    CONSTRAINT FK_fato_despesa_id_subelemento FOREIGN KEY (cod_subelemento) REFERENCES Dim_Classe_Subelemento_Despesa(cod_classe),
    CONSTRAINT FK_fato_despesa_id_funcao FOREIGN KEY (cod_funcao) REFERENCES Dim_Classe_Funcao_Despesa(cod_classe),
    CONSTRAINT FK_fato_despesa_id_subfuncao FOREIGN KEY (cod_subfuncao) REFERENCES Dim_Classe_Subfuncao_Despesa(cod_classe),
    CONSTRAINT FK_fato_despesa_id_natureza FOREIGN KEY (cod_natureza) REFERENCES Dim_Classe_Natureza_Despesa(cod_classe),

)