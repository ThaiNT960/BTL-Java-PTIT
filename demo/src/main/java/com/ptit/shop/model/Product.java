package com.ptit.shop.model;

import java.util.List;

// Model đại diện cho 1 sản phẩm
public class Product {
    private int id;
    private String name;
    private String category;
    private int price;
    private String description;
    private List<String> sizes;
    private String image;
    private int stock;


    public Product() {}

    public Product(int id, String name, String category, int price,
                   String description, List<String> sizes, String image, int stock) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.description = description;
        this.sizes = sizes;
        this.image = image;
        this.stock = stock;
    }

    // Constructor rút gọn (không có stock)
    public Product(int id, String name, String category, int price,
                   String description, List<String> sizes, String image) {
        this(id, name, category, price, description, sizes, image, 0);
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public List<String> getSizes() { return sizes; }
    public void setSizes(List<String> sizes) { this.sizes = sizes; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
}
