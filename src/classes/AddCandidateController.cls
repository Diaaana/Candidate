public with sharing class AddCandidateController {
	public String selectHR { get; set; }
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
	public String coming { get; set; }
	public String contact { get; set; }

	public List<SelectOption> getHR {
		get {

			List<Worker__c> HRList = [SELECT Name, Surname__c FROM Worker__c WHERE RecordType.Name = 'HR'];
			List<SelectOption> listOptions = new List<SelectOption>();

			for (Worker__c HRWorker : HRList) {

				String value = HRWorker.Name + ' ' + HRWorker.Surname__c;
				listOptions.add(new SelectOption(value, value));

			}
			return listOptions;
		}
		set;
	}

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

	public PageReference createCandidate() {
		insert new Candidate__c(
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
			Coming__c = coming,
			Contact__c = contact,
			Status__c = 'Старт'
		);

		return Page.mainPage;
	}
}