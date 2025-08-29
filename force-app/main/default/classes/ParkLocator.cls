public with sharing class ParkLocator {
  public static String[] country(String country) {
    ParkService.ParksImplPort packService = new ParkService.ParksImplPort();

    String[] parks = packService.byCountry(country);

    return parks;
  }
}
