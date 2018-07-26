public class RegistrationController {
	public String surname { get; set; }
	public String name { get; set; }
	public String middleName { get; set; }
	public String login { get; set; }
	public String password { get; set; }
	public List<Worker__c> worker;

	public RegistrationController() {
		this.surname = '';
		this.name = '';
		this.middleName = '';
		this.login = '';
		this.password = '';
		this.worker = new List<Worker__c>();
	}

	public PageReference doRegistration() {
		ApexPages.getMessages().clear();

		worker = [
			SELECT ID, Name 
			FROM Worker__c 
			WHERE Surname__c = :surname AND Name = :name AND MiddleName__c = :middleName 
		]; 
		
		if (worker.isEmpty()) {
			ApexPages.addMessage(
				new ApexPages.Message(
					ApexPages.Severity.ERROR, 
					'Worker with such data does not exist!'
				)
			);
			return
			
		} else {
			insert new User__c ( 
				Worker__c = worker[0].ID,
				Name = login,
				Password__c = password
			);
			PageReference page = new PageReference('/apex/RegistrationPage');
		page.setRedirect(true);
		return page;
		}
		
		
	}
}