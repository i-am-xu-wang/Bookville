package business.customer;

import java.sql.Connection;
import java.util.Date;
import java.util.List;

public interface CustomerDao {

    long create(
        Connection connection,
        String customerName,
        String address,
        String phone,
        String email,
        String ccNumber,
        Date ccExpDate);

    List<Customer> findAll();

    Customer findByCustomerId(long customerId);

}
