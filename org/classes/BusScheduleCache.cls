public without sharing class BusScheduleCache {
	private Cache.OrgPartition part;
    
    public BusScheduleCache() {
        part = Cache.Org.getPartition('local.BusSchedule');
    }
    
    public void putSchedule(String busLine, Time[] schedule) {
        part.put(busLine, schedule);
    }
    
    public Time[] getSchedule(String busLine) {
        return (Time[])part.get(busLine);
    }
}