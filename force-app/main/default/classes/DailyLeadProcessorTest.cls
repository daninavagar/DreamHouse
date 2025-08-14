@isTest
private class DailyLeadProcessorTest {
  @TestSetup
  static void makeData() {
    List<Lead> leadToInsert = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      Lead l = new Lead();
      l.FirstName = 'Test' + i;
      l.LastName = 'Lead ' + i;
      l.Company = 'Test Company ' + i;
      l.LeadSource  = null;
      leadToInsert.add(l);
    }

    insert leadToInsert;
  }
  @isTest
  static void myUnitTest() {
    // TO DO: implement unit test
    Test.startTest();
    String cronExp = '0 0 0 * * ?';
    System.schedule('DailyLead', cronExp, new DailyLeadProcessor());
    Test.stopTest();

    // Verificar que los 200 Leads quedaron actualizados a 'Dreamforce'
    Integer countDreamforce = [
      SELECT COUNT()
      FROM Lead
      WHERE LeadSource = 'Dreamforce'
    ];
    System.assertEquals(
      200,
      countDreamforce,
      'Deben haberse actualizado los 200 registros: todos a Dreamforce'
    );
  }
}
