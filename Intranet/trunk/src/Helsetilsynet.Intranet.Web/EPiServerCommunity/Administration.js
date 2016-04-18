function SCSetTitle(title)
{
	if(document.title == 'ControlWrapper')
		document.title = title;
}
function SCOpenBrowseWindow(url, idElementId, nameElementId)
{
	window.open('ControlWrapper.aspx?control=' + url + '&idElementId=' + idElementId + '&nameElementId=' + nameElementId, '_blank', 'width=600, height=400, scrollbars=yes, resizable=yes');
}

function SCVideoGalleryOpenUploadWindow(vgId)
{
    window.open('../EPiServerCommunity/Modules/VideoGallery/UploadVideo.aspx?videoGalleryId=' + vgId, '_blank', 'width=600, height=290, scrollbars=yes, resizable=yes');
}

// Open the create video comment form.
function SCVideoGalleryOpenCreateVideoCommentWindow(vgId, videoControlId) {    
    window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/VideoGallery/CreateVideoCommentControl.ascx&videoId=' + vgId + '&videoControlId=' + videoControlId, '_blank', 'width=745, height=497, scrollbars=yes, resizable=yes');
}

// Open the edit video comment form.
function SCVideoGalleryOpenEditVideoCommentWindow(vcId, videoControlId) {
    window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/VideoGallery/EditVideoCommentControl.ascx&videoCommentId=' + vcId + '&videoControlId=' + videoControlId, '_blank', 'width=745, height=497, scrollbars=yes, resizable=yes');
}	

function SCImageGalleryOpenUploadWindow(igId, igControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/ImageGallery/UploadImageControl.ascx&imageGalleryId=' + igId + '&galleryControlId=' + igControlId, '_blank', 'width=600, height=225, scrollbars=no, resizable=yes');
}

function SCImageGalleryOpenImageInfoWindow(imageId)
{
    window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/ImageGallery/ImageInfoControl.ascx&imageId=' + imageId + '&data=7', '_blank', 'width=595, height=500, scrollbars=yes, resizable=yes');
}

function SCImageGalleryOpenEditImageCommentWindow(icId, imageControlId) {
    window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/ImageGallery/EditImageCommentControl.ascx&imageCommentId=' + icId + '&imageControlId=' + imageControlId, '_blank', 'width=745, height=497, scrollbars=yes, resizable=yes');
}

function SCBlogOpenCreateEntryWindow(blogId, blogControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Blog/CreateBlogEntryControl.ascx&blogId=' + blogId + '&blogControlId=' + blogControlId, '_blank', 'width=745, height=480, scrollbars=yes, resizable=yes');
}

function SCBlogOpenCreateEntryWindowAsExpert(expertLoginGuid, blogControlId)
{
	//Expert login uses a different ControlWrapper located in the Expert folder, therefore differnt path to controls.
	window.open('ControlWrapper.aspx?control=../Blog/CreateBlogEntryControl.ascx&blogControlId=' + blogControlId + '&expertLoginGuid=' + expertLoginGuid, '_blank', 'width=745, height=480, scrollbars=yes, resizable=yes');
}

function SCBlogOpenEditEntryWindow(entryId, blogControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Blog/EditBlogEntryControl.ascx&entryId=' + entryId + '&blogControlId=' + blogControlId, '_blank', 'width=820, height=600, scrollbars=yes, resizable=yes');
}

function SCBlogOpenEditEntryWindowAsExpert(expertLoginGuid, entryId, blogControlId)
{
	//Expert login uses a different ControlWrapper located in the Expert folder, therefore differnt path to controls.
	window.open('ControlWrapper.aspx?control=../Blog/EditBlogEntryControl.ascx&entryId=' + entryId + '&blogControlId=' + blogControlId + '&expertLoginGuid=' + expertLoginGuid, '_blank', 'width=820, height=600, scrollbars=yes, resizable=yes');
}

function SCBlogOpenBlog(blogId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Blog/BlogWrapper.ascx&blogId=' + blogId, '_blank', 'width=820, height=600, scrollbars=yes, resizable=yes');
}

function SCMyPageOpenEditUser(userId, relPath)
{
	window.open((relPath != null ? relPath : '') + 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/MyPage/EditUser.ascx&userId=' + userId, '_blank', 'width=825, height=600, scrollbars=yes, resizable=yes');
}

function SCDirectMessageOpenSystemMessageWindow(receiverType, systemMessageControlId, systemMessageSubjectId, systemMessageBodyId, selectionType)
{
	var numberChecked = 0;

	if (selectionType == 'selected')
	{
		numberChecked = SCNumberOfCheckboxesChecked('checkBoxAssociate');
	}
	
	if (numberChecked > 0 || selectionType == 'all')
		window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/DirectMessage/SystemMessageControl.ascx&receiverType=' + receiverType + '&systemMessageControlId=' + systemMessageControlId + '&systemMessageSubjectId=' + systemMessageSubjectId + '&systemMessageBodyId=' + systemMessageBodyId, '_blank', 'width=550, height=450, scrollbars=yes, resizable=yes');
	else
		alert('Please select at least one recipient');
}

function SCDirectMessageOpenMessageWindow(messageId, folderId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/DirectMessage/ReadMessageControl.ascx&messageId=' + messageId + '&folderId=' + folderId, '_blank', 'width=550, height=400, scrollbars=yes, resizable=yes');
}

function SCForumOpenRoomWindow(roomId, topicId, relPath)
{
	if(roomId == -1)
		alert('Room needs to be saved before moderation');
	else
		window.open((relPath != null ? relPath : '') + 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Forum/RoomControl.ascx&roomId=' + roomId + '&topicId=' + (topicId != null ? topicId : ''), '_blank', 'width=900, height=600, scrollbars=yes, resizable=yes');
}

function SCForumOpenMoveTopicWindow(topicId, topicControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Forum/MoveTopicControl.ascx&topicId=' + topicId + '&topicControlId=' + topicControlId, '_blank', 'width=580, height=590, scrollbars=yes, resizable=yes');
}

function SCClubOpenClubInfo(clubId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Club/ClubInfoControl.ascx&clubId=' + clubId, '_blank', 'width=865, height=600, scrollbars=yes, resizable=yes');
}

function SCExpertOpenExpertInfo(expertId, expertListControlId, relPath)
{
	window.open((relPath != null ? relPath : '') + 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Expert/ExpertInfoControl.ascx&expertId=' + expertId + '&expertListControlId=' + expertListControlId, '_blank', 'width=850, height=700, scrollbars=yes, resizable=yes');
}

function SCExpertOpenCreateExpert(expertListControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Expert/ExpertInfoControl.ascx&expertId=-1&expertListControlId=' + expertListControlId, '_blank', 'width=850, height=700, scrollbars=yes, resizable=yes');
}

function SCExpertReloadExpertInfoAsExpert(loginGuid, assignedQuestionId)
{
	window.location = 'ControlWrapper.aspx?control=ExpertInfoControl.ascx&loginGuid=' + loginGuid + '&assignedQuestionId=' + assignedQuestionId;
}

function SCExpertOpenSelectForumRoom(openerIdElement, openerNameElement)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Expert/SelectForumRoomControl.ascx&openerIdElement=' + openerIdElement + '&openerNameElement=' + openerNameElement, '_blank', 'width=580, height=590, scrollbars=yes, resizable=yes');
}

function SCExpertOpenQuestionInfo(questionId, questionListControlId, relPath)
{
	window.open((relPath != null ? relPath : '') + 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Expert/QuestionInfoControl.ascx&questionId=' + questionId + '&questionListControlId=' + questionListControlId, '_blank', 'width=850, height=430, scrollbars=yes, resizable=yes');
}

function SCExpertOpenAnswerInfo(answerId, questionListControlId, relPath)
{
	window.open((relPath != null ? relPath : '') + 'ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Expert/AnswerInfoControl.ascx&answerId=' + answerId + '&questionListControlId=' + questionListControlId, '_blank', 'width=850, height=430, scrollbars=yes, resizable=yes');
}

function SCCountChars(objTextarea, intMax)
{   
	intCurrentLength = (objTextarea.value).length;   
	if(intCurrentLength > intMax)
	{      
		objTextarea.value = (objTextarea.value).substring(0, intMax); 
		intCurrentLength--;      
		event.returnValue=false;   
	} 
	return intMax - intCurrentLength;
}

function SCDocumentArchiveOpenUploadWindow(daId, daControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/DocumentArchive/UploadDocumentControl.ascx&documentArchiveId=' + daId + '&archiveControlId=' + daControlId, '_blank', 'width=580, height=290, resizable=yes');
}

function SCNumberOfCheckboxesChecked(checkBoxName)
{
	var numberChecked = 0;
	var i;
		
	for (i = 0; i < document.forms[0].elements.length; i++) {
		var elem = document.forms[0].elements[i];
		if (elem.name.indexOf(checkBoxName) >= 0)
		{
			if(elem.checked)
				numberChecked = numberChecked + 1;
		}
	}
	
	return numberChecked;
}

function SCContestOpenContestInfo(contestId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Contest/ContestInfoControl.ascx&contestId=' + contestId, '_blank', 'width=880, height=600, scrollbars=yes, resizable=yes');
}

function SCContestOpenQuestion(questionId, contestId, type)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Contest/QuestionControlWrapper.ascx&questionId=' + questionId + "&contestId=" + contestId + "&type=" + type, '_blank', 'width=600, height=400, scrollbars=yes, resizable=yes');
}

function SCContestOpenSubmissionAnswers(submissionId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Contest/SubmissionAnswersControl.ascx&submissionId=' + submissionId, '_blank', 'width=450, height=400, scrollbars=yes, resizable=yes');
}

function SCPollOpenPollInfo(pollId, moduleName, clubId, myPageId, pollListControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Poll/PollInfoControl.ascx&pollId=' + pollId + "&moduleName=" + moduleName + "&clubId=" + clubId + "&myPageId=" + myPageId + "&pollListControlId="+pollListControlId, '_blank', 'width=800, height=700, scrollbars=yes, resizable=yes');
}

function SCPollOpenVotes(choiceId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Poll/PollVoteControl.ascx&choiceId=' + choiceId, '_blank', 'width=400, height=500, scrollbars=yes, resizable=yes');
}

function SCOpenAccessRights(moduleType, objectId, relPath)
{
    window.open((relPath != null ? relPath : '') + 'ControlWrapper.aspx?control=../EPiServerCommunity/Security/AccessRightsWrapperControl.ascx&moduleType=' + moduleType + "&objectId=" + objectId, '_blank', 'width=850, height=600, scrollbars=yes, resizable=yes');
}

function SCStarViralOpenCampaignInfo(campaignId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/StarViral/CampaignInfoControl.ascx&campaignId=' + campaignId, '_blank', 'width=800, height=570, scrollbars=yes, resizable=yes');
}

function SCCreatePredefinedTagInfo(tagControlId) {
    window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Tag/PredefinedTagInfoControl.ascx&tagControlId=' + tagControlId + '&tagId=-1', '_blank', 'width=830, height=745, scrollbars=yes, resizable=yes');
}

function SCOpenPredefinedTagInfo(tagControlId, tagId) {
    window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Tag/PredefinedTagInfoControl.ascx&tagControlId=' + tagControlId + '&tagId=' + tagId, '_blank', 'width=830, height=745, scrollbars=yes, resizable=yes');
}

function SCCalendarOpenCalendarInfo(calendarId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Calendar/CalendarControlWrapper.ascx&calendarId=' + calendarId, '_blank', 'width=830, height=745, scrollbars=yes, resizable=yes');
}

function SCCalendarCreateNewCalendar()
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Calendar/CalendarControlWrapper.ascx', '_blank', 'width=830, height=745, scrollbars=yes, resizable=yes');
}

function SCCalendarOpenEventInfo(eventId, calendarControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Calendar/CalendarEventInfoControl.ascx&eventId=' + eventId + '&calendarControlId=' + calendarControlId, '_blank', 'width=820, height=840, scrollbars=yes, resizable=yes');
}

function SCCalendarCreateNewEvent(calendarId, date, calendarControlId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Calendar/CalendarEventInfoControl.ascx&calendarId=' + calendarId + '&date=' + date + '&calendarControlId=' + calendarControlId, '_blank', 'width=820, height=840, scrollbars=yes, resizable=yes');
}

function SCWebmailOpenDomainInfo(domainId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Webmail/WebmailDomainInfoControl.ascx&domainId=' + domainId, '_blank', 'width=830, height=745, scrollbars=yes, resizable=yes');
}

function SCWebmailOpenMailServerInfo(mailServerId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Webmail/WebmailMailServerInfoControl.ascx&mailServerId=' + mailServerId, '_blank', 'width=830, height=745, scrollbars=yes, resizable=yes');
}

function SCWebmailOpenMailAccountInfo(mailAccountId, userId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Webmail/WebmailAccountInfoControl.ascx&accountId=' + mailAccountId+'&userId='+userId, '_blank', 'width=830, height=745, scrollbars=yes, resizable=yes');
}


function SCAttributeOpenAttributeInfo(attributeId, attributeControlId)
{
    window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Attribute/AttributeInfoControl.ascx&attributeId=' + attributeId + '&attributeControlId=' + attributeControlId, '_blank', 'width=700, height=400, scrollbars=yes, resizable=yes');
}

function SCReportingOpenReportedContentInfo(reportCaseId)
{
	window.open('ControlWrapper.aspx?control=../EPiServerCommunity/Modules/Reporting/ReportedContentInfoControl.ascx&reportCaseId=' + reportCaseId, '_blank', 'width=500, height=400, scrollbars=yes, resizable=yes');
}
