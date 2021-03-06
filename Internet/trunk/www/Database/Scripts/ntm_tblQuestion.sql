GO
/****** Object:  Table [dbo].[ntm_tblQuestion]    Script Date: 06/03/2009 14:41:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ntm_tblQuestion](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[NetmeetingId] [int] NOT NULL,
	[QuestionTitle] [nchar](100) COLLATE Danish_Norwegian_CI_AS NOT NULL,
	[WriterName] [nchar](100) COLLATE Danish_Norwegian_CI_AS NOT NULL,
	[QuestionText] [ntext] COLLATE Danish_Norwegian_CI_AS NOT NULL,
	[QuestionTime] [datetime] NOT NULL,
	[AnswerText] [ntext] COLLATE Danish_Norwegian_CI_AS NULL,
	[AnswerTime] [datetime] NULL,
	[IsAnswered] [bit] NULL,
	[IsThrown] [bit] NULL,
	[IsAnswering] [bit] NULL,
	[IsOnHold] [bit] NULL,
 CONSTRAINT [PK_ntm_tblQuestion] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
