const formatVND = n => (n || 0).toLocaleString('vi-VN') + ' VNĐ';

// API helpers
function getContextPath() {
    const path = location.pathname;
    const idx = path.indexOf('/', 1);
    return idx > 0 ? path.substring(0, idx) : '';
}
function apiBase() { return location.origin + getContextPath(); }
function ordersApi() { return apiBase() + '/admin/orders'; }

// Fetch JSON an toàn
async function fetchJSON(url, opts = {}) {
    const init = { headers: { 'Accept': 'application/json' }, ...opts };
    if (init.body && !init.headers['Content-Type']) init.headers['Content-Type'] = 'application/json';
    const res = await fetch(url, init);
    if (!res.ok) throw new Error('HTTP ' + res.status + ' @ ' + url);
    return res.json();
}

// Trạng thái đơn hàng
const STATUS_MAP = {
    pending:   { label: 'Chờ xác nhận',  cls: 'bg-yellow-100 text-yellow-700' },
    confirmed: { label: 'Đã xác nhận',   cls: 'bg-blue-100 text-blue-700' },
    packing:   { label: 'Đang đóng gói', cls: 'bg-indigo-100 text-indigo-700' },
    shipped:   { label: 'Đã giao hàng',  cls: 'bg-purple-100 text-purple-700' },
    delivered: { label: 'Đã nhận',       cls: 'bg-green-100 text-green-700' },
    canceled:  { label: 'Đã hủy',        cls: 'bg-red-100 text-red-700' }
};

// Chuẩn hoá status tự do -> key chuẩn
function normalizeStatus(st) {
    if (st == null) return { key: 'pending', ...STATUS_MAP.pending };
    const s = String(st).trim().toLowerCase();
    if (['confirm','confirmed','ok','approved'].includes(s)) return { key: 'confirmed', ...STATUS_MAP.confirmed };
    if (['pack','packed','packing'].includes(s)) return { key: 'packing', ...STATUS_MAP.packing };
    if (['ship','shipping','shipped','in-transit'].includes(s)) return { key: 'shipped', ...STATUS_MAP.shipped };
    if (['delivered','done','success','completed','finish','finished'].includes(s)) return { key: 'delivered', ...STATUS_MAP.delivered };
    if (['cancel','canceled','cancelled','rejected','deny','denied'].includes(s)) return { key: 'canceled', ...STATUS_MAP.canceled };
    return { key: 'pending', ...STATUS_MAP.pending };
}

// Badge trạng thái
function badgeStatus(st) {
    const info = normalizeStatus(st);
    return `<span class="px-2 py-1 text-xs rounded ${info.cls}">${info.label}</span>`;
}

//Tải & render danh sách đơn
async function loadAllOrders() {
    const root = document.getElementById('historyRoot');
    if (!root) return;

    root.innerHTML = `<div class="text-gray-600">Đang tải...</div>`;

    try {
        const resp = await fetchJSON(ordersApi() + '?page=1&size=200');
        const list = Array.isArray(resp.data) ? resp.data : [];

        if (!list.length) {
            root.innerHTML = `
        <div class="text-center py-16">
          <h2 class="text-2xl font-bold mb-3">Chưa có đơn hàng</h2>
          <p class="text-gray-600 mb-8">Bạn chưa đặt đơn nào. Hãy tiếp tục mua sắm!</p>
          <button onclick="window.location.href='product.jsp'"
                  class="bg-black text-white px-6 py-3 rounded-lg font-semibold hover:bg-gray-800">
            Tiếp tục mua sắm
          </button>
        </div>`;
            return;
        }

        const rows = list.map(o => `
      <tr class="border-b hover:bg-gray-50">
        <td class="px-4 py-3 text-sm font-semibold">${o.orderCode}</td>
        <td class="px-4 py-3 text-sm">${new Date(o.createdAt || Date.now()).toLocaleString('vi-VN')}</td>
        <td class="px-4 py-3 text-sm">${o.fullname || '-'}</td>
        <td class="px-4 py-3 text-sm">${o.phone || '-'}</td>
        <td class="px-4 py-3 text-sm font-bold">${formatVND(o.total || 0)}</td>
        <td class="px-4 py-3 text-sm">${badgeStatus(o.status)}</td>
        <td class="px-4 py-3 text-sm text-center">
          <button class="text-blue-600 hover:text-blue-800" title="Xem chi tiết"
                  onclick="openOrderDetail('${o.id}', '${o.orderCode}')">
            <i class="fa-solid fa-eye"></i>
          </button>
        </td>
      </tr>`).join('');

        root.innerHTML = `
      <div class="bg-white rounded-lg shadow overflow-hidden">
        <table class="w-full">
          <thead class="bg-gray-50 border-b">
            <tr>
              <th class="px-4 py-3 text-left text-sm font-semibold">Mã đơn</th>
              <th class="px-4 py-3 text-left text-sm font-semibold">Ngày tạo</th>
              <th class="px-4 py-3 text-left text-sm font-semibold">Khách hàng</th>
              <th class="px-4 py-3 text-left text-sm font-semibold">SĐT</th>
              <th class="px-4 py-3 text-left text-sm font-semibold">Tổng tiền</th>
              <th class="px-4 py-3 text-left text-sm font-semibold">Trạng thái</th>
              <th class="px-4 py-3 text-center text-sm font-semibold">Chi tiết</th>
            </tr>
          </thead>
          <tbody>${rows}</tbody>
        </table>
      </div>`;
    } catch (err) {
        root.innerHTML = `
      <div class="text-red-600 py-8 text-center">
        Không tải được lịch sử đặt hàng.<br>
        <span class="text-gray-500 text-sm">${err.message}</span>
      </div>`;
    }
}

// Modal chi tiết đơn
async function openOrderDetail(id, code) {
    try {
        const data = await fetchJSON(ordersApi() + '?id=' + encodeURIComponent(id));
        const o = data.order, items = data.items || [];

        const itemsHtml = items.map(it => `
      <tr class="border-b">
        <td class="px-2 py-1">${it.productName}</td>
        <td class="px-2 py-1">${it.size || '-'}</td>
        <td class="px-2 py-1">${it.quantity}</td>
        <td class="px-2 py-1">${formatVND(it.price)}</td>
        <td class="px-2 py-1">${formatVND(it.lineTotal)}</td>
      </tr>`).join('');

        document.getElementById('orderDetailBody').innerHTML = `
      <div class="grid grid-cols-2 gap-4 text-sm">
        <div>
          <div><b>Mã đơn:</b> ${o.orderCode}</div>
          <div><b>Ngày tạo:</b> ${new Date(o.createdAt || Date.now()).toLocaleString('vi-VN')}</div>
          <div><b>Trạng thái:</b> ${badgeStatus(o.status)}</div>
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
            <thead>
              <tr class="bg-gray-100">
                <th class="px-2 py-1 text-left">Tên</th>
                <th class="px-2 py-1 text-left">Size</th>
                <th class="px-2 py-1 text-left">SL</th>
                <th class="px-2 py-1 text-left">Giá</th>
                <th class="px-2 py-1 text-left">Tạm tính</th>
              </tr>
            </thead>
            <tbody>${itemsHtml || '<tr><td class="px-2 py-2 text-gray-500" colspan="5">Không có sản phẩm</td></tr>'}</tbody>
          </table>
        </div>
      </div>
      <div class="mt-4 text-sm">
        <div><b>Tạm tính:</b> ${formatVND(o.subtotal || 0)}</div>
        <div><b>Phí ship:</b> ${formatVND(o.shippingFee || 0)}</div>
        <div><b>Giảm giá:</b> ${formatVND(o.discount || 0)}</div>
        <div class="text-lg font-bold"><b>Tổng:</b> ${formatVND(o.total || 0)}</div>
      </div>`;

        const modal = document.getElementById('orderDetailModal');
        modal.classList.remove('hidden');
        modal.classList.add('flex');
    } catch (err) {
        alert('Không tải được chi tiết đơn: ' + err.message);
    }
}

//  Đóng modal
function closeOrderDetail() {
    const m = document.getElementById('orderDetailModal');
    m.classList.add('hidden');
    m.classList.remove('flex');
}

// Gắn sự kiện đóng modal
document.getElementById('closeModalBtn')?.addEventListener('click', closeOrderDetail);
document.addEventListener('click', e => {
    if (e.target?.id === 'orderDetailModal') closeOrderDetail();
});


document.addEventListener('DOMContentLoaded', loadAllOrders);
