public class AccountHandler {

    public static Account insertNewAccount(String accName) {
        try {
            if (String.isEmpty(accName)) {
                System.Debug('accName is empty or null');
                return null;
            }
                
            Account acc = new Account(Name=accName);
            insert acc;
            
            Account accSaved = acc;
            System.Debug('accSaved: ID ' + accSaved.Id);
            System.Debug('accSaved: Name ' + accSaved.Name);
            
            return acc; 
        } catch (DmlException e) {
             System.debug('A DML exception has occurred: ' +
                e.getMessage());
            return null;
            
        }
    }
}