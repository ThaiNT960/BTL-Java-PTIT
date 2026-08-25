package com.ptit.shop.servlet;

import com.ptit.shop.dao.ProductDAO;
import com.ptit.shop.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Mặc định là list rỗng để tránh lỗi 500 nếu DB có vấn đề
        List<Product> newProducts = Collections.emptyList();
        List<Product> bestSellers = Collections.emptyList();

        try {
            List<Product> all = productDAO.listAll();
            if (all != null && !all.isEmpty()) {
                int newLimit = Math.min(4, all.size());
                newProducts = all.subList(0, newLimit);

                int bestStart = newLimit;
                int bestEnd = Math.min(bestStart + 8, all.size());

                bestSellers = all.subList(bestStart, bestEnd);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // chỉ log, KHÔNG ném ra ngoài để tránh lỗi trắng trang
        }

        req.setAttribute("newProducts", newProducts);
        req.setAttribute("bestSellers", bestSellers);

        req.getRequestDispatcher("/home.jsp").forward(req, resp);
    }
}
