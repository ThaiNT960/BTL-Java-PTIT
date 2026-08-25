package com.ptit.shop.model;

import java.util.ArrayList;
import java.util.List;
// Model đại diện cho 1 đơn hàng
public class Order {

    private long id;
    private String orderCode;
    private String fullname;
    private String phone;
    private String email;
    private String address;
    private String note;
    private String status;      // Trạng thái đơn
    private double subtotal;    // Tạm tính
    private double discount;    // Giảm giá
    private double shippingFee; // Phí ship
    private double total;       // Tổng tiền
    private String createdAt;   // Ngày tạo

    private List<OrderItem> items = new ArrayList<>(); // Danh sách sản phẩm

    public Order() {}

    public Order(String orderCode, String fullname, String phone,
                 String email, String address, String note,
                 double subtotal, double discount, double shippingFee,
                 double total, String status) {
        this.orderCode = orderCode;
        this.fullname = fullname;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.note = note;
        this.subtotal = subtotal;
        this.discount = discount;
        this.shippingFee = shippingFee;
        this.total = total;
        this.status = status;
    }

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getOrderCode() { return orderCode; }
    public void setOrderCode(String orderCode) { this.orderCode = orderCode; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }

    public double getShippingFee() { return shippingFee; }
    public void setShippingFee(double shippingFee) { this.shippingFee = shippingFee; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }

    // Thêm sản phẩm vào danh sách
    public void addItem(OrderItem item) {
        if (this.items == null) this.items = new ArrayList<>();
        this.items.add(item);
    }
}
