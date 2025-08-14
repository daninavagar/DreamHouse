public class ContactAndLeadSearch {

    public static List<List<sObject>> searchContactsAndLeads(String firstOrLastName) {
        List<List<sObject>> searchList = [FIND :firstOrLastName 
                                          IN ALL FIELDS RETURNING 
                                          Lead(FirstName, LastName), Contact(FirstName, LastName)];
        
        Lead[] searchLeads = (lead[])searchList[0];
        Contact[] searchContacts = (Contact[])searchList[1];
        
        System.debug('Found the following accounts.');
        for (Lead a : searchLeads) {
            System.debug('Lead: ' + a);
        }
        System.debug('Found the following contacts.');
        for (Contact c : searchContacts) {
            System.debug('Contact: ' + c);
        }
        
        return searchList;
        
        
    }
}