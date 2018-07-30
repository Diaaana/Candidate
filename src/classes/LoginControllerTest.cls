@isTest
private class LoginControllerTest {
	
	@isTest static void loginWithWrongData() {
		Test.startTest();

		PageReference page = Page.loginPage;
		page.getParameters().put('login', 'asdf');
		page.getParameters().put('password', '1236987');

		LoginController loginController = new LoginController();
		loginController.doLogin();

		List<ApexPages.Message> messages = ApexPages.getMessages();
		for(ApexPages.Message msg : messages) {
			System.assertEquals('Incorrect login or password!', msg.getSummary());
		}

		Test.stopTest();
	}
	
}