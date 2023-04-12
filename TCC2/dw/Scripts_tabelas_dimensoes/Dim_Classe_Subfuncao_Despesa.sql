CREATE TABLE [dbo].[Dim_Classe_Subfuncao_Despesa]
(
	[id] INT IDENTITY(1,1),
	[uid_dim_classe_subfuncao_despesa] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[cod_classe] BIGINT NOT NULL PRIMARY KEY,
	[descricao] VARCHAR(100) NOT NULL
)
