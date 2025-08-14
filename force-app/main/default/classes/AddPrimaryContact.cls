public with sharing class AddPrimaryContact implements Queueable {
  Contact templateContact;
  String stateAbbreviation;
  public AddPrimaryContact(Contact contactToClone, String stateAbbreviation) {
    this.templateContact = contactToClone;
    this.stateAbbreviation = stateAbbreviation;
  }

  public void execute(QueueableContext context) {
    List<Account> cuentas = [
      SELECT Id
      FROM Account
      WHERE BillingState = :this.stateAbbreviation
      LIMIT 200
    ];
    List<Contact> nuevos = new List<Contact>();
    for (Account acct : cuentas) {
      // _clone(keepId, isDeepClone, preserveReadOnlyTimestamps, preserveAutonumber)
      Contact copia = (Contact) this.templateContact.clone(
        false,
        true,
        false,
        false
      );
      copia.AccountId = acct.Id;
      nuevos.add(copia);
    }
    insert nuevos;
  }
}
