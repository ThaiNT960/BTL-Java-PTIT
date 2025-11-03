package com.ptit.shop.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ptit.shop.dao.ProductDAO;
import com.ptit.shop.model.Product;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

// Servlet quản trị sản phẩm: /admin/products
@WebServlet(name = "ProductAdminServlet", urlPatterns = {"/admin/products"})
public class AdminProductServlet extends HttpServlet {

    private final Gson gson = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
    private ProductDAO productDAO;

    @Override
    public void init() {
        this.productDAO = new ProductDAO();
    }

    // Header chung (JSON + CORS)
    private static void setCommonHeaders(HttpServletResponse resp) {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
    }

    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        setCommonHeaders(resp);
        resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }

    // GET: trả 1 sản phẩm (id) hoặc danh sách
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        setCommonHeaders(resp);
        try {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                Product p = productDAO.findById(id);
                writeJson(resp, Map.of("data", p));
                return;
            }
            List<Product> products = productDAO.listAll();
            writeJson(resp, Map.of("data", products));
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            writeJson(resp, Map.of("error", e.getMessage()));
        }
    }

    // POST: thêm sản phẩm
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        setCommonHeaders(resp);
        try {
            Product p = parseProductFromBody(req);
            int id = productDAO.insert(p);
            writeJson(resp, Map.of("ok", true, "id", id));
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            writeJson(resp, Map.of("error", e.getMessage()));
        }
    }

    // PUT: cập nhật sản phẩm theo id
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        setCommonHeaders(resp);
        try {
            String idParam = req.getParameter("id");
            if (idParam == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                writeJson(resp, Map.of("error", "Thiếu id sản phẩm"));
                return;
            }
            Product p = parseProductFromBody(req);
            p.setId(Integer.parseInt(idParam));
            boolean ok = productDAO.update(p);
            writeJson(resp, Map.of("ok", ok));
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            writeJson(resp, Map.of("error", e.getMessage()));
        }
    }

    // DELETE: xoá sản phẩm theo id
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        setCommonHeaders(resp);
        try {
            String idParam = req.getParameter("id");
            if (idParam == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                writeJson(resp, Map.of("error", "Thiếu id sản phẩm"));
                return;
            }
            int id = Integer.parseInt(idParam);
            boolean ok = productDAO.delete(id);
            writeJson(resp, Map.of("ok", ok));
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            writeJson(resp, Map.of("error", e.getMessage()));
        }
    }

    // ----- Helpers -----

    // Đọc JSON body -> Product
    private Product parseProductFromBody(HttpServletRequest req) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = req.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
        }
        Map<?, ?> map = gson.fromJson(sb.toString(), Map.class);

        Product p = new Product();
        p.setName(Objects.toString(map.get("name"), ""));
        p.setCategory(Objects.toString(map.get("category"), ""));
        Object priceObj = map.get("price");
        p.setPrice(priceObj instanceof Number ? ((Number) priceObj).intValue() : 0);
        p.setDescription(Objects.toString(map.get("description"), ""));
        p.setImage(Objects.toString(map.get("image"), ""));

        Object sizesObj = map.get("sizes");
        if (sizesObj instanceof String s && !s.isBlank()) {
            p.setSizes(Arrays.asList(s.split("\\s*,\\s*")));
        }

        Object stockObj = map.get("stock");
        p.setStock(stockObj instanceof Number ? ((Number) stockObj).intValue() : 0);
        return p;
    }

    // Ghi JSON ra response
    private void writeJson(HttpServletResponse resp, Object obj) throws IOException {
        try (PrintWriter out = resp.getWriter()) {
            out.write(gson.toJson(obj));
        }
    }
}
