@isTest
private class ParkLocatorTest {
  @isTest
  static void countryTestGermany() {
    // Test para Alemania
    Test.setMock(WebServiceMock.class, new ParkServiceMock());

    Test.startTest();
    String[] parks = ParkLocator.country('Germany');
    Test.stopTest();

    System.assertNotEquals(null, parks, 'Parks array should not be null');
    System.assert(
      parks.size() > 0,
      'Should return at least one park for Germany'
    );
    System.assertNotEquals(
      'Error retrieving parks for Germany',
      parks[0],
      'Should not return error message'
    );

    System.debug('Germany parks: ' + parks);
  }

  @isTest
  static void countryTestIndia() {
    // Test para India
    Test.setMock(WebServiceMock.class, new ParkServiceMock());

    Test.startTest();
    String[] parks = ParkLocator.country('India');
    Test.stopTest();

    System.assertNotEquals(null, parks, 'Parks array should not be null');
    System.assert(
      parks.size() > 0,
      'Should return at least one park for India'
    );

    System.debug('India parks: ' + parks);
  }

  @isTest
  static void countryTestJapan() {
    // Test para Japón
    Test.setMock(WebServiceMock.class, new ParkServiceMock());

    Test.startTest();
    String[] parks = ParkLocator.country('Japan');
    Test.stopTest();

    System.assertNotEquals(null, parks, 'Parks array should not be null');
    System.assert(
      parks.size() > 0,
      'Should return at least one park for Japan'
    );

    System.debug('Japan parks: ' + parks);
  }

  @isTest
  static void countryTestUnitedStates() {
    // Test para Estados Unidos
    Test.setMock(WebServiceMock.class, new ParkServiceMock());

    Test.startTest();
    String[] parks = ParkLocator.country('United States');
    Test.stopTest();

    System.assertNotEquals(null, parks, 'Parks array should not be null');
    System.assert(
      parks.size() > 0,
      'Should return at least one park for United States'
    );

    System.debug('United States parks: ' + parks);
  }

}
