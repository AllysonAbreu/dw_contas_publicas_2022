CREATE TABLE [dbo].[Dim_Classe_Natureza_Despesa]
(
	[id] INT IDENTITY(1,1),
	[uid_dim_classe_elemento_despesa] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[cod_classe] BIGINT NOT NULL PRIMARY KEY,
	[descricao] VARCHAR(50) NOT NULL
)
