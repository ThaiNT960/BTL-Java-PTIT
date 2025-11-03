package com.ptit.shop.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.SerializedName;
import com.ptit.shop.dao.OrderDAO;
import com.ptit.shop.model.Order;
import com.ptit.shop.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

// Tạo đơn hàng phía client: /orders
@WebServlet(name = "OrderServlet", urlPatterns = {"/orders"})
public class OrderServlet extends HttpServlet {

    private final Gson gson = new GsonBuilder().disableHtmlEscaping().create();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        addCors(resp);
        resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }

    // POST: tạo đơn mới từ payload client
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        addCors(response);

        // Đọc body JSON
        String body = readBody(request);
        if (body == null || body.isBlank()) {
            writeError(response, HttpServletResponse.SC_BAD_REQUEST, "Empty body");
            return;
        }

        // Parse JSON -> DTO
        CreateOrderRequest reqDto;
        try {
            reqDto = gson.fromJson(body, CreateOrderRequest.class);
        } catch (Exception ex) {
            writeError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid JSON: " + ex.getMessage());
            return;
        }

        // Validate cơ bản
        if (reqDto == null || reqDto.customer == null || reqDto.items == null || reqDto.items.isEmpty()) {
            writeError(response, HttpServletResponse.SC_BAD_REQUEST, "Missing customer or items");
            return;
        }
        String fullname = safe(reqDto.customer.fullname);
        String phone = onlyDigits(safe(reqDto.customer.phone));
        if (fullname.isBlank() || phone.isBlank()) {
            writeError(response, HttpServletResponse.SC_BAD_REQUEST, "fullname/phone is required");
            return;
        }

        // Map DTO -> Model Order + Items
        double subtotal = reqDto.summary != null ? reqDto.summary.subtotal : 0d;
        double discount = reqDto.summary != null ? reqDto.summary.discount : 0d;
        double shipping = reqDto.summary != null ? reqDto.summary.shipping : 0d;
        double total    = reqDto.summary != null ? reqDto.summary.total    : (subtotal - discount + shipping);

        String orderCode = generateOrderCode(); // ví dụ: ORD1699999999999-abc12
        String createdAtIso = OffsetDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

        Order order = new Order(
                orderCode,
                fullname,
                phone,
                safe(reqDto.customer.email),
                safe(reqDto.customer.address),
                safe(reqDto.customer.note),
                subtotal,
                discount,
                shipping,
                total,
                "PENDING"
        );
        order.setCreatedAt(createdAtIso);

        List<OrderItem> items = new ArrayList<>();
        for (CreateOrderItem dto : reqDto.items) {
            int productId = dto.productId;
            String name   = safe(dto.name);
            String size   = safe(dto.size);
            double price  = Math.max(0, dto.price);
            int qty       = Math.max(1, dto.quantity);
            double line   = price * qty;

            OrderItem it = new OrderItem(productId, name, size, price, qty);
            it.setLineTotal(line);
            items.add(it);
        }
        order.setItems(items);

        // Tạo đơn trong DB (transaction ở DAO)
        String createdCode = orderDAO.create(order, items);
        if (createdCode == null) {
            writeError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Cannot create order");
            return;
        }

        // Trả về JSON kết quả
        CreateOrderResponse resDto = new CreateOrderResponse();
        resDto.orderId   = createdCode;
        resDto.status    = order.getStatus();
        resDto.total     = order.getTotal();
        resDto.createdAt = createdAtIso;
        writeJson(response, resDto);
    }

    // -------- Helpers --------

    // Đọc toàn bộ body
    private static String readBody(HttpServletRequest request) throws IOException {
        StringBuilder sb = new StringBuilder(1024);
        try (BufferedReader br = request.getReader()) {
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
        }
        return sb.toString();
    }

    // Ghi JSON ra response
    private void writeJson(HttpServletResponse resp, Object obj) throws IOException {
        try (PrintWriter out = resp.getWriter()) {
            out.write(gson.toJson(obj));
        }
    }

    // Trả lỗi JSON
    private void writeError(HttpServletResponse resp, int status, String message) throws IOException {
        resp.setStatus(status);
        ErrorResponse er = new ErrorResponse();
        er.error = message;
        writeJson(resp, er);
    }

    // Tạo mã đơn đơn giản
    private static String generateOrderCode() {
        String ts = String.valueOf(System.currentTimeMillis());
        String suffix = Long.toString(Double.doubleToLongBits(Math.random()), 36).substring(0, 5);
        return "ORD" + ts + "-" + suffix;
    }

    // Chỉ giữ chữ số
    private static String onlyDigits(String s) {
        return s == null ? "" : s.replaceAll("\\D+", "");
    }

    // Trim an toàn
    private static String safe(String s) {
        return s == null ? "" : s.trim();
    }

    // CORS đơn giản (dev)
    private static void addCors(HttpServletResponse resp) {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
        resp.setHeader("Access-Control-Max-Age", "86400");
    }

    // -------- DTOs --------

    // Khớp payload client
    private static class CreateOrderRequest {
        Customer customer;
        List<CreateOrderItem> items;
        Summary summary;
        String idempotencyKey; // optional
    }

    private static class Customer {
        String fullname;
        String phone;
        String zalo;
        String email;
        String address;
        String note;
    }

    private static class CreateOrderItem {
        int productId;
        String name;
        String size;
        double price;
        int quantity;
        double subtotal;
        String image;
    }

    private static class Summary {
        double subtotal;
        double discount;
        double shipping;
        double total;
    }

    private static class CreateOrderResponse {
        String orderId;
        String status;
        double total;
        String createdAt;
    }

    private static class ErrorResponse {
        String error;
    }
}
