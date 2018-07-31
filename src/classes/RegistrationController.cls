public class RegistrationController {
	public String surname { get; set; }
	public String name { get; set; }
	public String middleName { get; set; }
	public String login { get; set; }
	public String password { get; set; }
	public List<Worker__c> worker;

	public RegistrationController() {
		this.surname = '';
		this.name = '';
		this.middleName = '';
		this.login = '';
		this.password = '';
		this.worker = new List<Worker__c>();
	}

	public PageReference doRegistration() {
		ApexPages.getMessages().clear();

		List<User__c> users = [
			SELECT Name
			FROM User__c
			WHERE Name = :login
		];

		if (!users.isEmpty()) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'User with such login already exists!'));
			return null;

		} else {

			worker = [
				SELECT ID, Name 
				FROM Worker__c 
				WHERE Surname__c = :surname AND Name = :name AND MiddleName__c = :middleName 
			]; 

			if (worker.isEmpty()) {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Worker with such data does not exist!'));
				return null;

			} else {

				insert new User__c ( 
					Worker__c = worker[0].ID,
					Name = login,
					Password__c = password
				);
			}

			PageReference page = Page.loginPage;
			page.setRedirect(true);
			return page;
			
		}
	}
}