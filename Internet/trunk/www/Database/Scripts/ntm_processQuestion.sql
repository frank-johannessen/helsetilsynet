GO
/****** Object:  StoredProcedure [dbo].[ntm_processQuestion]    Script Date: 06/03/2009 14:41:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_processQuestion]
	@QuestionId INT,
	@IsOnHold BIT,
	@IsThrown BIT
AS
	BEGIN
     
     SET NOCOUNT ON     
			/* Create new Answer to a Question */
            UPDATE ntm_tblQuestion
            
            SET
            IsThrown = @IsThrown,
            IsOnHold = @IsOnHold,
            IsAnswering = 0,
            IsAnswered = 0
			
			WHERE
				QuestionId = @QuestionId            
	END
RETURN
