// File: com/ptit/shop/servlet/AdminStatsServlet.java
package com.ptit.shop.servlet;

import com.google.gson.Gson;
import com.ptit.shop.dao.OrderDAO;
import com.ptit.shop.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

// Đăng ký Servlet với URL /admin/stats
@WebServlet(name = "AdminStatsServlet", urlPatterns = {"/admin/stats"})
public class AdminStatsServlet extends HttpServlet {

    private final Gson gson = new Gson();
    private ProductDAO productDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        this.productDAO = new ProductDAO();
        this.orderDAO = new OrderDAO();
    }

    // Header chung (JSON + CORS)
    private static void setCommonHeaders(HttpServletResponse resp) {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
    }

    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        setCommonHeaders(resp);
        resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }

    // GET: Trả về JSON chứa các số liệu thống kê
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        setCommonHeaders(resp);

        try {

            int totalProducts = productDAO.countTotal();
            int totalCategories = productDAO.countDistinctCategories();


            double totalRevenue = orderDAO.calculateTotalRevenue();
            Map<String, Object> bestSelling = orderDAO.findBestSellingProduct();

            if (bestSelling == null) {
                bestSelling = new HashMap<>();
                bestSelling.put("name", "-");
                bestSelling.put("count", 0);
            }


            Map<String, Object> stats = new HashMap<>();
            stats.put("totalProducts", totalProducts);
            stats.put("totalCategories", totalCategories);
            stats.put("totalRevenue", totalRevenue);
            stats.put("bestSellingProduct", bestSelling);


            writeJson(resp, stats);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, Object> errorMap = new HashMap<>();
            errorMap.put("error", e.getMessage());
            writeJson(resp, errorMap);
        }
    }

    // Ghi JSON ra response
    private void writeJson(HttpServletResponse resp, Object obj) throws IOException {
        try (PrintWriter out = resp.getWriter()) {
            out.write(gson.toJson(obj));
        }
    }
}