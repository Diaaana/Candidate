public class AddWorkerController {
	public String name { get; set; }
	public String surname { get; set; }
	public String middleName { get; set; }
	public String position { get; set; }
	public String roleValue;

	public AddWorkerController() {
		this.surname = '';
		this.name = '';
		this.middleName = '';
		this.position = '';
		roleValue = ApexPages.currentPage().getParameters().get('role');
	}

	public PageReference createWorker() {
		insert new Worker__c(
			Name = name, 
			Surname__c = surname,
			MiddleName__c = middleName,
			Position__c = position
		);

		PageReference page = new PageReference('/apex/mainPage?role=' + roleValue);
		page.setRedirect(true);
		return page;
	}

	public PageReference goToMainPage() {
		PageReference page = new PageReference('/apex/mainPage?role=' + roleValue);
		page.setRedirect(true);
		return page;
	}
}