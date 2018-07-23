public class LoginController {
	public String login { get; set; }
	public String password { get; set; }

	public LoginController() {
		this.login = '';
		this.password = '';
	}

	public PageReference goToRegistrationPage() {
		PageReference page = new PageReference('/apex/RegistrationPage');
		page.setRedirect(true);
		return page;
	}

	public PageReference doLogin() {

		List<User__c> user = [
			SELECT Worker__r.Position__c
			FROM User__c 
			WHERE Name = :login AND Password__c = :password
		];

		if (user.isEmpty()) {
			ApexPages.addMessage(
				new ApexPages.Message(
					ApexPages.Severity.ERROR, 
					'Incorrect login or password!'
				)
			);
			PageReference page = new PageReference('/apex/loginPage');
			page.setRedirect(true);
			return page;
		}

		if (user[0].Worker__r.Position__c == 'Manager') {
			PageReference page = new PageReference('/apex/mainPage?role=manager');
			page.setRedirect(true);
			return page;
		} else if (user[0].Worker__r.Position__c == 'HR') {
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