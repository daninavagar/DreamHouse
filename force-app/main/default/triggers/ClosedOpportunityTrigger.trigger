trigger ClosedOpportunityTrigger on Opportunity(after insert, after update) {
  List<Task> followUpTasks = new List<Task>();
  for (Opportunity opp : Trigger.new) {
    if (opp.StageName == 'Closed Won') {
      Task t = new Task(Subject = 'Follow Up Test Task', WhatId = opp.Id);
      followUpTasks.add(t);
    }
  }
  if (followUpTasks.size() > 0) {
    insert followUpTasks;
  }
}