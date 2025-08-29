public with sharing class AnimalLocator {

  public static String getAnimalNameById(Integer Id) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('GET');
    request.setEndpoint(
      'https://th-apex-http-callout.herokuapp.com/animals/' + Id
    );
    HttpResponse response = http.send(request);
    if (response.getStatusCode() != 200) {
      return 'HttpRequest failed';
    }
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
      response.getBody()
    );
    Map<String,Object> animal = (Map<String,Object>) results.get('animal');
    String name = (String) animal.get('name');
    System.debug(name);
    return name;
  }
}