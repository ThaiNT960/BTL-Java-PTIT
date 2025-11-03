function getContextPath() {
    const p = window.location.pathname;
    const i = p.indexOf('/', 1);
    return i > 0 ? p.substring(0, i) : '';
}

function apiBase() {
    return window.location.origin + getContextPath();
}

function adminApi() {
    return apiBase() + '/admin/orders';
}

function productAdminApi() {
    return apiBase() + '/admin/products';
}

async function fetchJSON(url, opts) {
    const res = await fetch(url, Object.assign({
        headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
    }, opts || {}));
    if (!res.ok) throw new Error('HTTP ' + res.status + ' @ ' + url);
    return res.json();
}

function getCategoryDisplayName(category) {
    const map = { tshirt: 'Áo thun', hoodie: 'Hoodie', jacket: 'Áo khoác', accessories: 'Phụ kiện' };
    return map[category] || category || '';
}

function formatPrice(n) {
    return new Intl.NumberFormat('vi-VN').format(n || 0);
}

function formatVND(n) {
    return (n || 0).toLocaleString('vi-VN') + ' VNĐ';
}
