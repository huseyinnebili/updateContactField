trigger updateContactField on Account(after update) {
  Map<Id, Account> mapAcc = new Map<Id, Account>();
  List<Contact> listContact = new List<Contact>();

  for (Account acc : Trigger.new) {
    if (acc.Phone != null && acc.Phone != Trigger.oldMap.get(acc.Id).Phone) {
      mapAcc.put(acc.id, acc);
    }
  }
  //Test done
  if (mapAcc.size() > 0) {
    for (Contact con : [
      SELECT Id, LastName, Phone, AccountId
      FROM Contact
      WHERE AccountId IN :mapAcc.keySet()
    ]) {
      if (mapAcc.containsKey(con.AccountId)) {
        con.Phone = mapAcc.get(con.AccountId).Phone;
        listContact.add(con);
      }
    }
  }

  if (!listContact.isEmpty()) {
    update listContact;
  }
  //All set
}
