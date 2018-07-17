public class AddWorkerController {
	public String name { get; set; }
	public String surname { get; set; }
	public String middleName { get; set; }
	public String position { get; set; }

	public AddWorkerController() {
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

		return Page.mainPage;
	}
}