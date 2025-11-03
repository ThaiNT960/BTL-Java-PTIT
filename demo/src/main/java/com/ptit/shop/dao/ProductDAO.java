package com.ptit.shop.dao;

import com.ptit.shop.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class ProductDAO {

    private static final String URL  =
            "jdbc:mysql://localhost:3306/ptitshop?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
    private static final String USER = "test";
    private static final String PASS = "124";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL driver da load thanh cong");
        } catch (ClassNotFoundException e) {
            System.err.println("Khong the load MySQL driver");
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // Helpers

    // CSV -> List<String> (sizes)
    private static List<String> parseSizesCsv(String csv) {
        if (csv == null || csv.isBlank()) return Collections.emptyList();
        return Arrays.asList(csv.split("\\s*,\\s*"));
    }

    // Map ResultSet -> Product
    private static Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setCategory(rs.getString("category"));
        p.setPrice(rs.getInt("price"));
        p.setDescription(rs.getString("description"));
        p.setSizes(parseSizesCsv(rs.getString("sizes")));
        p.setImage(rs.getString("image"));
        p.setStock(rs.getInt("stock"));
        return p;
    }

    // List<String> -> CSV (sizes)
    private static String joinSizesCsv(List<String> sizes) {
        if (sizes == null || sizes.isEmpty()) return null;
        return String.join(",", sizes);
    }

    // APIs chính

    // Lấy tất cả sản phẩm
    public List<Product> listAll() throws SQLException {
        String sql = """
            SELECT id, name, category, price, description, sizes, image, stock
            FROM products
            ORDER BY id DESC
        """;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            List<Product> out = new ArrayList<>();
            while (rs.next()) out.add(mapRow(rs));
            return out;
        }
    }

    //     Lọc theo category; null/blank => trả tất cả
    public List<Product> listByCategory(String category) throws SQLException {
        if (category == null || category.isBlank()) return listAll();

        String sql = """
            SELECT id, name, category, price, description, sizes, image, stock
            FROM products
            WHERE LOWER(category) = LOWER(?)
            ORDER BY id DESC
        """;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, category);
            try (ResultSet rs = ps.executeQuery()) {
                List<Product> out = new ArrayList<>();
                while (rs.next()) out.add(mapRow(rs));
                return out;
            }
        }
    }

    //    // Tìm theo tên/mô tả; null/blank => trả tất cả
    public List<Product> searchByName(String keyword) throws SQLException {
        if (keyword == null || keyword.isBlank()) return listAll();

        String like = "%" + keyword.toLowerCase() + "%";
        String sql = """
            SELECT id, name, category, price, description, sizes, image, stock
            FROM products
            WHERE LOWER(name) LIKE ? OR LOWER(description) LIKE ?
            ORDER BY id DESC
        """;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, like);
            ps.setString(2, like);
            try (ResultSet rs = ps.executeQuery()) {
                List<Product> out = new ArrayList<>();
                while (rs.next()) out.add(mapRow(rs));
                return out;
            }
        }
    }

    // Lấy 1 sản phẩm theo id
    public Product findById(int id) throws SQLException {
        String sql = """
            SELECT id, name, category, price, description, sizes, image, stock
            FROM products
            WHERE id = ?
        """;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    // CREATE
    public int insert(Product p) throws SQLException {
        String sql = "INSERT INTO products(name, category, price, description, sizes, image, stock) VALUES(?,?,?,?,?,?,?)";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getCategory());
            ps.setInt(3, p.getPrice());
            ps.setString(4, p.getDescription());
            ps.setString(5, joinSizesCsv(p.getSizes()));
            ps.setString(6, p.getImage());
            ps.setInt(7, p.getStock());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    // UPDATE
    public boolean update(Product p) throws SQLException {
        String sql = "UPDATE products SET name=?, category=?, price=?, description=?, sizes=?, image=?, stock=? WHERE id=?";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getCategory());
            ps.setInt(3, p.getPrice());
            ps.setString(4, p.getDescription());
            ps.setString(5, joinSizesCsv(p.getSizes()));
            ps.setString(6, p.getImage());
            ps.setInt(7, p.getStock());
            ps.setInt(8, p.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // DELETE
    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id=?";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
