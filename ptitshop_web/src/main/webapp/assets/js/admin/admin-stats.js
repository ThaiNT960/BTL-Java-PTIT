// File: assets/js/admin/admin-stats.js
(function () {
    'use strict';

    // Thêm hàm helper này để định dạng tiền tệ
    function formatVND(n) {
        if (typeof n !== 'number') {
            n = 0;
        }
        return n.toLocaleString('vi-VN') + ' VNĐ';
    }

    // Hàm gọi API /admin/stats và cập nhật 4 ô
    async function loadStats() {
        try {
            // 1. Gọi API
            const response = await fetch('admin/stats');
            if (!response.ok) {
                throw new Error('Không thể tải dữ liệu thống kê');
            }
            const stats = await response.json();

            // 2. Cập nhật DOM
            document.getElementById('totalProducts').innerText = stats.totalProducts || 0;
            document.getElementById('totalCategories').innerText = stats.totalCategories || 0;
            document.getElementById('totalRevenue').innerText = formatVND(stats.totalRevenue);

            // 3. Xử lý sản phẩm bán chạy
            const bs = stats.bestSellingProduct;
            if (bs && bs.name !== '-') {
                document.getElementById('bestSelling').innerText = `${bs.name} (${bs.count} sp)`;
            } else {
                document.getElementById('bestSelling').innerText = '-';
            }

        } catch (err) {
            console.error('Lỗi tải thống kê:', err);
            document.getElementById('totalProducts').innerText = 'Lỗi';
            document.getElementById('totalCategories').innerText = 'Lỗi';
            document.getElementById('totalRevenue').innerText = 'Lỗi';
            document.getElementById('bestSelling').innerText = 'Lỗi';
        }
    }

    // Xử lý chuyển tab
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            const tabName = this.getAttribute('data-tab');
            document.querySelectorAll('.tab-content').forEach(tab => tab.classList.add('hidden'));
            document.querySelectorAll('.tab-btn').forEach(b => {
                b.classList.remove('border-black', 'active');
                b.classList.add('border-transparent');
            });

            const tabContent = document.getElementById(tabName + '-tab');
            if (tabContent) tabContent.classList.remove('hidden');

            this.classList.remove('border-transparent');
            this.classList.add('border-black', 'active');

            // QUAN TRỌNG: Gọi loadStats() khi click đúng tab 'stats'
            if (tabName === 'stats') {
                loadStats();
            }

            if (tabName === 'orders' && window.renderOrdersTable) {
                window.renderOrdersTable(document.getElementById('orderStatusFilter')?.value || '');
            }
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        if (window.loadProductsTable) window.loadProductsTable();
        if (window.bindOrdersEvents) window.bindOrdersEvents();
        if (window.renderOrdersTable) window.renderOrdersTable(document.getElementById('orderStatusFilter')?.value || '');

        // Tự động click vào tab đầu tiên (Quản lý sản phẩm)
        const firstTab = document.querySelector('.tab-btn[data-tab="products"]');
        if (firstTab) {
            firstTab.click();
        }
    });
})();