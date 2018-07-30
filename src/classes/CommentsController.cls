public class CommentsController {
	public String roleValue;
	public String workerID;
	public String name { get; set; }
	public String surname { get; set; }
	public String commentValue { get; set; }
	public List<Comment__c> comments { get; set; }
 
	public CommentsController() {
		this.roleValue = ApexPages.currentPage().getParameters().get('role');
		this.workerID = ApexPages.currentPage().getParameters().get('worker');
		this.name = '';
		this.surname = '';
		this.commentValue = '';

		this.comments = [
			SELECT CreatedDate, Name__c, Surname__c, CommentContent__c
			FROM Comment__c
			WHERE Worker__c = :workerID
			ORDER BY CreatedDate DESC
		];
	}

	public PageReference addComment() {
		insert new Comment__c(
			Worker__c = workerID,
			Name__c = name,
			Surname__c = surname,
			CommentContent__c = commentValue
		);

		PageReference page = Page.commentsPage;
		page.getParameters().put('worker', workerID);
		page.getParameters().put('role', roleValue);
		page.setRedirect(true);
		return page;
	}

	public pageReference goToMainPage() {
		PageReference page = Page.mainPage;
		page.getParameters().put('role', roleValue);
		page.getParameters().put('tab', 'workers');
		page.setRedirect(true);
		return page;
	}
}