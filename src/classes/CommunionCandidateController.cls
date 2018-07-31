public class CommunionCandidateController {
	public PageReference communionPage;
	public ID candidateID;
	public String roleValue;
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
	public List<Candidate__c> candidates { get; set; }
	public List<Candidate__History> changeCandidate { get; set; }
	public List<Interaction__c> interactions { get; set; }

	public CommunionCandidateController() {
		this.communionPage = new PageReference('/apex/communionCandidatePage');
		this.candidateID = ApexPages.currentPage().getParameters().get('candidateID');
		this.roleValue = ApexPages.currentPage().getParameters().get('role');
		this.communionPage.getParameters().put('candidateID', candidateID);
		this.communionPage.getParameters().put('role', roleValue);
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

		candidates = [
			SELECT Name, Surname__c, MiddleName__c, PhoneNumber__c, Mail__c, Skype__c,
			Position__c, Salary__c, Experience__c, HR__c, Resume__c, Status__c
			FROM Candidate__c
			WHERE ID = :candidateID
		];

		changeCandidate = [
			SELECT ParentId, OldValue, NewValue, Field, CreatedById, CreatedDate
			FROM Candidate__History
			WHERE parentId = :CandidateId 
			AND (Field ='Status__c' OR Field = 'Mail__c' OR Field = 'Skype__c' OR Field = 'PhoneNumber__c')
		];

		interactions = [
			SELECT Interview__c, Task__c, DecisionPeriod__c, Decision__c, Amount__c
			FROM Interaction__c
			WHERE Candidate__c = :candidateID
		];
	}

	public PageReference editCandidate() {

		if (status.equals('Decision is made')) {
			
			List<Interaction__c> interactions = new List<Interaction__c>();
			interactions = [
				SELECT Name, Candidate__r.Surname__c
				FROM Interaction__c
				WHERE Candidate__c = :candidateID
			];
			
			for (Integer i = 0; i < interactions.size(); i++) {
				interactions[i].Name = interactions[i].Candidate__r.Surname__c;
				update interactions[i];
			}
		}

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

		communionPage.setRedirect(true);
		return communionPage;
	}

	public PageReference createCommunionCandidate() {
		Candidate__c candidate = new Candidate__c(ID = candidateID, Coming__c = coming, Contact__c = contact);

		insert new Interaction__c(
			Candidate__c = candidate.ID,
			Task__c = task,
			Interview__c = Date.valueOf(dateInterview),
			DecisionPeriod__c = Integer.valueOf(decisionPeriod),
			Decision__c = decision,
			Amount__c = Integer.valueOf(amount)
		);

		update candidate;

		communionPage.setRedirect(true);
		return communionPage;
	}

	public pageReference goToMainPage() {
		PageReference page = Page.mainPage;
		page.getParameters().put('role', roleValue);
		page.getParameters().put('tab', 'candidates');
		page.setRedirect(true);
		return page;
	}
}