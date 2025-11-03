package com.ptit.shop.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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
import java.util.*;

// Servlet quản trị đơn hàng: /admin/orders
@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends HttpServlet {

    private final Gson gson = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        addCors(resp);
        resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }

    // GET: chi tiết theo id/code hoặc danh sách (filter + paging)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        addCors(resp);

        final String idParam   = trimOrNull(req.getParameter("id"));
        final String codeParam = trimOrNull(req.getParameter("code"));

        // Chi tiết đơn
        if (idParam != null || codeParam != null) {
            Order order;
            if (idParam != null) {
                Long id = safeParseLong(idParam);
                if (id == null) {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    writeJson(resp, Map.of("error", "Tham số id không hợp lệ"));
                    return;
                }
                order = orderDAO.findById(id);
            } else {
                order = orderDAO.findByCode(codeParam);
            }

            if (order == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                writeJson(resp, Map.of("error", "Không tìm thấy đơn hàng"));
                return;
            }

            List<OrderItem> items = orderDAO.findItemsByOrderId(order.getId());
            Map<String, Object> result = new HashMap<>();
            result.put("order", order);
            result.put("items", items);
            writeJson(resp, result);
            return;
        }

        // Danh sách đơn (filter + paging)
        String status = trimOrNull(req.getParameter("status"));
        String phone  = trimOrNull(req.getParameter("phone"));
        String q      = trimOrNull(req.getParameter("q"));

        int page = clampInt(safeParseInt(req.getParameter("page"), 1), 1, Integer.MAX_VALUE);
        int size = clampInt(safeParseInt(req.getParameter("size"), 20), 1, 200);
        int offset = (page - 1) * size;

        List<Order> list = orderDAO.findAll(status, phone, q, offset, size);
        int total = orderDAO.count(status, phone, q);

        Map<String, Object> result = new HashMap<>();
        result.put("data", list);
        result.put("page", page);
        result.put("size", size);
        result.put("totalItems", total);
        result.put("totalPages", (int) Math.ceil((double) total / size));

        writeJson(resp, result);
    }

    // PUT: cập nhật trạng thái đơn theo id
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        addCors(resp);

        String idParam = trimOrNull(req.getParameter("id"));
        if (idParam == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, Map.of("error", "Thiếu id đơn hàng"));
            return;
        }

        Long id = safeParseLong(idParam);
        if (id == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, Map.of("error", "Tham số id không hợp lệ"));
            return;
        }

        String body = readBody(req);
        if (body == null || body.isBlank()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, Map.of("error", "Thiếu body JSON"));
            return;
        }

        Map<?, ?> data;
        try {
            data = gson.fromJson(body, Map.class);
        } catch (Exception ex) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, Map.of("error", "JSON không hợp lệ: " + ex.getMessage()));
            return;
        }

        String newStatus = null;
        if (data != null && data.get("status") != null) {
            newStatus = String.valueOf(data.get("status")).trim().toLowerCase();
        }
        if (newStatus == null || newStatus.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, Map.of("error", "Thiếu trạng thái mới"));
            return;
        }

        boolean ok = orderDAO.updateStatus(id, newStatus);
        if (!ok) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, Map.of("error", "Cập nhật trạng thái thất bại"));
            return;
        }

        writeJson(resp, Map.of("ok", true, "id", id, "status", newStatus, "message", "Đã cập nhật trạng thái đơn hàng"));
    }

    // DELETE: xoá đơn theo order_code
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        addCors(resp);

        String code = trimOrNull(req.getParameter("code"));
        if (code == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(resp, Map.of("error", "Thiếu tham số 'code' (order_code)"));
            return;
        }

        boolean ok = orderDAO.deleteByCode(code);
        if (!ok) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            writeJson(resp, Map.of("error", "Không tìm thấy hoặc xóa không thành công", "code", code));
            return;
        }

        writeJson(resp, Map.of("ok", true, "code", code, "message", "Đã xóa đơn hàng"));
    }

    //  Helpers

    private void writeJson(HttpServletResponse resp, Object obj) throws IOException {
        try (PrintWriter out = resp.getWriter()) {
            out.write(gson.toJson(obj));
        }
    }

    private String readBody(HttpServletRequest req) throws IOException {
        StringBuilder sb = new StringBuilder(1024);
        try (BufferedReader br = req.getReader()) {
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
        }
        return sb.toString();
    }

    private static String trimOrNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private static Integer safeParseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }

    private static Long safeParseLong(String s) {
        try { return Long.parseLong(s); } catch (Exception e) { return null; }
    }

    private static int clampInt(int v, int min, int max) {
        return Math.max(min, Math.min(max, v));
    }

    private static void addCors(HttpServletResponse resp) {
        resp.setHeader("Access-Control-Allow-Origin", "*"); // dev only
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, Authorization");
        resp.setHeader("Access-Control-Max-Age", "86400");
    }
}
