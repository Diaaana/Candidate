public with sharing class CommunionCandidateController {
	public List<Candidate__c> candidates { get; set; }
	public ID candidateID;
	public String name { get; set; }
	public String surname { get; set; }
	public String middleName { get; set; }
	public String resume { get; set; }
	public String position { get; set; }
	public String needHR { get; set; }
	public String salary { get; set; }
	public String experience { get; set; }
	public String telephone { get; set; }
	public String mail { get; set; }
	public String skype { get; set; }
	public String status { get; set; }
	public String task { get; set; }
	public String coming { get; set; }
	public String contact { get; set; }
	public String dateInterview { get; set; }
	public String decisionPeriod { get; set; }
	public String decision { get; set; }
	public String amount { get; set; }
	public List<Candidate__History> changeCandidate { get; set; }

	public CommunionCandidateController() {
		candidateID = ApexPages.currentPage().getParameters().get('candidateID');
		candidates = [
			SELECT Name, Surname__c, MiddleName__c, PhoneNumber__c, Mail__c, Skype__c,
			Position__c, Salary__c, Experience__c, HR__c, Resume__c, Status__c
			FROM Candidate__c
			WHERE ID = :candidateID
		];

		this.surname = '';
		this.name = '';
		this.middleName = '';
		this.resume = '';
		this.position = '';
		this.needHR = '';
		this.salary = '';
		this.experience = '';
		this.telephone = '';
		this.mail = '';
		this.skype = '';
		this.status = '';
		this.task = '';
		this.coming = '';
		this.contact = '';
		this.dateInterview = '';
		this.decisionPeriod = '';
		this.decision = '';
		this.amount = '';

		changeCandidate = [
			SELECT ParentId, OldValue, NewValue, Field, CreatedById, CreatedDate
			FROM Candidate__History
			WHERE parentId = :CandidateId AND (Field ='Name' OR Field = 'Status__c')
		];
	}

	public PageReference editCandidate() {
		Candidate__c candidate = new Candidate__c(
			ID = candidateID,
			Name = name, 
			Surname__c = surname,
			MiddleName__c = middleName,
			Resume__c = resume,
			Position__c = position,
			HR__C = needHR,
			Salary__c = Integer.valueOf(salary), 
			Experience__c = Integer.valueOf(experience),
			PhoneNumber__c = telephone,
			Mail__c = mail, 
			Skype__c = skype,
			Status__c = status
		);
		update candidate;

		PageReference page = new PageReference('/apex/communionCandidatePage?candidateID=' + candidateID);
		page.setRedirect(true);
		return page;
	}

	public void createCommunionCandidate() {
		Candidate__c candidate = new Candidate__c(ID = candidateID, Status__c = status, Coming__c = coming, Contact__c = contact);

		insert new Interaction__c(
			Candidate__c = candidate.ID,
			Interview__c = Date.valueOf(dateInterview),
			DecisionPeriod__c = Integer.valueOf(decisionPeriod),
			Decision__c = decision,
			Amount__c = Integer.valueOf(amount)
		);

		update candidate;
	}
}