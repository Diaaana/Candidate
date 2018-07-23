public class MainController {
	public List<User__c> usersList {
		get {
			List<User__c> usersList = [
			SELECT CreatedDate, Worker__r.Name, Worker__r.Surname__c, Worker__r.MiddleName__c, Name
			FROM User__c
			];
			return usersList;
		} 
		set;
	}

	public List<Candidate__c> candidatesList {
		get {
			List<Candidate__c> candidatesList = [
			SELECT Name, Surname__c, MiddleName__c, LastMeeting__c, Resume__c, 
			Position__c, HR__c, Salary__c, Experience__c, PhoneNumber__c, Mail__c, Skype__c, Status__c
			FROM Candidate__c
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
			];
			return workersList;
		} 
		set;
	}

	public String candidateID { get; set; }
	public String workerID { get; set; }

	public MainController() {
		this.candidateID = '';
		this.workerID = '';
	}

	public pageReference goToAddCandidatePage() {
		return Page.addCandidatePage;
	}

	public pageReference goToAddWorkerPage() {
		return Page.addWorkerPage;
	}

	public pageReference goToCandidatePage() {
		ID candidateIDValue = ID.valueOf(candidateID);
		PageReference page = Page.communionCandidatePage;
		page.getParameters().put('candidateID', candidateIDValue);
		return page;
	}

	public pageReference deleteWorker() {
		Worker__c worker = new Worker__c(ID = ID.valueOf(workerID));
		delete worker;
		PageReference page = new PageReference('/apex/mainPage');
		page.setRedirect(true);
		return page;
	}

}