﻿CREATE TABLE [dbo].[Dim_Contribuintes]
(
	[id] INT IDENTITY(1,1),
	[codigo] VARCHAR(50) NOT NULL PRIMARY KEY,
	[cpf_cnpj] VARCHAR(50) NOT NULL,
	[contribuinte] VARCHAR(500) NOT NULL,
	[id_fonte_dados] TINYINT NOT NULL,
	[uid_contribuintes] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	CONSTRAINT FK_dim_contribuintes_id_fonte_dados FOREIGN KEY (id_fonte_dados) REFERENCES DIM_AUX_Fonte_Dados(id)
);
