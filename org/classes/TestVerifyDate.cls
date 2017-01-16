@isTest
private class TestVerifyDate {
    @isTest 
    static void testDatesInOnlyMount() {
        Date date1 = Date.newInstance(2011, 10, 15);
        Date date2 = date1.addDays(3);
        Date pri = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, pri);
    }
    
    @isTest 
    static void testDateBefore() {
        Date date2 = Date.newInstance(2011, 10, 15);
        Date date1 = date2.addDays(3);
        Date pri = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(SetEndOfMonthDate(date1), pri);
    }
    
    @isTest
    static void testFailed() {
        Date date1 = Date.newInstance(2011, 10, 15);
        Date date2 = date1.addDays(33);
        Date pri = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(SetEndOfMonthDate(date1), pri);
    }
    private static Date SetEndOfMonthDate(Date date1) {
		Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
		return lastDay;
}
}