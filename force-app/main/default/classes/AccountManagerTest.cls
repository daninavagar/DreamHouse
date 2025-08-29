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
private class AccountManagerTest {
    
    @isTest
    static void testGetAccount() {
        // Crear datos de prueba
        Account testAccount = new Account(
            Name = 'Test Account for REST API'
        );
        insert testAccount;
        
        // Crear múltiples Contacts para el Account
        List<Contact> testContacts = new List<Contact>{
            new Contact(
                FirstName = 'John',
                LastName = 'Doe',
                AccountId = testAccount.Id
            ),
            new Contact(
                FirstName = 'Jane',
                LastName = 'Smith',
                AccountId = testAccount.Id
            ),
            new Contact(
                FirstName = 'Bob',
                LastName = 'Johnson',
                AccountId = testAccount.Id
            )
        };
        insert testContacts;
        
        // Configurar el RestContext para simular la URL
        RestRequest request = new RestRequest();
        request.requestURI = 'https://wise-moose-4vil45-dev-ed.trailblaze.lightning.force.com/services/apexrest/Accounts/' + testAccount.Id + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Test.startTest();
        
        // Llamar al método REST
        Account result = AccountManager.getAccount();
        
        Test.stopTest();
        
        // Verificaciones del Account
        System.assertNotEquals(null, result, 'Account should not be null');
        System.assertEquals(testAccount.Id, result.Id, 'Account ID should match');
        System.assertEquals('Test Account for REST API', result.Name, 'Account Name should match');
        
        // Verificaciones de los Contacts
        System.assertNotEquals(null, result.Contacts, 'Contacts list should not be null');
        System.assertEquals(3, result.Contacts.size(), 'Should have 3 contacts');
        
        // Verificar que cada Contact tiene ID y Name
        for (Contact con : result.Contacts) {
            System.assertNotEquals(null, con.Id, 'Contact ID should not be null');
            System.assertNotEquals(null, con.Name, 'Contact Name should not be null');
        }
        
        // Verificar nombres específicos
        Set<String> contactNames = new Set<String>();
        for (Contact con : result.Contacts) {
            contactNames.add(con.Name);
        }
        System.assert(contactNames.contains('John Doe'), 'Should contain John Doe');
        System.assert(contactNames.contains('Jane Smith'), 'Should contain Jane Smith');
        System.assert(contactNames.contains('Bob Johnson'), 'Should contain Bob Johnson');
    }
    
    @isTest
    static void testGetAccountWithNoContacts() {
        // Crear Account sin Contacts
        Account testAccount = new Account(
            Name = 'Account Without Contacts'
        );
        insert testAccount;
        
        // Configurar RestContext
        RestRequest request = new RestRequest();
        request.requestURI = 'https://wise-moose-4vil45-dev-ed.trailblaze.lightning.force.com/services/apexrest/Accounts/' + testAccount.Id + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Test.startTest();
        
        Account result = AccountManager.getAccount();
        
        Test.stopTest();
        
        // Verificaciones
        System.assertNotEquals(null, result, 'Account should not be null');
        System.assertEquals(testAccount.Id, result.Id, 'Account ID should match');
        System.assertEquals('Account Without Contacts', result.Name, 'Account Name should match');
        
        // Verificar que la lista de Contacts existe pero está vacía
        System.assertNotEquals(null, result.Contacts, 'Contacts list should not be null');
        System.assertEquals(0, result.Contacts.size(), 'Should have 0 contacts');
    }
    
    @isTest
    static void testGetAccountSingleContact() {
        // Crear Account con un solo Contact
        Account testAccount = new Account(
            Name = 'Single Contact Account'
        );
        insert testAccount;
        
        Contact singleContact = new Contact(
            FirstName = 'Solo',
            LastName = 'Contact',
            AccountId = testAccount.Id
        );
        insert singleContact;
        
        // Configurar RestContext
        RestRequest request = new RestRequest();
        request.requestURI = 'https://wise-moose-4vil45-dev-ed.trailblaze.lightning.force.com/services/apexrest/Accounts/' + testAccount.Id + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Test.startTest();
        
        Account result = AccountManager.getAccount();
        
        Test.stopTest();
        
        // Verificaciones
        System.assertNotEquals(null, result, 'Account should not be null');
        System.assertEquals(1, result.Contacts.size(), 'Should have exactly 1 contact');
        System.assertEquals('Solo Contact', result.Contacts[0].Name, 'Contact name should match');
        System.assertNotEquals(null, result.Contacts[0].Id, 'Contact ID should not be null');
    }
    
    @isTest
    static void testGetAccountURIParsing() {
        // Test para verificar que la parsing de URI funciona correctamente
        Account testAccount = new Account(
            Name = 'URI Parsing Test'
        );
        insert testAccount;
        
        // Configurar RestContext con diferentes formatos de URI
        RestRequest request = new RestRequest();
        request.requestURI = 'https://test.salesforce.com/services/apexrest/Accounts/' + testAccount.Id + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Test.startTest();
        
        Account result = AccountManager.getAccount();
        
        Test.stopTest();
        
        // Verificar que encontró el Account correcto
        System.assertEquals(testAccount.Id, result.Id, 'Should parse Account ID correctly from URI');
        System.assertEquals('URI Parsing Test', result.Name, 'Account name should match');
    }
}
