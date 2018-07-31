@isTest
private class RegistrationControllerTest {
	
	@isTest static void registrationWithSuchLogin() {
		
		Worker__c worker = new Worker__c(
			Name = 'Ivan',
			Surname__c = 'Ivanov',
			MiddleName__c = 'Ivanovich',
			Position__c = 'Java developer'
		);
		insert worker;

		User__c user = new User__c(
			Worker__c = worker.ID,
			Name = 'ivan',
			Password__c = 'ivan123'
		);
		insert user;

		Test.startTest();

		PageReference page = Page.RegistrationPage;
		page.getParameters().put('name', 'Ivan');
		page.getParameters().put('surname', 'Petrov');
		page.getParameters().put('middleName', 'Petrovich');
		page.getParameters().put('login', 'ivan');
		page.getParameters().put('password', 'ivan456');

		RegistrationController registrationController = new RegistrationController();
		registrationController.doRegistration();

		List<ApexPages.Message> messages = ApexPages.getMessages();
		for(ApexPages.Message msg : messages) {
			System.assertEquals('User with such login already exists!', msg.getSummary());
		}

		Test.stopTest();
	}
	
	@isTest static void registrationWithSuchData() {

		Test.startTest();

		PageReference page = Page.RegistrationPage;
		page.getParameters().put('name', 'Ivan');
		page.getParameters().put('surname', 'Petrov');
		page.getParameters().put('middleName', 'Petrovich');
		page.getParameters().put('login', 'ivan');
		page.getParameters().put('password', 'ivan456');

		RegistrationController registrationController = new RegistrationController();
		registrationController.doRegistration();

		List<ApexPages.Message> messages = ApexPages.getMessages();
		for(ApexPages.Message msg : messages) {
			System.assertEquals('Worker with such data does not exist!', msg.getSummary());
		}

		Test.stopTest();
	}
	
}