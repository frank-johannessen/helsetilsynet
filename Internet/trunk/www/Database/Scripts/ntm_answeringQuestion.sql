GO
/****** Object:  StoredProcedure [dbo].[ntm_answeringQuestion]    Script Date: 06/03/2009 14:37:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_answeringQuestion]
	@QuestionId INT,
	@IsAnswering BIT
	
AS
	BEGIN
     
     SET NOCOUNT ON     
			/* Set the IsAnswering parameter to True or False */
            UPDATE ntm_tblQuestion
            
            SET
            IsAnswering = @IsAnswering
			
			WHERE
				QuestionId = @QuestionId            
	END
RETURN