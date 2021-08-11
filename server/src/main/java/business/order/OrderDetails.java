package business.order;

import business.book.Book;
import business.customer.Customer;

import java.util.Collections;
import java.util.List;

public class OrderDetails {
    Order order;
    Customer customer;
    List<LineItem> lineItems;
    List<Book> books;


    public OrderDetails(
        Order order,
        Customer customer,
        List<LineItem> lineItems,
        List<Book> books) {
        this.order = order;
        this.customer = customer;
        this.lineItems = lineItems;
        this.books = books;
    }


    public Order getOrder() {
        return order;
    }


    public Customer getCustomer() {
        return customer;
    }


    public List<Book> getBooks() {
        return Collections.unmodifiableList(books);
    }


    public List<LineItem> getLineItems() {
        return Collections.unmodifiableList(lineItems);
    }

    // NOTE: THIS CLASS PROVIDED NEXT PROJECT
}
