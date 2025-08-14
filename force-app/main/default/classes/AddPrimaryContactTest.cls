@isTest
private class AddPrimaryContactTest {
  @TestSetup
  static void makeData() {
    List<Account> accountsToInsertNY = new List<Account>();
    for (Integer i = 0; i < 50; i++) {
      Account a = new Account(Name = 'TestNY' + i, BillingState = 'NY');
      accountsToInsertNY.add(a);
    }
    List<Account> accountsToInsertCA = new List<Account>();
    for (Integer i = 0; i < 50; i++) {
      Account a = new Account(Name = 'TestCA' + i, BillingState = 'CA');
      accountsToInsertCA.add(a);
    }

    insert accountsToInsertNY;
    insert accountsToInsertCA;

    Contact plantilla = new Contact(
      FirstName = 'Primario',
      LastName = 'Test',
      Email = 'primario@example.com'
    );
    insert plantilla;
  }
  @isTest
  static void testAddsPrimaryContactsOnlyForCA() {
    Contact plantilla = [
      SELECT Id, Email
      FROM Contact
      WHERE Email = 'primario@example.com'
      LIMIT 1
    ];
    Test.startTest();
    Id jobId = System.enqueueJob(new AddPrimaryContact(plantilla, 'CA'));
    Test.stopTest();

    Integer countCA = [
      SELECT COUNT()
      FROM Contact
      WHERE Account.BillingState = 'CA' AND Email = 'primario@example.com'
    ];
    System.assertEquals(50, countCA, 'Debe crear 1 Contact por cada cuenta CA');

    Integer countNY = [
      SELECT COUNT()
      FROM Contact
      WHERE Account.BillingState = 'NY' AND Email = 'primario@example.com'
    ];
    System.assertEquals(0, countNY, 'No debe crear contactos para cuentas NY');
  }
}
