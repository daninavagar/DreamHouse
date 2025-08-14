public with sharing class TemperatureConverter {
  public static Decimal FahrenheitToCelsius(Decimal fh) {
    decimal cs = (fh - 32) * 5 / 9;
    return cs.setScale(2);
  }
}