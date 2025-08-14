public class RandomContactFactory {
  public static List<Contact> generateRandomContacts(
    Integer numberGenerated,
    string lastNameParameter
  ) {
    List<Contact> contactList = new List<Contact>();
    for (integer i = 0; i < numberGenerated; i++) {
      Contact c = new Contact(
        FirstName = 'Test' + i,
        LastName = lastNameParameter
      );
      contactList.add(c);
    }
    return contactList;
  }
}