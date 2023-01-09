@isTest
public class updateContactFieldTest {
  @isTest
  public static void test() {
    Account acc = new Account();
    acc.Name = 'Test';
    acc.Phone = '1232123243';

    Account acc1 = new Account();
    acc1.Name = 'Test-2';
    acc1.Phone = '1232123244';

    List<Account> listAcc = new List<Account>{ acc, acc1 };

    insert listAcc;

    List<Contact> listCont = new List<Contact>();

    for (Account account : listAcc) {
      Contact conn = new Contact();

      conn.LastName = 'Rodriguez';
      conn.AccountId = account.id;

      listCont.add(conn);
    }

    insert listCont;

    for (Account ac : listAcc) {
      ac.Phone = '1232123432';
    }

    update listAcc;

    List<Contact> returnedContact = [
      SELECT id, LastName, Phone
      FROM Contact
      WHERE id = :listCont[0].id
    ];

    System.assertEquals('1232123432', returnedContact[0].Phone);
  }
}
