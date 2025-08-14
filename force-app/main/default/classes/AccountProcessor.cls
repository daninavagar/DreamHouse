public class AccountProcessor {
  @future
  public static void countContacts(List<Id> accountIds) {
    AggregateResult[] grouped = [
      SELECT AccountId, COUNT(Id)
      FROM CONTACT
      WHERE AccountId IN :accountIds
      GROUP BY AccountId
    ];

    List<Account> toUpdate = new List<Account>();
    Map<Id, Integer> counts = new Map<Id, Integer>();
    for (AggregateResult ar : grouped) {
      counts.put((Id) ar.get('AccountId'), (Integer) ar.get('expr0'));
    }

    update toUpdate;

    for (Id accId : accountIds) {
      Integer num = counts.containsKey(accId) ? counts.get(accId) : 0;
      toUpdate.add(new Account(Id = accId, Number_Of_Contacts__c = num));
    }

    if (!toUpdate.isEmpty()) {
      update toUpdate;
    }
  }
}
