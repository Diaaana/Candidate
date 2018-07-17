public class LoginController {
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
			SELECT Worker__r.Position__c
			FROM User__c 
			WHERE Name = :login AND Password__c = :password
			LIMIT 1
		];
		
		if (user == NULL) {
			//
		}

		if (user.Worker__r.Position__c == 'Manager') {
			PageReference page = new PageReference('/apex/mainPage?role=manager');
			page.setRedirect(true);
			return page;
		} else if (user.Worker__r.Position__c == 'HR') {
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