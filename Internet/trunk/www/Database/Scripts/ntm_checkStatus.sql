GO
/****** Object:  StoredProcedure [dbo].[ntm_checkStatus]    Script Date: 06/03/2009 14:39:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_checkStatus]
	@QuestionId INT,
	@IsAnswered BIT,
	@IsThrown BIT,
	@IsOnHold BIT,
	@IsAnswering BIT
	                
AS
	BEGIN
     
     SET NOCOUNT ON     
			/* Checks the status on a question */
            SELECT *
            FROM ntm_tblQuestion
			WHERE QuestionId = @QuestionId AND IsAnswered = @IsAnswered AND IsThrown = @IsThrown AND IsOnHold = @IsOnHold AND IsAnswering = @IsAnswering 			
	END
RETURN
