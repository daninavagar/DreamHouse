@isTest
public class AnimalLocatorMock implements HttpCalloutMock {
    
    public HttpResponse respond(HttpRequest request) {
        // Verificar que la URL es correcta
        System.assert(request.getEndpoint().contains('animals/'));
        System.assertEquals('GET', request.getMethod());
        
        // Crear respuesta HTTP mock
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        
        // Simular respuesta exitosa del API
        String jsonResponse = '{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}';
        
        response.setBody(jsonResponse);
        response.setStatusCode(200);
        
        return response;
    }
}