CREATE TABLE [dbo].[Dim_Classes_Receitas]
(
    [id] INT IDENTITY(1,1),
	[uid_dim_classe_receita] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	[cod_classe] BIGINT NOT NULL PRIMARY KEY,
	[descricao] VARCHAR(150) NOT NULL
);
