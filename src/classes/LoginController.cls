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

		Worker__c worker = [
			SELECT ID, Role__r.Name 
			FROM Worker__c 
			WHERE Login__c = :login AND Password__c = :password LIMIT 1
		];

		if (worker == NULL) {
			//
		}

		if (worker.Role__r.Name == 'Manager') {
			return Page.mainPage;
		} else if (worker.Role__r.Name == 'HR') {
			return Page.mainPage;
		} else {
			return Page.mainPage;
		}
		
	}
}