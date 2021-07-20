package business.order;

import api.ApiException;
import business.BookstoreDbException;
import business.JdbcUtils;
import business.book.Book;
import business.book.BookDao;
import business.cart.ShoppingCart;
import business.cart.ShoppingCartItem;
import business.customer.Customer;
import business.customer.CustomerDao;
import business.customer.CustomerForm;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.YearMonth;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

public class DefaultOrderService implements OrderService {

    private BookDao bookDao;
    private OrderDao orderDao;
    private LineItemDao lineItemDao;
    private CustomerDao customerDao;


    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }


    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }


    public void setLineItemDao(LineItemDao lineItemDao) {
        this.lineItemDao = lineItemDao;
    }


    public void setCustomerDao(CustomerDao customerDao) {
        this.customerDao = customerDao;
    }


    @Override public OrderDetails getOrderDetails(long orderId) {
        Order order = orderDao.findByOrderId(orderId);
        Customer customer = customerDao.findByCustomerId(order.getCustomerId());
        List<LineItem> lineItems = lineItemDao.findByOrderId(orderId);
        List<Book> books = lineItems.stream()
            .map(lineItem -> bookDao.findByBookId(lineItem.getBookId()))
            .collect(Collectors.toList());
        return new OrderDetails(order, customer, lineItems, books);
    }


    @Override
    public long placeOrder(CustomerForm customerForm, ShoppingCart cart) {

        validateCustomer(customerForm);
        validateCart(cart);
        try (Connection connection = JdbcUtils.getConnection()) {
            Date date = getDate(customerForm.getCcExpiryMonth(),
                customerForm.getCcExpiryYear());
            return performPlaceOrderTransaction(customerForm.getName(),
                customerForm.getAddress(), customerForm.getPhone(),
                customerForm.getEmail(), customerForm.getCcNumber(), date, cart,
                connection);
        }
        catch (SQLException e) {
            throw new BookstoreDbException(
                "Error during close connection for customer order", e);
        }

    }


    private Date getDate(String monthString, String yearString) {
        Date ccExpDate =new Date();
        ccExpDate.setMonth((Integer.parseInt(monthString)));
        ccExpDate.setYear((Integer.parseInt(yearString)));
    return ccExpDate;
    }


    private long performPlaceOrderTransaction(
        String name,
        String address,
        String phone,
        String email,
        String ccNumber,
        Date date,
        ShoppingCart cart,
        Connection connection) {
        try {
            connection.setAutoCommit(false);
            long customerId = customerDao
                .create(connection, name, address, phone, email, ccNumber,
                    date);
            long customerOrderId = orderDao.create(connection,
                cart.getComputedSubtotal() + cart.getSurcharge(),
                generateConfirmationNumber(), customerId);
            for (ShoppingCartItem item : cart.getItems()) {
                lineItemDao
                    .create(connection, customerOrderId, item.getBookId(),
                        item.getQuantity());
            }
            connection.commit();
            return customerOrderId;
        }
        catch (Exception e) {
            try {
                connection.rollback();
            }
            catch (SQLException e1) {
                throw new BookstoreDbException(
                    "Failed to roll back transaction", e1);
            }
            return 0;
        }
    }


    private int generateConfirmationNumber() {
        Random random = new Random();
        return random.nextInt(999999999);
    }


    private void validateCustomer(CustomerForm customerForm) {

        String name = customerForm.getName();

        if (name == null || name.equals("") || name.length() > 45 || name
            .length() < 4) {
            throw new ApiException.InvalidParameter("Invalid name field");
        }

        String address = customerForm.getAddress();
        if (address == null || address.equals("") || address
            .length() > 45 || address.length() < 4) {
            throw new ApiException.InvalidParameter("Invalid address field");
        }

        String phone = customerForm.getPhone();
        if (phone == null || phone.equals("")) {
            throw new ApiException.InvalidParameter(
                "Missing phone information");
        }
        else {
            String digits = phone.replaceAll("\\D", "");
            if (digits.length() != 10) {
                throw new ApiException.InvalidParameter("Invalid phone field");
            }
        }

        String email = customerForm.getEmail();
        if (email == null || email.equals("")) {
            throw new ApiException.InvalidParameter(
                "Missing email information");
        }
        if (email.contains(" ") || email.endsWith(".") || !email
            .contains("@")) {
            throw new ApiException.InvalidParameter(
                "Invalid email address field");
        }

        String ccNumber = customerForm.getCcNumber();
        if (ccNumber == null || ccNumber.equals("")) {
            throw new ApiException.InvalidParameter(
                "Missing credit card number information");
        }
        else {
            String digits = ccNumber.replaceAll("\\D", "");
            if (digits.length() > 16 || digits.length() < 14) {
                throw new ApiException.InvalidParameter(
                    "Invalid credit card field");
            }
        }

        if (expiryDateIsInvalid(customerForm.getCcExpiryMonth(),
            customerForm.getCcExpiryYear())) {
            throw new ApiException.InvalidParameter("Invalid expiry date");

        }
    }


    private boolean expiryDateIsInvalid(
        String ccExpiryMonth, String ccExpiryYear) {
        int month = Integer.parseInt(ccExpiryMonth);
        int year = Integer.parseInt(ccExpiryYear);
        YearMonth input = YearMonth.of(year, month);
        return input.isBefore(YearMonth.now());

    }


    private void validateCart(ShoppingCart cart) {
        if (cart.getItems().size() <= 0) {
            throw new ApiException.InvalidParameter("Cart is empty.");
        }

        cart.getItems().forEach(item -> {
            if (item.getQuantity() <=0 || item.getQuantity() > 99) {
                throw new ApiException.InvalidParameter("Invalid quantity");
            }
            Book databaseBook = bookDao.findByBookId(item.getBookId());
            if (databaseBook.getCategoryId() != item.getBookForm()
                .getCategoryId()) {
                throw new ApiException.InvalidParameter("Invalid category ID");
            }
            if (databaseBook.getPrice() != item.getBookForm().getPrice()) {
                throw new ApiException.InvalidParameter(
                    "Invalid book unit price");
            }

        });
    }

}
