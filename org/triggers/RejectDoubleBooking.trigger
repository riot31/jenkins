trigger RejectDoubleBooking on Session_Speaker__c (before insert, before update) {

    List<Id> speakerIds = new List<Id>();    
    Map<Id,DateTime> requested_bookings = new Map<Id,DateTime>();
    
    for(oez__Session_Speaker__c newItem : trigger.new) {
        requested_bookings.put(newItem.oez__Session__c,null); 
        speakerIds.add(newItem.oez__Speaker__c);
    }
    
    List<Session__c> related_sessions = [SELECT ID, oez__Session_Date__c from oez__Session__c WHERE ID IN :requested_bookings.keySet()];
    for(Session__c related_session : related_sessions) {
        requested_bookings.put(related_session.Id,related_session.Session_Date__c);
    }
    
    List<oez__Session_Speaker__c> related_speakers = [SELECT ID, oez__Speaker__c, oez__Session__c, Session__r.Session_Date__c from oez__Session_Speaker__c WHERE oez__Speaker__c IN :speakerIds];
    
    for(oez__Session_Speaker__c requested_session_speaker : trigger.new) {
        DateTime booking_time = requested_bookings.get(requested_session_speaker.oez__Session__c);
        for(oez__Session_Speaker__c related_speaker : related_speakers) {
            if(related_speaker.oez__Speaker__c == requested_session_speaker.oez__Speaker__c &&
               related_speaker.Session__r.Session_Date__c == booking_time) {
                   requested_session_speaker.addError('The speaker is already booked at that time');
               }
        }
    }
}