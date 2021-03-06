GO
/****** Object:  StoredProcedure [dbo].[ntm_getQuestions]    Script Date: 06/03/2009 14:40:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_getQuestions]
	@NetmeetingId INT,
	@NumberOfItems INT,
	@IsAnswered BIT,
	@IsThrown BIT,
	@IsOnHold BIT,
	@IsReport BIT
	                
AS
	 /* Get all questions for a given NetmeetingId */
	BEGIN
		SET NOCOUNT ON
		/* Select all questions without limitations because we are generating reports */
		IF(@IsReport = 1)
			BEGIN
				SELECT *
				FROM ntm_tblQuestion
				WHERE NetmeetingId = @NetmeetingId AND IsAnswered = @IsAnswered AND IsThrown = @IsThrown AND IsOnHold = @IsOnHold AND (IsAnswering <> 1 OR IsAnswering is null)
			END
		 /* Select all questions that is answered and order by answer time */
		 ELSE IF (@IsAnswered = 1)
			BEGIN   	
				SELECT *
				FROM ntm_tblQuestion
				WHERE NetmeetingId = @NetmeetingId AND IsAnswered = @IsAnswered AND IsThrown = @IsThrown AND IsOnHold = @IsOnHold AND (IsAnswering <> 1 OR IsAnswering is null)
				ORDER BY AnswerTime DESC
			END 
		/* Select other questions. Only select count(@NumberOfItems) that is sent into procedure */				
		ELSE
			BEGIN
				SELECT TOP (@NumberOfItems) *
				FROM ntm_tblQuestion
				WHERE NetmeetingId = @NetmeetingId AND IsAnswered = @IsAnswered AND IsThrown = @IsThrown AND IsOnHold = @IsOnHold AND (IsAnswering <> 1 OR IsAnswering is null)
			END
	END
RETURN