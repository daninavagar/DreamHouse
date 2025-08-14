/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountProcessorTest {
  @isTest
  static void countContactTest() {
    // Crear cuentas de prueba
    Account a1 = new Account(Name = 'Cuenta Uno');
    Account a2 = new Account(Name = 'Cuenta Dos');
    insert new List<Account>{ a1, a2 };

    // Crear contactos: 3 para a1, ninguno para a2
    List<Contact> contacts = new List<Contact>();
    for (Integer i = 0; i < 3; i++) {
      contacts.add(new Contact(LastName = 'Test' + i, AccountId = a1.Id));
    }
    insert contacts;
    List<Id> accountsIds = new List<Id>{ a1.Id, a2.Id };
    Test.startTest();
    AccountProcessor.countContacts(accountsIds);
    Test.stopTest();

    Account a1After = [
      SELECT Number_Of_Contacts__c
      FROM Account
      WHERE Id = :a1.Id
    ];
    Account a2After = [
      SELECT Number_Of_Contacts__c
      FROM Account
      WHERE Id = :a2.Id
    ];

    System.assertEquals(
      3,
      a1After.Number_Of_Contacts__c,
      'La cuenta A1 debe tener 3 contactos'
    );
    System.assertEquals(
      0,
      a2After.Number_Of_Contacts__c,
      'La cuenta A2 debe quedar en 0 contactos'
    );
  }
}
