// Quản lý đơn hàng: trạng thái, render, chi tiết, cập nhật, xóa, export CSV
(function () {
    'use strict';

    const STATUS_MAP = {
        pending:   { label: 'Chờ xác nhận',  cls: 'bg-yellow-100 text-yellow-700' },
        confirmed: { label: 'Đã xác nhận',   cls: 'bg-blue-100 text-blue-700' },
        packing:   { label: 'Đang đóng gói', cls: 'bg-indigo-100 text-indigo-700' },
        shipped:   { label: 'Đã giao hàng',  cls: 'bg-purple-100 text-purple-700' },
        delivered: { label: 'Đã nhận',       cls: 'bg-green-100 text-green-700' },
        canceled:  { label: 'Đã hủy',        cls: 'bg-red-100 text-red-700' }
    };

    // Chuẩn hoá chuỗi trạng thái về key chuẩn
    function normalizeStatus(st) {
        if (st == null) return { key: 'pending', ...STATUS_MAP.pending };
        const s = String(st).trim().toLowerCase();
        if (s === 'true')  return { key: 'confirmed', ...STATUS_MAP.confirmed };
        if (s === 'false') return { key: 'pending',   ...STATUS_MAP.pending };
        if (['new','submit','submitted','summited','waiting','pending'].includes(s)) return { key: 'pending', ...STATUS_MAP.pending };
        if (['confirm','confirmed','ok','approved'].includes(s)) return { key: 'confirmed', ...STATUS_MAP.confirmed };
        if (['pack','packed','packing'].includes(s)) return { key: 'packing', ...STATUS_MAP.packing };
        if (['ship','shipping','shipped','in-transit'].includes(s)) return { key: 'shipped', ...STATUS_MAP.shipped };
        if (['delivered','done','success','completed','finish','finished'].includes(s)) return { key: 'delivered', ...STATUS_MAP.delivered };
        if (['cancel','canceled','cancelled','rejected','deny','denied'].includes(s)) return { key: 'canceled', ...STATUS_MAP.canceled };
        return { key: 'pending', ...STATUS_MAP.pending };
    }

    function badge(st) {
        const info = normalizeStatus(st);
        return `<span class="px-2 py-1 text-xs rounded ${info.cls}">${info.label}</span>`;
    }

    let LAST_ORDERS_LIST = [];
    let LAST_FILTER = '';
    let CURRENT_ORDER_ID = null;

    // API: danh sách đơn
    async function fetchOrders(status = '') {
        const url = adminApi() + (status ? ('?status=' + encodeURIComponent(status)) : '');
        return fetchJSON(url);
    }

    // API: chi tiết đơn theo id/code
    async function fetchOrderDetail({ id, code }) {
        const qs = new URLSearchParams();
        if (id) qs.set('id', id);
        if (code) qs.set('code', code);
        return fetchJSON(adminApi() + '?' + qs.toString());
    }

    // API: cập nhật trạng thái theo id
    async function updateOrderStatus(id, status) {
        const url = adminApi() + '?id=' + encodeURIComponent(id);
        return fetchJSON(url, { method: 'PUT', body: JSON.stringify({ status }) });
    }

    // Render bảng đơn hàng
    async function renderOrdersTable(filter = '') {
        const el = document.getElementById('ordersTable');
        if (!el) return;

        LAST_FILTER = filter || '';
        el.innerHTML = `
      <tr><td colspan="7" class="px-6 py-6 text-center text-gray-500">
        Đang tải danh sách đơn hàng...
      </td></tr>`;

        const resp = await fetchOrders(LAST_FILTER);
        const list = Array.isArray(resp.data) ? resp.data : [];
        LAST_ORDERS_LIST = list;

        el.innerHTML = list.length
            ? list.map(o => `
        <tr class="border-b border-gray-200 hover:bg-gray-50">
          <td class="px-6 py-3 text-sm font-semibold">${o.orderCode}</td>
          <td class="px-6 py-3 text-sm">${o.fullname || '-'}</td>
          <td class="px-6 py-3 text-sm">${o.phone || '-'}</td>
          <td class="px-6 py-3 text-sm font-bold">${formatVND(o.total || 0)}</td>
          <td class="px-6 py-3 text-sm">${o.createdAt ? new Date(o.createdAt).toLocaleString('vi-VN') : '-'}</td>
          <td class="px-6 py-3 text-sm">${badge(o.status)}</td>
          <td class="px-6 py-3 text-sm">
            <div class="flex items-center gap-2">
              <button class="p-2 text-blue-600 hover:text-blue-800" title="Xem chi tiết"
                onclick="openOrderDetail('${o.id}', '${o.orderCode}')"><i class="fas fa-eye"></i></button>
              <button class="p-2 text-red-600 hover:text-red-800" title="Xóa đơn hàng"
                onclick="deleteOrder('${o.orderCode}')"><i class="fa-solid fa-trash"></i></button>
            </div>
          </td>
        </tr>`).join('')
            : `
        <tr><td colspan="7" class="px-6 py-10 text-center text-gray-500">Chưa có đơn hàng</td></tr>`;
    }

    // Mở modal chi tiết đơn
    window.openOrderDetail = async function (id, code) {
        try {
            const data = await fetchOrderDetail({ id, code });
            const o = data.order, items = data.items || [];
            CURRENT_ORDER_ID = o.id;

            const itemsHtml = items.map(it => `
        <tr class="border-b">
          <td class="px-2 py-1">${it.productName}</td>
          <td class="px-2 py-1">${it.quantity}</td>
          <td class="px-2 py-1">${formatVND(it.price)}</td>
          <td class="px-2 py-1">${formatVND(it.lineTotal)}</td>
        </tr>
      `).join('');

            document.getElementById('orderDetailBody').innerHTML = `
        <div class="grid grid-cols-2 gap-4 text-sm">
          <div>
            <div><b>Mã đơn:</b> ${o.orderCode}</div>
            <div><b>Ngày tạo:</b> ${new Date(o.createdAt).toLocaleString('vi-VN')}</div>
            <div><b>Trạng thái:</b> ${badge(o.status)}</div>
          </div>
          <div>
            <div><b>Khách hàng:</b> ${o.fullname || '-'}</div>
            <div><b>SĐT:</b> ${o.phone || '-'}</div>
            <div><b>Địa chỉ:</b> ${o.address || '-'}</div>
          </div>
        </div>
        <div class="mt-3"><b>Ghi chú:</b> ${o.note || '-'}</div>
        <div class="mt-4">
          <b>Sản phẩm:</b>
          <div class="bg-gray-50 rounded border mt-2 overflow-auto">
            <table class="w-full text-sm">
              <thead><tr class="bg-gray-100">
                <th class="px-2 py-1 text-left">Tên</th>
                <th class="px-2 py-1 text-left">SL</th>
                <th class="px-2 py-1 text-left">Giá</th>
                <th class="px-2 py-1 text-left">Tạm tính</th>
              </tr></thead>
              <tbody>${itemsHtml || '<tr><td class="px-2 py-2 text-gray-500" colspan="4">Không có sản phẩm</td></tr>'}</tbody>
            </table>
          </div>
        </div>
        <div class="mt-4 text-sm">
          <div><b>Tạm tính:</b> ${formatVND(o.subtotal || 0)}</div>
          <div><b>Phí ship:</b> ${formatVND(o.shippingFee || 0)}</div>
          <div><b>Giảm giá:</b> ${formatVND(o.discount || 0)}</div>
          <div class="text-lg font-bold"><b>Tổng:</b> ${formatVND(o.total || 0)}</div>
        </div>
      `;

            const sel = document.getElementById('orderStatusSelect');
            if (sel) sel.value = normalizeStatus(o.status).key;

            const modal = document.getElementById('orderDetailModal');
            modal.classList.remove('hidden');
            modal.classList.add('flex');
        } catch (err) {
            alert('Không tải được chi tiết đơn: ' + err.message);
        }
    };

    // Đóng modal chi tiết
    function closeOrderDetail() {
        const modal = document.getElementById('orderDetailModal');
        modal.classList.add('hidden');
        modal.classList.remove('flex');
        CURRENT_ORDER_ID = null;
    }

    // Lưu trạng thái đơn theo select hiện tại
    async function saveOrderStatus() {
        if (!CURRENT_ORDER_ID) return;
        const sel = document.getElementById('orderStatusSelect');
        const key = normalizeStatus(sel?.value).key;
        try {
            await updateOrderStatus(CURRENT_ORDER_ID, key);
            await renderOrdersTable(document.getElementById('orderStatusFilter')?.value || '');
            await openOrderDetail(CURRENT_ORDER_ID);
        } catch (err) {
            alert('Cập nhật trạng thái thất bại: ' + err.message);
        }
    }

    // Gắn sự kiện: filter, export, modal, lưu trạng thái
    function bindOrdersEvents() {
        const f = document.getElementById('orderStatusFilter');
        if (f) f.addEventListener('change', e => renderOrdersTable(e.target.value || ''));

        const x = document.getElementById('exportOrdersBtn');
        if (x) x.addEventListener('click', () => {
            const data = LAST_ORDERS_LIST.map(o => ({
                orderId: o.orderCode,
                createdAt: o.createdAt,
                fullname: o.fullname || '',
                phone: o.phone || '',
                total: o.total || 0,
                status: normalizeStatus(o.status).key
            }));
            const header = 'orderId,createdAt,fullname,phone,total,status\n';
            const csv = header + data.map(r =>
                `${r.orderId},${r.createdAt},${r.fullname},${r.phone},${r.total},${r.status}`
            ).join('\n');
            const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `orders_${Date.now()}.csv`;
            a.click();
            URL.revokeObjectURL(url);
        });

        document.getElementById('closeModalBtn')?.addEventListener('click', closeOrderDetail);
        document.getElementById('saveOrderStatusBtn')?.addEventListener('click', saveOrderStatus);
        document.getElementById('orderDetailModal')?.addEventListener('click', e => {
            if (e.target.id === 'orderDetailModal') closeOrderDetail();
        });
    }

    // Xuất hàm cho file khác gọi
    window.renderOrdersTable = renderOrdersTable;
    window.bindOrdersEvents  = bindOrdersEvents;

    // Xoá đơn theo orderCode
    window.deleteOrder = async function (code) {
        if (!confirm('Bạn có chắc muốn xóa đơn hàng ' + code + ' ?')) return;
        const url = adminApi() + '?code=' + encodeURIComponent(code);
        try {
            const res = await fetch(url, { method: 'DELETE', headers: { 'Accept': 'application/json' } });
            if (!res.ok) throw new Error('HTTP ' + res.status);
            await renderOrdersTable(document.getElementById('orderStatusFilter')?.value || '');
            alert('Đã xóa đơn hàng ' + code);
        } catch (err) {
            alert('Xóa thất bại: ' + err.message);
        }
    };
})();
