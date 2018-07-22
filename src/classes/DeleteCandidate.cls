public class DeleteCandidate {

	@InvocableMethod
	public static void deleteCandidate() {
		Candidate__c candidate = [
			SELECT ID
			FROM Candidate__c
			WHERE Status__c = 'Decision is made'
			LIMIT 1
		];
		delete candidate;
	}
}