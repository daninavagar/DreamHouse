@isTest
private class AnimalLocatorTest {
  @isTest
  static void getAnimalNameByIdTest() {
    // Test para caso exitoso usando AnimalLocatorMock
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

    Test.startTest();
    String animalName = AnimalLocator.getAnimalNameById(1);
    Test.stopTest();

    // Verificaciones
    System.assertNotEquals(null, animalName, 'Animal name should not be null');
    System.assertNotEquals(
      'HttpRequest failed',
      animalName,
      'Should return valid animal name'
    );
    System.assertEquals(
      'chicken',
      animalName,
      'Should return chicken as animal name'
    );

    System.debug('Animal name returned: ' + animalName);
  }

  @isTest
  static void getAnimalNameByIdErrorTest() {
    // Test para caso de error usando mock personalizado
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

    Test.startTest();
    String result = AnimalLocator.getAnimalNameById(1);
    Test.stopTest();

    // Verificar que maneja el error correctamente
    System.assertEquals(
      'HttpRequest failed',
      result,
      'Should return error message for failed request'
    );

    System.debug('Error case result: ' + result);
  }
}