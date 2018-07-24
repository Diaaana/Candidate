public with sharing class WorkerInteractionController {
	public String worker;
	public List<Interaction__c> interactions { get; set; }

	public WorkerInteractionController() {
		worker = ApexPages.currentPage().getParameters().get('worker');
		interactions = [
			SELECT Name, Interview__c, Task__c, DecisionPeriod__c, Decision__c, Amount__c
			FROM Interaction__c
			WHERE Name = :worker
		];
	}
}