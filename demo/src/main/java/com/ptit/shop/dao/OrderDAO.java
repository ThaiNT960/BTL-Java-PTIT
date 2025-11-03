package com.ptit.shop.dao;

import com.ptit.shop.model.Order;
import com.ptit.shop.model.OrderItem;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private static final String URL  =
            "jdbc:mysql://localhost:3306/ptitshop?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "123456";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL driver da load thanh cong");
        } catch (ClassNotFoundException e) {
            System.err.println("Khong the load MySQL driver");
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // tạo đơn hàng
    public String create(Order order, List<OrderItem> items) {
        String insertOrderSql = """
            INSERT INTO orders
            (order_code, fullname, phone, email, address, note,
             subtotal, discount, shipping_fee, total, status, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        String insertItemSql = """
            INSERT INTO order_items
            (order_id, product_id, product_name_snapshot, size, price, quantity, line_total)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = getConnection();
             PreparedStatement psOrder = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
             PreparedStatement psItem  = conn.prepareStatement(insertItemSql)) {

            conn.setAutoCommit(false);

            // Chèn orders
            psOrder.setString(1,  order.getOrderCode());
            psOrder.setString(2,  order.getFullname());
            psOrder.setString(3,  order.getPhone());
            psOrder.setString(4,  order.getEmail());
            psOrder.setString(5,  order.getAddress());
            psOrder.setString(6,  order.getNote());
            psOrder.setDouble(7,  order.getSubtotal());
            psOrder.setDouble(8,  order.getDiscount());
            psOrder.setDouble(9,  order.getShippingFee());
            psOrder.setDouble(10, order.getTotal());
            psOrder.setString(11, order.getStatus());
            psOrder.setTimestamp(12, Timestamp.valueOf(LocalDateTime.now()));
            psOrder.executeUpdate();

            // Lấy id đơn vừa tạo
            long orderId;
            try (ResultSet rs = psOrder.getGeneratedKeys()) {
                if (rs.next()) orderId = rs.getLong(1);
                else throw new SQLException("Không lấy được ID đơn hàng vừa chèn!");
            }

            // Chèn order_items
            for (OrderItem it : items) {
                psItem.setLong(1, orderId);
                psItem.setInt(2, it.getProductId());
                psItem.setString(3, it.getProductName());
                psItem.setString(4, it.getSize());
                psItem.setDouble(5, it.getPrice());
                psItem.setInt(6, it.getQuantity());
                psItem.setDouble(7, it.getLineTotal());
                psItem.addBatch();
            }
            psItem.executeBatch();

            conn.commit();
            System.out.println("Đã tạo đơn hàng: " + order.getOrderCode());
            return order.getOrderCode();

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi tạo đơn hàng: " + e.getMessage());
            return null;
        }
    }

    //   LIST + COUNT

//     Danh sách đơn theo filter (status/phone/q) + paging; mặc định sort created_at DESC
    public List<Order> findAll(String status, String phone, String q, int offset, int limit) {
        StringBuilder sql = new StringBuilder("""
            SELECT id, order_code, fullname, phone, email, address, note,
                   subtotal, discount, shipping_fee, total, status, created_at
            FROM orders
            WHERE 1=1
        """);
        List<Object> params = new ArrayList<>();

        if (notBlank(status)) {
            sql.append(" AND status = ? ");
            params.add(status.toLowerCase());
        }
        if (notBlank(phone)) {
            sql.append(" AND phone LIKE ? ");
            params.add("%" + phone.trim() + "%");
        }
        if (notBlank(q)) {
            sql.append(" AND (order_code LIKE ? OR fullname LIKE ? OR phone LIKE ?) ");
            String kw = "%" + q.trim() + "%";
            params.add(kw); params.add(kw); params.add(kw);
        }

        sql.append(" ORDER BY created_at DESC ");
        sql.append(" LIMIT ? OFFSET ? ");
        params.add(limit <= 0 ? 20 : limit);
        params.add(Math.max(0, offset));

        List<Order> result = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = prepare(conn, sql.toString(), params);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) result.add(mapOrder(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    //    Đếm tổng số đơn theo filter (phục vụ phân trang)
    public int count(String status, String phone, String q) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM orders WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (notBlank(status)) {
            sql.append(" AND status = ? ");
            params.add(status.toLowerCase());
        }
        if (notBlank(phone)) {
            sql.append(" AND phone LIKE ? ");
            params.add("%" + phone.trim() + "%");
        }
        if (notBlank(q)) {
            sql.append(" AND (order_code LIKE ? OR fullname LIKE ? OR phone LIKE ?) ");
            String kw = "%" + q.trim() + "%";
            params.add(kw); params.add(kw); params.add(kw);
        }

        try (Connection conn = getConnection();
             PreparedStatement ps = prepare(conn, sql.toString(), params);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    //Chi tiết đơn+items
    // Tìm đơn theo id
    public Order findById(long id) {
        String sql = """
            SELECT id, order_code, fullname, phone, email, address, note,
                   subtotal, discount, shipping_fee, total, status, created_at
            FROM orders
            WHERE id = ?
        """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tìm đơn theo mã (order_code)
    public Order findByCode(String code) {
        String sql = """
            SELECT id, order_code, fullname, phone, email, address, note,
                   subtotal, discount, shipping_fee, total, status, created_at
            FROM orders
            WHERE order_code = ?
        """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy danh sách items theo order_id
    public List<OrderItem> findItemsByOrderId(long orderId) {
        String sql = """
            SELECT id, product_id, product_name_snapshot, size, price, quantity, line_total
            FROM order_items
            WHERE order_id = ?
            ORDER BY id ASC
        """;
        List<OrderItem> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapOrderItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //Cập nhật trạng thái

    // Update status theo id
    public boolean updateStatus(long id, String newStatus) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus == null ? "" : newStatus.toLowerCase());
            ps.setLong(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helpers (mapping/builder)

    private static boolean notBlank(String s) {
        return s != null && !s.trim().isEmpty();
    }

    // Build PreparedStatement từ danh sách tham số
    private static PreparedStatement prepare(Connection conn, String sql, List<Object> params) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(sql);
        int idx = 1;
        for (Object p : params) {
            if (p instanceof Integer i) {
                ps.setInt(idx++, i);
            } else if (p instanceof Long l) {
                ps.setLong(idx++, l);
            } else if (p instanceof Double d) {
                ps.setDouble(idx++, d);
            } else {
                ps.setString(idx++, String.valueOf(p));
            }
        }
        return ps;
    }

    // Map ResultSet -> Order
    private static Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getLong("id"));
        o.setOrderCode(rs.getString("order_code"));
        o.setFullname(rs.getString("fullname"));
        o.setPhone(rs.getString("phone"));
        o.setEmail(rs.getString("email"));
        o.setAddress(rs.getString("address"));
        o.setNote(rs.getString("note"));
        o.setSubtotal(rs.getDouble("subtotal"));
        o.setDiscount(rs.getDouble("discount"));
        o.setShippingFee(rs.getDouble("shipping_fee"));
        o.setTotal(rs.getDouble("total"));
        o.setStatus(rs.getString("status"));
        Timestamp ts = rs.getTimestamp("created_at");
        o.setCreatedAt(ts != null ? ts.toString() : null);
        return o;
    }

    // Map ResultSet -> OrderItem
    private static OrderItem mapOrderItem(ResultSet rs) throws SQLException {
        OrderItem it = new OrderItem();
        it.setId(rs.getLong("id"));
        it.setProductId(rs.getInt("product_id"));
        it.setProductName(rs.getString("product_name_snapshot"));
        it.setSize(rs.getString("size"));
        it.setPrice(rs.getDouble("price"));
        it.setQuantity(rs.getInt("quantity"));
        it.setLineTotal(rs.getDouble("line_total"));
        return it;
    }

    //xóa đơn theo mã order_code
    public boolean deleteByCode(String code) {
        if (code == null || code.trim().isEmpty()) return false;

        final String sqlDelItems = "DELETE FROM order_items WHERE order_id = (SELECT id FROM orders WHERE order_code = ?)";
        final String sqlDelOrder = "DELETE FROM orders WHERE order_code = ?";

        try (Connection conn = getConnection();
             PreparedStatement psItems = conn.prepareStatement(sqlDelItems);
             PreparedStatement psOrder = conn.prepareStatement(sqlDelOrder)) {

            conn.setAutoCommit(false);

            // Xoá items trước
            psItems.setString(1, code.trim());
            psItems.executeUpdate();

            // Xoá đơn chính
            psOrder.setString(1, code.trim());
            int n = psOrder.executeUpdate();

            conn.commit();
            return n > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
