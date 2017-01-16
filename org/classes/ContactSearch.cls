public class ContactSearch {
    public static List<Contact> searchForContacts(String lastname, String code) {
        List<Contact> result = new List<Contact>();        
        result = [SELECT Id, Name from Contact WHERE LastName = :lastname and MailingPostalCode = :code];
    	return result;
    }
}