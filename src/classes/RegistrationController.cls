public class RegistrationController {
	public String surname { get; set; }
	public String name { get; set; }
	public String middleName { get; set; }
	public String login { get; set; }
	public String password { get; set; }

	public RegistrationController() {
		this.surname = '';
		this.name = '';
		this.middleName = '';
		this.login = '';
		this.password = '';
	}

	public PageReference doRegistration() {
		List<Worker__c> worker = new List<Worker__c>();

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
			return Page.RegistrationPage;
			
		} else {
			insert new User__c ( 
				Worker__c = worker[0].ID,
				Name = login,
				Password__c = password
			);
		}
		return Page.loginPage;
	}
}