GO
/****** Object:  StoredProcedure [dbo].[ntm_getIsAnsweringQuestions]    Script Date: 06/03/2009 14:40:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_getIsAnsweringQuestions]
	@NetmeetingId INT
	                
AS
	BEGIN	
     
     SET NOCOUNT ON     
			/* Get all is answering questions for a given NetmeetingId */
            SELECT *
            FROM ntm_tblQuestion
			WHERE NetmeetingId = @NetmeetingId AND IsAnswering = 1
	END
RETURN
