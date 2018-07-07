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
		Role__c workerRole = [SELECT ID, Name FROM Role__c WHERE Name = 'Worker'];
		
		Worker__c worker = new Worker__c(Surname__c = surname, Name = name, MiddleName__c = middleName, 
			Role__c = workerRole.ID, Login__c = login, Password__c = password);
		insert worker;

		insert new RoleWorkers__c(
			Name = 'Worker',
			Worker__c = worker.ID,
			Role__c = workerRole.ID
		);

		return Page.loginPage;
	}
}