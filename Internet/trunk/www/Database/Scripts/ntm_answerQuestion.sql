GO
/****** Object:  StoredProcedure [dbo].[ntm_answerQuestion]    Script Date: 06/03/2009 14:39:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_answerQuestion]
	@QuestionId INT,
	@QuestionTitle NVARCHAR(100),	
	@QuestionText NTEXT,
	@AnswerText NTEXT,
	@AnswerTime DATETIME
	
AS
	BEGIN
     
     SET NOCOUNT ON     
			/* Create new Answer to a Question */
            UPDATE ntm_tblQuestion
        SET
        QuestionTitle = @QuestionTitle,
        QuestionText = @QuestionText, 
        AnswerText = @AnswerText, 
        AnswerTime = @AnswerTime, 
        IsAnswered = 1, 
        IsThrown = 0, 
        IsAnswering = 0,
        IsOnHold = 0        
			
			WHERE
				QuestionId = @QuestionId            
	END
RETURN