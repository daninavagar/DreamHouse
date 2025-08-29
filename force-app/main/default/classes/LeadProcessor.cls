public with sharing class LeadProcessor implements Database.Batchable<SObject>, Database.StateFul {
  @TestVisible
  private static String queryLead = 'SELECT Id, Name, LeadSource FROM Lead';
  public Database.QueryLocator start(Database.BatchableContext bc) {
    Database.QueryLocator query = null;
    try {
      query = Database.getQueryLocator(queryLead);
      System.debug(query);
    } catch (Exception ex) {
      System.debug(ex.getMessage());
      return null;
    }

    return query;
  }

  public void execute(Database.BatchableContext bc, List<Lead> records) {
    List<Lead> leads = new List<Lead>();
    try {
      for (Lead lead : records) {
        lead.LeadSource = 'Dreamforce';
        leads.add(lead);
      }
      update leads;
    } catch (Exception ex) {
      System.debug(ex.getMessage());
    }
  }

  public void finish(Database.BatchableContext bc) {
    List<Lead> leads = [SELECT Id, FirstName, LeadSource FROM Lead];
    System.debug(leads);
  }
}