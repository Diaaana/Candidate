public class RegistrationController {
	public String surname { get; set; }
	public String name { get; set; }
	public String middleName { get; set; }
	public String login { get; set; }
	public String password { get; set; }

	public RegistrationController() {
		this.surname = '';
		this.name = '';
		this.middleName = '';
		this.login = '';
		this.password = '';
	}

	public PageReference doRegistration() {
		Worker__c worker = new Worker__c(Surname__c = surname, Name = name, MiddleName__c = middleName);

		insert new User__c(
			Worker__c = worker.ID, 
			Login__c = login,
			Password__c = password
		);

		return Page.loginPage;
	}
}