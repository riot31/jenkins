global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> teamList = [SELECT Id, LeadSource FROM Lead LIMIT 200];
        for(Integer i = 0 ; i < teamList.size(); i++) {
            teamList.get(i).LeadSource = 'DreamForce';
        }
        update teamList;
    }
}