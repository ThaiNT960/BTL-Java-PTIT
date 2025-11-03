// Quản lý sản phẩm: fetch, render bảng, thêm/sửa/xoá
(function () {
    'use strict';
    // Lấy danh sách sản phẩm từ /products (JSON)
    async function fetchProducts() {
        const url = apiBase() + '/products?format=json';
        const res = await fetchJSON(url);
        if (Array.isArray(res)) return res;
        if (res && Array.isArray(res.data)) return res.data;
        return [];
    }

    // Render bảng sản phẩm vào #productTable
    async function loadProductsTable() {
        const tableBody = document.getElementById('productTable');
        if (!tableBody) return;

        tableBody.innerHTML = `
      <tr><td colspan="6" class="px-6 py-6 text-center text-gray-500">
        Đang tải danh sách sản phẩm...
      </td></tr>`;

        const products = await fetchProducts();
        if (!products.length) {
            tableBody.innerHTML = `
        <tr><td colspan="6" class="px-6 py-6 text-center text-gray-500">
          Chưa có sản phẩm
        </td></tr>`;
            return;
        }

        tableBody.innerHTML = products.map(product => `
      <tr class="border-b border-gray-200 hover:bg-gray-50">
        <td class="px-6 py-4 text-sm">${product.id}</td>
        <td class="px-6 py-4 text-sm font-semibold">${product.name}</td>
        <td class="px-6 py-4 text-sm">${getCategoryDisplayName(product.category)}</td>
        <td class="px-6 py-4 text-sm font-bold">${formatPrice(product.price)} VNĐ</td>
        <td class="px-6 py-4 text-sm text-gray-600">${(product.description || '').substring(0, 40)}...</td>
        <td class="px-6 py-4 text-sm">
          <button class="text-blue-600 hover:text-blue-800 mr-4" onclick="editProduct(${product.id})"><i class="fas fa-edit"></i></button>
          <button class="text-red-600 hover:text-red-800" onclick="deleteProduct(${product.id})"><i class="fas fa-trash-alt"></i></button>
        </td>
      </tr>
    `).join('');
    }

    let EDITING_ID = null;

    // Mở modal thêm sản phẩm
    window.openAddProductModal = function () {
        EDITING_ID = null;
        const form = document.getElementById('productForm');
        if (form) form.reset();
        const titleEl = document.querySelector('#productModal h3');
        if (titleEl) titleEl.textContent = 'Thêm sản phẩm';
        document.getElementById('productModal')?.classList.remove('hidden');
    };

    // Đóng modal sản phẩm
    window.closeProductModal = function () {
        document.getElementById('productModal')?.classList.add('hidden');
        EDITING_ID = null;
    };

    // Nạp dữ liệu sản phẩm vào form để sửa theo id
    window.editProduct = async function (id) {
        const products = await fetchProducts();
        const p = products.find(x => String(x.id) === String(id));
        if (!p) { alert('Không tìm thấy sản phẩm #' + id); return; }

        EDITING_ID = p.id;
        const $ = (i) => document.getElementById(i);
        if ($('productName'))        $('productName').value        = p.name || '';
        if ($('productCategory'))    $('productCategory').value    = p.category || '';
        if ($('productPrice'))       $('productPrice').value       = p.price || 0;
        if ($('productDescription')) $('productDescription').value = p.description || '';
        if ($('productImage'))       $('productImage').value       = p.image || '';
        if ($('productSizes'))       $('productSizes').value       = (p.sizes || []).join(',');

        const titleEl = document.querySelector('#productModal h3');
        if (titleEl) titleEl.textContent = 'Sửa sản phẩm #' + p.id;
        document.getElementById('productModal')?.classList.remove('hidden');
    };

    // Xoá sản phẩm theo id
    window.deleteProduct = async function (id) {
        if (!confirm('Bạn có chắc muốn xóa sản phẩm #' + id + ' ?')) return;
        const url = productAdminApi() + '?id=' + encodeURIComponent(id);
        try {
            const res = await fetch(url, { method: 'DELETE', headers: { 'Accept': 'application/json' } });
            if (!res.ok) throw new Error('HTTP ' + res.status);
            await loadProductsTable();
            alert('Đã xóa sản phẩm #' + id);
        } catch (err) {
            alert('Xóa thất bại: ' + (err?.message || err));
        }
    };

    // Submit form: thêm mới / cập nhật (POST/PUT)
    document.getElementById('productForm')?.addEventListener('submit', async function (e) {
        e.preventDefault();
        const $ = (i) => document.getElementById(i);

        const sizesCsv = (($('productSizes')?.value || '')
            .split(',').map(s => s.trim()).filter(Boolean).join(','));

        const payload = {
            name:        $('productName')?.value?.trim(),
            category:    $('productCategory')?.value,
            price:       Number($('productPrice')?.value || 0),
            description: $('productDescription')?.value || '',
            image:       $('productImage')?.value?.trim() || '',
            sizes:       sizesCsv
        };

        if (!payload.name || !payload.category) {
            alert('Vui lòng nhập Tên và Danh mục'); return;
        }

        try {
            const url = EDITING_ID == null
                ? productAdminApi()
                : productAdminApi() + '?id=' + encodeURIComponent(EDITING_ID);

            await fetch(url, {
                method: EDITING_ID == null ? 'POST' : 'PUT',
                headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' },
                body: JSON.stringify(payload)
            });

            document.getElementById('productModal')?.classList.add('hidden');
            EDITING_ID = null;
            await loadProductsTable();
            alert('Đã lưu sản phẩm');
        } catch (err) {
            alert('Lưu thất bại: ' + (err?.message || err));
        }
    });
    // Export cho file khác dùng
    window.fetchProducts     = fetchProducts;
    window.loadProductsTable = loadProductsTable;
})();
