@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    
    @HttpGet
    global static Account getAccount() {
        // Obtener el Account ID de la URL /Accounts/{id}/contacts
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        
        // Extraer Account ID de la URL pattern /Accounts/{id}/contacts
        String[] uriParts = requestURI.split('/');
        String accountId = '';
        
        for (Integer i = 0; i < uriParts.size(); i++) {
            if (uriParts[i] == 'Accounts' && i + 1 < uriParts.size()) {
                accountId = uriParts[i + 1];
                break;
            }
        }
        
        // Query para obtener Account con todos sus Contacts asociados
        Account result = [
            SELECT Id, Name, 
                   (SELECT Id, Name FROM Contacts)
            FROM Account 
            WHERE Id = :accountId
            LIMIT 1
        ];
        
        return result;
    }
}