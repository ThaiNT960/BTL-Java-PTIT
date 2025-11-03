package com.ptit.shop.servlet;

import com.ptit.shop.dao.ProductDAO;
import com.ptit.shop.model.Product;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {

    // DAO & JSON
    private ProductDAO productDAO;
    private final Gson gson = new GsonBuilder().disableHtmlEscaping().create();

    // Lấy/khởi tạo DAO từ ServletContext
    @Override
    public void init() {
        Object daoInCtx = getServletContext().getAttribute("productDAO");
        if (daoInCtx instanceof ProductDAO) {
            this.productDAO = (ProductDAO) daoInCtx;
        } else {
            this.productDAO = new ProductDAO();
            getServletContext().setAttribute("productDAO", this.productDAO);
        }
    }

    // GET: list/filter/paging + trả JSON hoặc forward JSP
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        req.setCharacterEncoding(StandardCharsets.UTF_8.name());
        resp.setCharacterEncoding(StandardCharsets.UTF_8.name());

        String category = trimOrNull(req.getParameter("category"));
        String keyword  = trimOrNull(req.getParameter("q"));
        boolean wantsJson = wantsJson(req);

        int page = parseIntOrDefault(req.getParameter("page"), 1);
        int size = parseIntOrDefault(req.getParameter("size"), 50);

        try {
            // Lấy dữ liệu theo filter
            List<Product> all;
            if (category != null) {
                all = productDAO.listByCategory(category);
            } else if (keyword != null) {
                all = productDAO.searchByName(keyword);
            } else {
                all = productDAO.listAll();
            }

            // Phân trang trên bộ nhớ
            int total = all.size();
            int from = Math.max(0, (page - 1) * size);
            int to   = Math.min(total, from + size);
            List<Product> data = (from < to) ? all.subList(from, to) : List.of();

            // Trả JSON
            if (wantsJson) {
                resp.setContentType("application/json; charset=UTF-8");
                var body = Map.of(
                        "data", data,
                        "paging", Map.of("page", page, "size", size, "total", total)
                );
                resp.getWriter().write(gson.toJson(body));
                return;
            }

            // Forward JSP
            req.setAttribute("products", data);
            req.setAttribute("total", total);
            req.setAttribute("page", page);
            req.setAttribute("size", size);
            req.getRequestDispatcher("/product.jsp").forward(req, resp);

        } catch (SQLException e) {
            if (wantsJson) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("application/json; charset=UTF-8");
                resp.getWriter().write(gson.toJson(Map.of(
                        "error", "DB_ERROR",
                        "message", e.getMessage()
                )));
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu");
            }
        }
    }

    // Helpers

    // Trim -> null nếu rỗng
    private static String trimOrNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    // Xác định client muốn JSON
    private static boolean wantsJson(HttpServletRequest req) {
        String accept = req.getHeader("Accept");
        boolean a = (accept != null && accept.contains("application/json"));
        boolean q = "json".equalsIgnoreCase(req.getParameter("format"));
        return a || q;
    }

    private static int parseIntOrDefault(String s, int d) {
        try { return Integer.parseInt(s); } catch (Exception ignore) { return d; }
    }
}
