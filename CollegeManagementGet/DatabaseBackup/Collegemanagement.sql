USE [CollegeManagement]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 5/2/2021 1:41:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Malayalam] [int] NOT NULL,
	[Hindi] [int] NOT NULL,
	[English] [int] NOT NULL,
	[Time] [datetime] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([Id], [Name], [Malayalam], [Hindi], [English], [Time]) VALUES (1, N'Ammu', 70, 80, 90, CAST(N'2021-04-30T21:50:34.263' AS DateTime))
INSERT [dbo].[Student] ([Id], [Name], [Malayalam], [Hindi], [English], [Time]) VALUES (2, N'Balu', 90, 85, 70, CAST(N'2021-04-30T21:54:58.647' AS DateTime))
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
/****** Object:  StoredProcedure [dbo].[StudentDetails]    Script Date: 5/2/2021 1:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[StudentDetails]
	@Id INT
AS
BEGIN
SELECT
	[Id]
	,	[Name]
	,	[Malayalam]
	,	[Hindi]
	,	[English]
	,	([Malayalam]+[Hindi]+[English])		AS Total
	,	([Malayalam]+[Hindi]+[English]/3)	AS Average
	,	[Time]
FROM	[dbo].[Student]
WHERE	[Id]=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[StudentList]    Script Date: 5/2/2021 1:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[StudentList]
	@Order INT
AS
	IF @Order=0
BEGIN
	SELECT
		[Name]
	,	[Malayalam]
	,	[Hindi]
	,	[English]
	,	[Time]
	FROM	[dbo].[Student]
	ORDER BY [Name] DESC
END
	IF @Order=1
BEGIN
	SELECT
		[Name]
	,	[Malayalam]
	,	[Hindi]
	,	[English]
	,	[Time]
	FROM	[dbo].[Student]
	ORDER BY [Name] ASC
END
GO
/****** Object:  StoredProcedure [dbo].[StudentSave]    Script Date: 5/2/2021 1:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[StudentSave]
	@Name				VARCHAR(20)
	,	@Malayalam		INT
	,	@Hindi			INT
	,	@English		INT
	,	@LastStudentId	INT			output
	,	@CreateTime		VARCHAR(50)	output
AS
BEGIN
INSERT INTO 	[dbo].[Student]
(
	[Name]
	,	[Malayalam]
	,	[Hindi]
	,	[English]
	,	[Time]
)
VALUES
(
	@Name
	,	@Malayalam
	,	@Hindi
	,	@English
	,	GETDATE()
)
SET
	@LastStudentId=SCOPE_IDENTITY()
SET
	@CreateTime=GETDATE()
RETURN
	@LastStudentId
RETURN
	@CreateTime
END
GO
/****** Object:  StoredProcedure [dbo].[StudentUpdate]    Script Date: 5/2/2021 1:41:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[StudentUpdate]
	@Id			INT			output
	,	@Name	VARCHAR(20) output
AS
BEGIN
UPDATE [dbo].[Student]
SET		[Name]=@Name
WHERE	[Id]=@Id
SELECT TOP 1
	[Id]
	,	[Name]
FROM	[dbo].[Student] ORDER BY GETDATE() DESC
RETURN
	@Id
RETURN
	@Name
END
GO
