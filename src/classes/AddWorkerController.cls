public class AddWorkerController {
	public PageReference page;
	public String roleValue;
	public String tabValue;
	public String name { get; set; }
	public String surname { get; set; }
	public String middleName { get; set; }
	public String position { get; set; }

	public AddWorkerController() {
		this.page = new PageReference('/apex/mainPage');
		this.roleValue = ApexPages.currentPage().getParameters().get('role');
		this.tabValue = ApexPages.currentPage().getParameters().get('tab');
		this.page.getParameters().put('role', roleValue);
		this.page.getParameters().put('tab', tabValue);
		this.surname = '';
		this.name = '';
		this.middleName = '';
		this.position = '';
	}

	public PageReference createWorker() {
		insert new Worker__c(
			Name = name, 
			Surname__c = surname,
			MiddleName__c = middleName,
			Position__c = position
		);

		page.setRedirect(true);
		return page;
	}

	public PageReference goToMainPage() {
		page.setRedirect(true);
		return page;
	}
}