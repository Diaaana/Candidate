public with sharing class LoginController {
	public String login { get; set; }
	public String password { get; set; }

	public LoginController() {
		this.login = '';
		this.password = '';
	}

	public PageReference goToRegistration() {
		return Page.RegistrationPage;
	}

	public PageReference login() {

		User__c user = [
			SELECT ID, Worker__r.RecordTypeId
			FROM User__c 
			WHERE Login__c = :login AND Password__c = :password
			LIMIT 1
		];

		RecordType role = [SELECT Name FROM RecordType WHERE ID = :user.Worker__r.RecordTypeId LIMIT 1];
		
		if (user == NULL) {
			//
		}

		if (role.Name == 'Manager') {
			PageReference page = new PageReference('/apex/mainPage?role=manager');
			page.setRedirect(true);
			return page;
		} else if (role.Name == 'HR') {
			PageReference page = new PageReference('/apex/mainPage?role=HR');
			page.setRedirect(true);
			return page;
		} else {
			PageReference page = new PageReference('/apex/mainPage?role=worker');
			page.setRedirect(true);
			return page;
		}
		
	}
}