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
			PageReference page = new PageReference('/apex/mainPage?role=manager');
			page.setRedirect(true);
			return page;
		} else if (worker.Role__r.Name == 'HR') {
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