public class ContactSearch {

    public static Contact[] searchForContacts(String lastNameParameter, String mailingPostalCodeParameter) {
        
        Contact[] listContact = [SELECT Id, Name FROM Contact
                 					WHERE LastName =: lastNameParameter 
                                 	AND MailingPostalCode =: mailingPostalCodeParameter];
        
        System.debug(listContact);
        return listContact;
    }
}