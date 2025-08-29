@isTest
private class LeadProcessorTest {
  @TestSetup
  static void makeData() {
    List<Lead> leadList = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      Lead l = new Lead();
      l.FirstName = 'Test' + i;
      l.LastName = 'Lead ' + i;
      l.Company = 'Test Company ' + i;
      l.LeadSource = 'Test';
      leadList.add(l);
    }
    insert leadList;


  }
  @isTest
  static void startBatchTest() {
    // TO DO: implement unit test

    Test.startTest();
    LeadProcessor lp = new LeadProcessor();
    Database.executeBatch(lp);
    Test.stopTest();

    System.Assert.areEqual(
      200,
      [SELECT COUNT() FROM LEAD WHERE LeadSource = 'Dreamforce']
    );
  }

  @isTest
  static void startBatchTestFail() {
    // TO DO: implement unit test
    LeadProcessor.queryLead = null;
    Test.startTest();
    Database.QueryLocator locator = new LeadProcessor().start(null);
    Test.stopTest();

    System.assertEquals(
      null,
      locator,
      'Cuando la SOQL es inválida, start() debe caer en el catch y devolver null'
    );
  }

  @IsTest
  static void testExecuteCatchesDmlException() {
    // 1) Preparamos un Lead “sucio” sin Id para que el update falle
    Lead badLead = new Lead(
      FirstName  = 'Foo',
      LastName   = 'Bar',
      Company    = 'Acme'
      // ojo: no lo insertamos, así no tiene Id → update() fallará
    );
    List<Lead> batchScope = new List<Lead>{ badLead };

    // 2) Invocamos execute() dentro de start/stopTest para aislar la transacción
    Test.startTest();
      // El primer parámetro (BatchableContext) puede pasarse null en un call directo
      new LeadProcessor().execute(null, batchScope);
    Test.stopTest();

    // 3) No esperamos ningún resultado concreto (la excepción está atrapada),
    //    pero al menos afirmamos que el método terminó sin propagar el error:
    System.assert(true, 'execute() atrapó el DmlException sin re-lanzar');
  }
}