<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm - PTIT SHOP</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <%@ include file="/WEB-INF/jsp/partials/head.jspf" %>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .filter-section {
            border-right: 1px solid #e5e7eb;
        }

        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: var(--primary-color);
        }

        .product-price {
            font-size: 16px;
            color: #333;
            margin-bottom: 15px;
        }

        .product-description {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
            line-height: 1.4;
        }

        .size-selector {
            margin-bottom: 15px;
        }

        .size-selector label {
            font-size: 14px;
            margin-right: 10px;
        }

        .size-selector select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .quantity-selector {
            margin-bottom: 20px;
        }

        .quantity-selector label {
            font-size: 14px;
            margin-right: 10px;
        }

        .quantity-selector input {
            width: 60px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
            font-size: 14px;
        }

        .add-to-cart-btn {
            background: #ed1c24;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .add-to-cart-btn:hover {
            background: #c41e3a;
        }
    </style>
</head>

<body class="bg-white">
<%@ include file="/WEB-INF/jsp/partials/header.jspf" %>

<div class="px-6 py-4 border-b border-gray-200">
    <div class="max-w-7xl mx-auto">
        <a href="home.jsp" class="text-gray-600 hover:text-black">Trang chủ</a>
        <span class="text-gray-600"> &gt; </span>
        <span class="text-black font-semibold">Cửa hàng</span>
    </div>
</div>

<!-- Nội dung chính -->
<div class="max-w-7xl mx-auto px-6 py-8">
    <div class="flex gap-8">

        <!-- Cột bộ lọc -->
        <div class="w-64 filter-section pr-8">
            <h3 class="text-lg font-bold mb-6">Bộ lọc</h3>

            <!-- Giá -->
            <div class="mb-8">
                <div class="flex justify-between items-center mb-4">
                    <h4 class="font-semibold">Giá</h4>
                    <i class="fas fa-chevron-down text-gray-400"></i>
                </div>
                <div class="flex gap-4 items-center">
                    <input type="range" min="0" max="500000" class="flex-1">
                </div>
                <div class="flex gap-2 mt-2 text-sm text-gray-600">
                    <span>$50</span><span>-</span><span>$200</span>
                </div>
            </div>

            <!-- Màu sắc -->
            <div class="mb-8">
                <div class="flex justify-between items-center mb-4">
                    <h4 class="font-semibold">Màu sắc</h4>
                    <i class="fas fa-chevron-down text-gray-400"></i>
                </div>
                <div class="flex gap-3 flex-wrap">
                    <div
                            class="w-8 h-8 rounded-full bg-green-500 cursor-pointer border-2 hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-red-500 cursor-pointer border-2 hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-yellow-400 cursor-pointer border-2 hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-orange-500 cursor-pointer border-2 hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-cyan-400 cursor-pointer border-2 hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-blue-600 cursor-pointer border-2 hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-purple-600 cursor-pointer border-2 hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-pink-500 cursor-pointer border-2 hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-white border-2 border-gray-300 cursor-pointer hover:border-gray-400">
                    </div>
                    <div
                            class="w-8 h-8 rounded-full bg-black cursor-pointer border-2 hover:border-gray-400">
                    </div>
                </div>
            </div>

            <!-- Kích cỡ -->
            <div class="mb-8">
                <div class="flex justify-between items-center mb-4">
                    <h4 class="font-semibold">Kích cỡ</h4>
                    <i class="fas fa-chevron-down text-gray-400"></i>
                </div>
                <div class="grid grid-cols-2 gap-2">
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">XX-Nhỏ</button>
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">X-Nhỏ</button>
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">Nhỏ</button>
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">Trung
                        bình
                    </button>
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">Lớn</button>
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">X-Lớn</button>
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">XX-Lớn</button>
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">3X-Lớn</button>
                    <button
                            class="border border-gray-300 px-3 py-2 rounded text-sm hover:bg-gray-100">4X-Lớn</button>
                </div>
            </div>

            <!-- Phong cách -->
            <div class="mb-8">
                <div class="flex justify-between items-center mb-4">
                    <h4 class="font-semibold">Phong cách ăn mặc</h4>
                    <i class="fas fa-chevron-down text-gray-400"></i>
                </div>
                <ul class="space-y-2 text-gray-600">
                    <li><a href="#" class="hover:text-black">Casual</a></li>
                    <li><a href="#" class="hover:text-black">Formal</a></li>
                    <li><a href="#" class="hover:text-black">Party</a></li>
                    <li><a href="#" class="hover:text-black">Gym</a></li>
                </ul>
            </div>

            <!-- Nút áp dụng -->
            <button
                    class="w-full bg-black text-white py-3 rounded-full font-semibold hover:bg-gray-800">
                Áp dụng bộ lọc
            </button>
        </div>

        <!-- Danh sách sản phẩm -->
        <div class="flex-1">
            <div id="productGrid" class="grid grid-cols-3 gap-6 mb-8">
                <c:forEach var="p" items="${products}">
                    <div class="product-card">
                        <img src="${pageContext.request.contextPath}/${p.image}" alt="${p.name}"
                             class="product-image">
                        <div class="product-title">${p.name}</div>
                        <div class="product-price">
                            <fmt:formatNumber value="${p.price}" type="number"
                                              groupingUsed="true" /> VNĐ
                        </div>
                        <div class="product-description">${p.description}</div>

                        <c:if test="${not empty p.sizes}">
                            <div class="size-selector">
                                <label for="size-${p.id}">Size:</label>
                                <select id="size-${p.id}">
                                    <c:forEach var="s" items="${p.sizes}">
                                        <option value="${s}">${s}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:if>
                        <div class="quantity-selector">
                            <label for="qty-${p.id}">Số lượng:</label>
                            <input id="qty-${p.id}" type="number" min="1" max="10" value="1">
                        </div>
                        <button class="add-to-cart-btn" onclick="addToCart(${p.id})">Thêm vào
                            đơn</button>
                    </div>
                </c:forEach>
            </div>

            <!-- Phân trang -->
            <div class="flex justify-center items-center gap-4 mb-8">
                <button class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">←
                    Trước</button>
                <button class="px-4 py-2 bg-black text-white rounded">1</button>
                <button
                        class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">2</button>
                <button
                        class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">3</button>
                <span class="text-gray-600">...</span>
                <button
                        class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">8</button>
                <button
                        class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">9</button>
                <button
                        class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">10</button>
                <button class="px-4 py-2 border border-gray-300 rounded hover:bg-gray-100">Tiếp theo
                    →</button>
            </div>
        </div>
    </div>
</div>

<!-- Mini Cart -->
<div id="miniCart"
     class="fixed top-5 right-5 bg-white border border-gray-200 rounded-xl shadow-lg p-5 min-w-[300px] z-50 flex flex-col max-h-[80vh]">
    <div class="flex justify-between items-center mb-4">
        <div class="font-bold text-[16px] text-red-600">Đơn hàng tạm</div>
        <button id="closeMiniCart"
                class="text-gray-400 hover:text-black text-2xl leading-none">&times;</button>
    </div>
    <div id="cartItems" class="flex-1 overflow-y-auto divide-y divide-gray-200 pr-1">
        <p class="text-center text-gray-500 py-2">Chưa có sản phẩm nào</p>
    </div>
    <div id="cartTotal"
         class="hidden font-bold text-[16px] mt-4 pt-3 border-t border-[var(--primary-color)] text-gray-900">
        Tổng: <span id="totalAmount">0</span> VNĐ
    </div>
    <button id="checkoutBtn" onclick="goToOrder()"
            class="hidden w-full bg-red-600 hover:bg-red-700 text-white font-semibold py-3 rounded-lg mt-4 transition">
        Đặt hàng
    </button>
</div>


<section class="bg-black text-white py-16 px-6 rounded-2xl mx-6 mb-16">
    <div class="max-w-6xl mx-auto text-center">
        <h2 class="text-4xl font-bold mb-8">CẬP NHẬT THÔNG TIN VỀ<br>CÁC ƯU ĐÃI MỚI NHẤT CỦA CHÚNG
            TÔI</h2>
        <div class="flex gap-4 justify-center">
            <input type="email" placeholder="Nhập địa chỉ email của bạn"
                   class="px-6 py-3 rounded-full text-black w-80">
            <button
                    class="bg-white text-black px-8 py-3 rounded-full font-semibold hover:bg-gray-100">Đăng
                ký nhận bản
                tin
            </button>
        </div>
    </div>
</section>



<jsp:include page="/WEB-INF/jsp/partials/footer.jspf" />

<script src="assets/js/mini_cart.js"></script>
<script src="assets/js/app.js"></script>
<script src="assets/js/product.js"></script>


</body>

</html>