GO
/****** Object:  StoredProcedure [dbo].[ntm_deleteNetMeetingQuestions]    Script Date: 06/03/2009 14:40:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ntm_deleteNetMeetingQuestions]
	@NetmeetingId INT
	
AS
	BEGIN
     
     SET NOCOUNT ON     
			/* Set the IsAnswering parameter to True or False */
            DELETE FROM ntm_tblQuestion
            			
			WHERE NetmeetingId  = @NetmeetingId             
	END
RETURN
