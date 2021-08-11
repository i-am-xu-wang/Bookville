package business.customer;

import java.util.Calendar;

public class Customer {

    private long customerId;
    private String customerName;
    private String address;
    private String phone;
    private String email;
    private String ccNumber;
    private Calendar ccExpDate;
    private String lastFourCCNumber;


    public Customer(
        long customerId,
        String customerName,
        String address,
        String phone,
        String email,
        String ccNumber,
        Calendar ccExpDate) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.lastFourCCNumber = getLastFourCCNumber(ccNumber);
        this.ccNumber = lastFourCCNumber;
        this.ccExpDate = ccExpDate;

    }


    public long getCustomerId() {
        return customerId;
    }


    public String getCustomerName() {
        return customerName;
    }


    public String getAddress() {
        return address;
    }


    public String getPhone() {
        return phone;
    }


    public String getEmail() {
        return email;
    }


    public String getCcNumber() {
        return lastFourCCNumber;
    }


    public Calendar getCcExpDate() {
        return ccExpDate;
    }


    public String getLastFourCCNumber(String ccNumber) {
        char[] lastFour = new char[4];
        for (int i = ccNumber.length() - 4; i < ccNumber.length(); i++) {
            for (int j = 0; j < 4; j++) {
                lastFour[j] = ccNumber.charAt(i);
            }
        }
        return new String(lastFour);
    }


    @Override public String toString() {
        return "Customer{" + "customerId=" + customerId + ", customerName='" + customerName + '\'' + ", address='" + address + '\'' + ", phone='" + phone + '\'' + ", email='" + email + '\'' + ", ccNumber='" + ccNumber + '\'' + ", ccExpDate=" + ccExpDate + '}';
    }
}
