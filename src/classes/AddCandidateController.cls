public with sharing class AddCandidateController {
	public String selectHR { get; set; }
	public String surname { get; set; }
	public String name { get; set; }
	public String middleName { get; set; }
	public String resume { get; set; }
	public String position { get; set; }
	public String needHR { get; set; }
	public String salary { get; set; }
	public String experience { get; set; }
	public String telephone { get; set; }
	public String mail { get; set; }
	public String skype { get; set; }
	public String coming { get; set; }
	public String contact { get; set; }

	public AddCandidateController() {
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
		this.coming = '';
		this.contact = '';
	}

	public List<SelectOption> getHR {
		get {

			List<Worker__c> HRList = [SELECT Name, Surname__c FROM Worker__c WHERE Role__r.Name = 'HR'];
			List<SelectOption> listOptions = new List<SelectOption>();

			for (Worker__c HRWorker : HRList) {

				String value = HRWorker.Name + ' ' + HRWorker.Surname__c;
				listOptions.add(new SelectOption(HRWorker.Surname__c, value));

			}
			return listOptions;
		}
		set;
	}

	public void createCandidate() {
		insert new Candidate__c(
			Name = name, 
			Surname__c = surname,
			MiddleName__c = middleName,
			Resume__c = resume,
			Position__c = position,
			Salary__c = 50.0, 
			Experience__c = 20,
			PhoneNumber__c = telephone
		);
	}
}