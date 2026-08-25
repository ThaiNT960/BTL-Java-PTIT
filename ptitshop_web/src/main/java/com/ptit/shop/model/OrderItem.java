package com.ptit.shop.model;

// Model cho từng sản phẩm trong đơn hàng
public class OrderItem {

    private long id;
    private int productId;
    private String productName;
    private String size;
    private double price;
    private int quantity;
    private double lineTotal; // Tổng tiền của dòng này


    public OrderItem() {}


    public OrderItem(int productId, String productName, String size,
                     double price, int quantity) {
        this.productId = productId;
        this.productName = productName;
        this.size = size;
        this.price = price;
        this.quantity = quantity;
        this.lineTotal = price * quantity;
    }

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getLineTotal() { return lineTotal; }
    public void setLineTotal(double lineTotal) { this.lineTotal = lineTotal; }
}
