GO
/****** Object:  StoredProcedure [dbo].[ntm_checkStatusIsAnswering]    Script Date: 06/03/2009 14:39:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_checkStatusIsAnswering]
	@QuestionId INT
	                
AS
	BEGIN
     
     SET NOCOUNT ON     
			/* Checks the status on a question */
            SELECT *
            FROM ntm_tblQuestion
			WHERE QuestionId = @QuestionId AND IsAnswering = 1 			
	END
RETURN
