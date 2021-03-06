GO
/****** Object:  StoredProcedure [dbo].[ntm_createQuestion]    Script Date: 06/03/2009 14:39:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_createQuestion]	
	@NetmeetingId INT,
	@QuestionTitle NVARCHAR(100),
	@WriterName NVARCHAR(100),
	@QuestionText NTEXT,
	@QuestionTime DATETIME
AS
	BEGIN
	DECLARE @QuestionId INT
    SET NOCOUNT ON
		/* Create new question */
        INSERT INTO ntm_tblQuestion
			(NetmeetingId, QuestionTitle ,WriterName, QuestionText, QuestionTime, IsAnswered, IsThrown, IsAnswering, IsOnHold)
        VALUES
			(@NetmeetingId, @QuestionTitle, @WriterName, @QuestionText, @QuestionTime, 0, 0, 0, 0)
		/* Remember question id for question */
		SET @QuestionId=@@IDENTITY

	END
RETURN