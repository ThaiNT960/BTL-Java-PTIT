<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <title>Lịch sử đặt hàng - PTIT SHOP</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <%@ include file="/WEB-INF/jsp/partials/head.jspf" %>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
            Oxygen, Ubuntu, Cantarell, sans-serif;
        }
    </style>
</head>

<body class="bg-white">

<%@ include file="/WEB-INF/jsp/partials/header.jspf" %>


<div class="px-6 py-4 border-b border-gray-200">
    <div class="max-w-7xl mx-auto">
        <a href="home.jsp" class="text-gray-600 hover:text-black">Trang chủ</a>
        <span class="text-gray-600"> > </span>
        <span class="text-black font-semibold">Lịch sử đặt hàng</span>
    </div>
</div>

<!-- Nội dung chính: danh sách đơn hàng -->
<main class="max-w-7xl mx-auto px-6 py-12">
    <h1 class="text-4xl font-bold mb-10">LỊCH SỬ ĐẶT HÀNG</h1>
    <div id="historyRoot">
        <div class="text-gray-600">Đang tải...</div>
    </div>
</main>


<section class="bg-black text-white py-16 px-6 rounded-2xl mx-6 my-16">
    <div class="max-w-6xl mx-auto text-center">
        <h2 class="text-4xl font-bold mb-8">
            CẬP NHẬT THÔNG TIN VỀ<br>
            CÁC ƯU ĐÃI MỚI NHẤT CỦA CHÚNG TÔI
        </h2>

        <div class="flex gap-4 justify-center">
            <input type="email" placeholder="Nhập địa chỉ email của bạn"
                   class="px-6 py-3 rounded-full text-black w-80">
            <button class="bg-white text-black px-8 py-3 rounded-full font-semibold hover:bg-gray-100">
                Đăng ký nhận bản tin
            </button>
        </div>
    </div>
</section>

<!-- modal xem chi tiết đơn hàng -->
<div id="orderDetailModal" class="fixed inset-0 bg-black/50 hidden z-50 items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-2xl">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-xl font-bold">Chi tiết đơn hàng</h3>
            <button id="closeModalBtn" class="text-gray-500 hover:text-black">
                <i class="fa fa-times"></i>
            </button>
        </div>
        <div id="orderDetailBody" class="space-y-4"></div>
    </div>
</div>


<jsp:include page="/WEB-INF/jsp/partials/footer.jspf" />
<script src="assets/js/order-history.js"></script>

</body>
</html>