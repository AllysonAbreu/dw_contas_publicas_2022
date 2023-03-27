CREATE TABLE [dbo].[Dim_Classes_Receitas]
(
  [id] INT IDENTITY(1,1),
  [uid_classe_receitas] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
  [cod_classe_receita] VARCHAR(50) NOT NULL PRIMARY KEY,
  [descricao_receita] VARCHAR(150) NULL
);