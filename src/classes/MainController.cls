public class MainController {
	public List<User__c> usersList {
		get {
			List<User__c> usersList = [
			SELECT CreatedDate, Worker__r.Name, Worker__r.Surname__c, Worker__r.MiddleName__c, Name
			FROM User__c
			ORDER BY CreatedDate DESC
			];
			return usersList;
		} 
		set;
	}

	public List<Candidate__c> candidatesList {
		get {
			List<Candidate__c> candidatesList = [
			SELECT Name, Surname__c, MiddleName__c, Resume__c, 
			Position__c, HR__c, Salary__c, Experience__c, PhoneNumber__c, Mail__c, Skype__c, Status__c
			FROM Candidate__c
			ORDER BY CreatedDate DESC
			];
			return candidatesList;
		} 
		set;
	}

	public List<Worker__c> workersList {
		get {
			List<Worker__c> workersList = [
			SELECT Name, Surname__c, MiddleName__c, Position__c
			FROM Worker__c
			ORDER BY CreatedDate DESC
			];
			return workersList;
		} 
		set;
	}

	public String candidateID { get; set; }
	public String workerID { get; set; }
	public String roleValue { get; set; }
	public String userID { get; set; }
	public String workerSurname { get; set; }
	public String activeTab { get; set; }

	public MainController() {
		this.candidateID = '';
		this.workerID = '';
		this.roleValue = ApexPages.currentPage().getParameters().get('role');
		this.userID = ApexPages.currentPage().getParameters().get('user');
		this.workerSurname = '';
		this.activeTab = ApexPages.currentPage().getParameters().get('tab');
	}

	public PageReference goToAddCandidatePage() {
		PageReference page = Page.addCandidatePage;
		page.getParameters().put('role', roleValue);
		page.getParameters().put('tab', 'candidates');
		page.setRedirect(true);
		return page;
	}

	public PageReference goToAddWorkerPage() {
		PageReference page = Page.addWorkerPage;
		page.getParameters().put('role', roleValue);
		page.getParameters().put('tab', 'workers');
		page.setRedirect(true);
		return page;
	}

	public PageReference goToCandidatePage() {
		PageReference page = Page.communionCandidatePage;
		page.getParameters().put('candidateID', ID.valueOf(candidateID));
		page.getParameters().put('role', roleValue);
		page.setRedirect(true);
		return page;
	}

	public PageReference deleteWorker() {
		Worker__c worker = new Worker__c(ID = ID.valueOf(workerID));
		delete worker;
		PageReference page = Page.mainPage;
		page.getParameters().put('role', roleValue);
		page.getParameters().put('tab', 'workers');
		page.setRedirect(true);
		return page;
	}

	public PageReference goToPersonalPage() {
		PageReference page = Page.personalUserPage;
		page.getParameters().put('user', userID);
		page.setRedirect(true);
		return page;
	}

	public PageReference logout() {
		PageReference page = Page.loginPage;
		page.setRedirect(true);
		return page;
	}

	public PageReference showWorkerInteraction() {
		PageReference page = Page.workerInteractionPage;
		page.getParameters().put('worker', workerSurname);
		page.getParameters().put('role', roleValue);
		page.setRedirect(true);
		return page;
	}

	public PageReference goToCommentsPage() {
		PageReference page = Page.commentsPage;
		page.getParameters().put('worker', workerID);
		page.getParameters().put('role', roleValue);
		page.setRedirect(true);
		return page;
	}

}