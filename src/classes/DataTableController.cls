public with sharing class DataTableController {
	public String typeWorker { get; set; }
	public List<Client__c> clientsList {
		get {
			List<Client__c> clientsList = [
			SELECT CreatedDate, Name, Surname__c, MiddleName__c, ClientName__c
			FROM Client__c
			];
			return clientsList;
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
			SELECT Name, Surname__c, MiddleName__c, Role__r.Name
			FROM Worker__c
			];
			return workersList;
		} 
		set;
	}

	public DataTableController() {
	}

	public void get() {
		System.assert(false, typeWorker);
	}

}