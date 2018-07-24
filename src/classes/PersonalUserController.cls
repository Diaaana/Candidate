public class PersonalUserController {
	public ID userIDValue;
	public User__c user { get; set; }
	public String name { get; set; }
	public String surname { get; set; }
	public String middleName { get; set; }
	public String login { get; set; }
	public String password { get; set; }

	public PersonalUserController() {
		userIDValue = ID.valueOf(ApexPages.currentPage().getParameters().get('user'));
		user = [
			SELECT CreatedDate, Worker__r.Name, Worker__r.Surname__c, Worker__r.MiddleName__c, Name, Password__c
			FROM User__c
			WHERE ID = :userIDValue
			LIMIT 1
		];

		this.name = '';
		this.surname = '';
		this.middleName = '';
		this.login = '';
		this.password = '';
	}

	public PageReference editUser() {
		Worker__c worker = new Worker__c(
			Name = name, 
			Surname__c = surname, 
			MiddleName__c = middleName
		);

		User__c user = new User__c(
			ID = userIDValue,
			Worker__c = worker.ID,
			Name = login, 
			Password__c = password
		);

		update user;

		PageReference page = new PageReference('/apex/personalUserPage?user=' + userIDValue);
		page.setRedirect(true);
		return page;
	}

	public PageReference goToMainPage() {
		PageReference page = new PageReference('/apex/mainPage?role=worker');
		page.setRedirect(true);
		return page;
	}
}