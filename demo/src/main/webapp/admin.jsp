<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - PTIT SHOP Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<!-- Header -->
<nav class="bg-black text-white px-6 py-4 flex justify-between items-center">
    <div class="text-2xl font-bold">PTIT.STYLE - Admin</div>
    <div class="flex items-center gap-4">
        <span>Xin chào, Admin</span>
        <a href="products" class="bg-white text-black px-4 py-2 rounded hover:bg-gray-100">Quay lại cửa hàng</a>
    </div>
</nav>


<div class="max-w-7xl mx-auto px-6 py-12">
    <!--sản phẩm / đơn hàng / thống kê -->
    <div class="flex gap-4 mb-8 border-b border-gray-300">
        <button class="tab-btn active px-4 py-2 border-b-2 border-black font-semibold" data-tab="products">
            <i class="fas fa-box mr-2"></i>Quản lý sản phẩm
        </button>
        <button class="tab-btn px-4 py-2 border-b-2 border-transparent font-semibold hover:border-gray-300" data-tab="orders">
            <i class="fas fa-shopping-bag mr-2"></i>Quản lý đơn hàng
        </button>
        <button class="tab-btn px-4 py-2 border-b-2 border-transparent font-semibold hover:border-gray-300" data-tab="stats">
            <i class="fas fa-chart-bar mr-2"></i>Thống kê
        </button>
    </div>

    <!-- Tab: Quản lý sản phẩm (danh sách + nút thêm) -->
    <div id="products-tab" class="tab-content">
        <div class="flex justify-between items-center mb-8">
            <h2 class="text-3xl font-bold">Danh sách sản phẩm</h2>
            <button class="bg-black text-white px-6 py-2 rounded hover:bg-gray-800" onclick="openAddProductModal()">
                <i class="fas fa-plus mr-2"></i>Thêm sản phẩm
            </button>
        </div>

        <!-- Bảng sản phẩm-->
        <div class="bg-white rounded-lg shadow overflow-hidden">
            <table class="w-full">
                <thead class="bg-gray-50 border-b border-gray-200">
                <tr>
                    <th class="px-6 py-3 text-left text-sm font-semibold">ID</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Tên sản phẩm</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Danh mục</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Giá</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Mô tả</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Hành động</th>
                </tr>
                </thead>
                <tbody id="productTable">
                <!--  -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Tab: Quản lý đơn hàng (lọc trạng thái + xuất CSV + bảng đơn hàng) -->
    <div id="orders-tab" class="tab-content hidden">
        <div class="flex items-center justify-between mb-4">
            <h2 class="text-2xl font-bold">Danh sách đơn hàng</h2>
            <div class="flex gap-3">
                <select id="orderStatusFilter" class="border px-3 py-2 rounded">
                    <option value="">Tất cả trạng thái</option>
                    <option value="pending">Chờ xác nhận</option>
                    <option value="confirmed">Đã xác nhận</option>
                    <option value="packing">Đang đóng gói</option>
                    <option value="shipped">Đã giao hàng</option>
                    <option value="delivered">Đã nhận</option>
                    <option value="canceled">Đã hủy</option>
                </select>
                <button id="exportOrdersBtn" class="bg-black text-white px-4 py-2 rounded">Xuất CSV</button>
            </div>
        </div>

        <!-- Bảng đơn hàng -->
        <div class="bg-white rounded-lg shadow overflow-hidden">
            <table class="w-full">
                <thead class="bg-gray-50 border-b">
                <tr>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Mã đơn</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Khách hàng</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">SĐT</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Tổng tiền</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Ngày tạo</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Trạng thái</th>
                    <th class="px-6 py-3 text-left text-sm font-semibold">Hành động</th>
                </tr>
                </thead>
                <tbody id="ordersTable"></tbody>
            </table>
        </div>
    </div>

    <!-- Tab: Thống kê -->
    <div id="stats-tab" class="tab-content hidden">
        <h2 class="text-3xl font-bold mb-8">Thống kê</h2>
        <div class="grid grid-cols-4 gap-6">
            <div class="bg-white rounded-lg shadow p-6">
                <div class="text-gray-600 text-sm mb-2">Tổng sản phẩm</div>
                <div class="text-3xl font-bold" id="totalProducts">0</div>
            </div>
            <div class="bg-white rounded-lg shadow p-6">
                <div class="text-gray-600 text-sm mb-2">Tổng danh mục</div>
                <div class="text-3xl font-bold">4</div>
            </div>
            <div class="bg-white rounded-lg shadow p-6">
                <div class="text-gray-600 text-sm mb-2">Sản phẩm bán chạy</div>
                <div class="text-3xl font-bold">-</div>
            </div>
            <div class="bg-white rounded-lg shadow p-6">
                <div class="text-gray-600 text-sm mb-2">Doanh thu</div>
                <div class="text-3xl font-bold">-</div>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Thêm/Sửa sản phẩm  -->
<div id="productModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-lg p-8 w-full max-w-md">
        <h3 class="text-2xl font-bold mb-6">Thêm sản phẩm</h3>
        <form id="productForm" class="space-y-4">
            <div>
                <label class="block text-sm font-semibold mb-2">Tên sản phẩm</label>
                <input type="text" id="productName" class="w-full px-4 py-2 border border-gray-300 rounded" required>
            </div>
            <div>
                <label class="block text-sm font-semibold mb-2">Danh mục</label>
                <select id="productCategory" class="w-full px-4 py-2 border border-gray-300 rounded" required>
                    <option value="">Chọn danh mục</option>
                    <option value="tshirt">Áo thun</option>
                    <option value="hoodie">Hoodie</option>
                    <option value="jacket">Áo khoác</option>
                    <option value="accessories">Phụ kiện</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-semibold mb-2">Giá (VNĐ)</label>
                <input type="number" id="productPrice" class="w-full px-4 py-2 border border-gray-300 rounded" required>
            </div>
            <div>
                <label class="block text-sm font-semibold mb-2">Mô tả</label>
                <textarea id="productDescription" class="w-full px-4 py-2 border border-gray-300 rounded" rows="3" required></textarea>
            </div>
            <div>
                <label for="productSizes" class="block text-sm font-semibold mb-2">Size (CSV)</label>
                <input id="productSizes" type="text"
                       class="w-full px-4 py-2 border border-gray-300 rounded"
                       placeholder="Ví dụ: S,M,L,XL">
                <p class="text-xs text-gray-500 mt-1">Nhập nhiều size, cách nhau bằng dấu phẩy.</p>
            </div>
            <div>
                <label class="block text-sm font-semibold mb-2">Đường dẫn ảnh (URL / assets)</label>
                <input type="text" id="productImage"
                       placeholder="assets/img/ten-anh.jpg"
                       class="w-full px-4 py-2 border border-gray-300 rounded">
            </div>
            <div class="flex gap-4 pt-4">
                <button type="submit" class="flex-1 bg-black text-white py-2 rounded hover:bg-gray-800">Lưu</button>
                <button type="button" class="flex-1 bg-gray-300 text-black py-2 rounded hover:bg-gray-400" onclick="closeProductModal()">Hủy</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal: Chi tiết đơn hàng (hiển thị + đổi trạng thái) -->
<div id="orderDetailModal" class="fixed inset-0 bg-black/50 hidden z-50 items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-2xl">
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-xl font-bold">Chi tiết đơn hàng</h3>
            <button id="closeModalBtn" class="text-gray-500 hover:text-black"><i class="fa fa-times"></i></button>
        </div>
        <div id="orderDetailBody" class="space-y-4"></div>
        <div class="mt-6 flex gap-3">
            <select id="orderStatusSelect" class="border px-3 py-2 rounded">
                <option value="pending">Chờ xác nhận</option>
                <option value="confirmed">Đã xác nhận</option>
                <option value="packing">Đang đóng gói</option>
                <option value="shipped">Đã giao hàng</option>
                <option value="delivered">Đã nhận</option>
                <option value="canceled">Đã hủy</option>
            </select>
            <button id="saveOrderStatusBtn" class="bg-black text-white px-4 py-2 rounded">Lưu trạng thái</button>
        </div>
    </div>
</div>


<script src="assets/js/admin/util.js"></script>
<script src="assets/js/admin/admin-products.js"></script>
<script src="assets/js/admin/admin-orders.js"></script>
<script src="assets/js/admin/admin-stats.js"></script>

</body>
</html>
