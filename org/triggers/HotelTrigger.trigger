trigger HotelTrigger on oez__Hotel__c (before insert) {
	/*for(oez__Hotel__c o : (List<oez__Hotel__c>) Trigger.new) {
      if(o.oez__Location__Latitude__s == null) {
        o.oez__Location__Latitude__s.addError('Fill Location!');
      }
      if(o.oez__Location__Longitude__s == null) {
        o.oez__Location__Longitude__s.addError('Fill Location!');
      }
    }*/
}