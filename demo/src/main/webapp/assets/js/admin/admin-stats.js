(function () {
    'use strict';

    // Đếm tổng số sản phẩm
    async function loadStats() {
        try {
            const products = await window.fetchProducts();
            const el = document.getElementById('totalProducts');
            if (el) el.textContent = products.length;
        } catch {
            const el = document.getElementById('totalProducts');
            if (el) el.textContent = '0';
        }
    }

    // Xử lý chuyển tab
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            const tabName = this.getAttribute('data-tab');
            document.querySelectorAll('.tab-content').forEach(tab => tab.classList.add('hidden'));
            document.querySelectorAll('.tab-btn').forEach(b => {
                b.classList.remove('border-black');
                b.classList.add('border-transparent');
            });
            document.getElementById(tabName + '-tab').classList.remove('hidden');
            this.classList.remove('border-transparent');
            this.classList.add('border-black');
            if (tabName === 'stats') loadStats();
            if (tabName === 'orders')
                window.renderOrdersTable(document.getElementById('orderStatusFilter')?.value || '');
        });
    });


    document.addEventListener('DOMContentLoaded', function () {
        window.loadProductsTable();
        window.bindOrdersEvents();
        window.renderOrdersTable(document.getElementById('orderStatusFilter')?.value || '');
    });
})();
