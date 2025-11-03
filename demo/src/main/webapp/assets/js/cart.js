function getContextPath() {
    const path = window.location.pathname;
    const firstSlash = path.indexOf('/', 1);
    return firstSlash > 0 ? path.substring(0, firstSlash) : '';
}
window.APP_CONTEXT = getContextPath();

const DISCOUNT_RATE = 0.2;
const SHIPPING_FEE  = 35000;

function formatVND(n) {
    return (n || 0).toLocaleString('vi-VN') + ' VNĐ';
}

//  Ghép đường dẫn ảnh
function resolveImg(src) {
    if (!src) return APP_CONTEXT + '/assets/img/default-product.jpg';
    if (/^https?:\/\//i.test(src)) return src;
    return src.startsWith(APP_CONTEXT + '/') ? src : (APP_CONTEXT + '/' + src.replace(/^\/+/, ''));
}

//  Render giỏ hàng
function renderCart() {
    const root = document.getElementById('orderContent');
    if (!root) return;

    // Lấy dữ liệu giỏ từ localStorage
    const cart = (typeof getCart === 'function')
        ? getCart()
        : JSON.parse(localStorage.getItem('ptitShopCart') || '[]');

    // Nếu giỏ trống
    if (!Array.isArray(cart) || cart.length === 0) {
        root.innerHTML = `
            <div class="text-center py-16">
                <h2 class="text-2xl font-bold mb-3">Giỏ hàng của bạn đang trống</h2>
                <p class="text-gray-600 mb-8">Hãy tiếp tục mua sắm để thêm sản phẩm vào giỏ.</p>
                <button onclick="window.location.href='${APP_CONTEXT}/products'"
                        class="bg-black text-white px-6 py-3 rounded-lg font-semibold hover:bg-gray-800">
                    Tiếp tục mua sắm
                </button>
            </div>`;
        return;
    }

    // Tính tổng phụ và tạo HTML sản phẩm
    let subtotal = 0;
    const itemsHtml = cart.map(it => {
        const qty   = Math.max(1, parseInt(it.quantity || 1, 10) || 1);
        const price = parseInt(it.price || 0, 10) || 0;
        const line  = price * qty;
        subtotal   += line;

        return `
            <div class="relative flex gap-6 pb-6 border-b border-gray-200 mb-6 items-center">
                <div class="w-24 h-24 bg-gray-100 rounded-lg overflow-hidden flex-shrink-0">
                    <img src="${resolveImg(it.image)}" 
                         alt="${it.name || 'Sản phẩm'}"
                         class="w-full h-full object-cover"
                         onerror="this.src='${APP_CONTEXT}/assets/img/default-product.jpg'">
                </div>

                <div class="flex-1">
                    <h3 class="font-semibold mb-1 text-gray-900">${it.name || 'Sản phẩm'}</h3>
                    <p class="text-gray-600 text-sm mb-1">Size: ${it.size || '—'}</p>
                    <p class="text-gray-600 text-sm mb-2">SL: ${qty}</p>
                    <p class="font-bold">${formatVND(price)}</p>
                </div>

                <div class="text-right">
                    <button class="absolute top-0 right-0 text-red-500 hover:text-red-700 text-xl"
                            title="Xóa khỏi giỏ"
                            onclick="removeFromCart(${it.id}, '${String(it.size || '')}')">
                        <i class="fa-solid fa-trash"></i>
                    </button>
                </div>
            </div>`;
    }).join('');

    // Tính tổng và hiển thị
    const discount = Math.round(subtotal * DISCOUNT_RATE);
    const shipping = cart.length ? SHIPPING_FEE : 0;
    const total    = subtotal - discount + shipping;

    const summaryHtml = `
        <div class="bg-gray-50 p-6 rounded-lg h-fit">
            <h2 class="text-xl font-bold mb-6">Tóm tắt đơn hàng</h2>

            <div class="space-y-4 mb-6">
                <div class="flex justify-between">
                    <span class="text-gray-600">Tổng phụ</span>
                    <span class="font-semibold text-black">${formatVND(subtotal)}</span>
                </div>
                <div class="flex justify-between">
                    <span class="text-gray-600">Chiết khấu (-20%)</span>
                    <span class="font-semibold text-red-500">- ${formatVND(discount)}</span>
                </div>
                <div class="flex justify-between">
                    <span class="text-gray-600">Phí giao hàng</span>
                    <span class="font-semibold text-black">${formatVND(shipping)}</span>
                </div>
            </div>

            <div class="border-t border-gray-300 pt-4 mb-6">
                <div class="flex justify-between text-lg">
                    <span class="font-bold">Tổng cộng</span>
                    <span class="font-bold text-black">${formatVND(total)}</span>
                </div>
            </div>

            <!-- Form thông tin khách hàng -->
            <h3 class="text-lg font-semibold mb-4">Thông tin liên hệ</h3>
            <div class="space-y-3 mb-6">
                <div>
                    <label class="block text-sm font-medium mb-1">Họ và tên *</label>
                    <input id="fullname" type="text" class="w-full border border-gray-300 rounded-lg px-4 py-2 text-sm">
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1">Số điện thoại *</label>
                    <input id="phone" type="tel" class="w-full border border-gray-300 rounded-lg px-4 py-2 text-sm">
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1">Zalo</label>
                    <input id="zalo" type="text" class="w-full border border-gray-300 rounded-lg px-4 py-2 text-sm">
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1">Email</label>
                    <input id="email" type="email" class="w-full border border-gray-300 rounded-lg px-4 py-2 text-sm">
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1">Địa chỉ *</label>
                    <input id="address" type="text" class="w-full border border-gray-300 rounded-lg px-4 py-2 text-sm">
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1">Ghi chú</label>
                    <textarea id="note" rows="3" class="w-full border border-gray-300 rounded-lg px-4 py-2 text-sm"></textarea>
                </div>
            </div>

            <button id="submitOrderBtn"
                    class="w-full bg-black text-white py-3 rounded-full font-semibold hover:bg-gray-800"
                    onclick="submitOrderForm()">
                Yêu cầu đặt hàng
            </button>
        </div>`;

    root.innerHTML = `
        <div class="grid grid-cols-3 gap-8">
            <div class="col-span-2">${itemsHtml}</div>
            ${summaryHtml}
        </div>`;
}

// Xóa sản phẩm khỏi giỏ
function removeFromCart(productId, size) {
    const cart = JSON.parse(localStorage.getItem('ptitShopCart') || '[]');
    const newCart = cart.filter(it => !(it.id === productId && String(it.size || '') === String(size || '')));
    localStorage.setItem('ptitShopCart', JSON.stringify(newCart));

    if (typeof updateCartBadge === 'function') updateCartBadge();
    if (typeof updateMiniCart === 'function') updateMiniCart();

    renderCart();
}

//  Gửi đơn hàng lên backend
async function submitOrderForm() {
    const btn = document.getElementById('submitOrderBtn');
    const fullname = document.getElementById("fullname")?.value.trim();
    const phoneRaw = document.getElementById("phone")?.value.trim();
    const zalo     = document.getElementById("zalo")?.value.trim() || '';
    const email    = document.getElementById("email")?.value.trim() || '';
    const address  = document.getElementById("address")?.value.trim() || '';
    const note     = document.getElementById("note")?.value.trim() || '';

    if (!fullname || !phoneRaw || !address) {
        alert("Vui lòng nhập đầy đủ họ tên, SĐT và địa chỉ!");
        return;
    }

    const phone = phoneRaw.replace(/\D/g, '');
    const cart = JSON.parse(localStorage.getItem('ptitShopCart') || '[]');

    let subtotal = 0;
    cart.forEach(it => { subtotal += (it.price || 0) * (it.quantity || 1); });
    const discount = Math.round(subtotal * DISCOUNT_RATE);
    const shipping = cart.length ? SHIPPING_FEE : 0;
    const total    = subtotal - discount + shipping;

    const payload = {
        customer: { fullname, phone, zalo, email, address, note },
        items: cart.map(it => ({
            productId: it.id,
            name: it.name,
            size: String(it.size || ''),
            price: Number(it.price || 0),
            quantity: Number(it.quantity || 1),
            subtotal: Number(it.price || 0) * Number(it.quantity || 1),
            image: it.image || ''
        })),
        summary: { subtotal, discount, shipping, total }
    };

    try {
        if (btn) { btn.disabled = true; btn.classList.add('opacity-60'); }

        const res = await fetch(APP_CONTEXT + "/orders", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        });
        if (!res.ok) throw new Error(await res.text() || 'Đặt hàng thất bại');

        const data = await res.json();

        // Xóa giỏ và hiển thị thông báo
        localStorage.removeItem('ptitShopCart');
        if (typeof updateCartBadge === 'function') updateCartBadge();
        if (typeof updateMiniCart === 'function') updateMiniCart();

        const orderContent = document.getElementById("orderContent");
        const backUrl = APP_CONTEXT + '/products';
        const showOrderId = data?.orderId || ('ORD' + Date.now());
        const showTotal   = (typeof data?.total === 'number') ? data.total : total;

        if (orderContent) {
            orderContent.innerHTML = `
                <div class="text-center py-12">
                    <h2 class="text-2xl font-bold text-green-600 mb-4">Đặt hàng thành công!</h2>
                    <p class="text-lg mb-2">Mã đơn hàng: 
                        <span class="font-mono font-semibold text-gray-800">${showOrderId}</span>
                    </p>
                    <p class="text-gray-600 mb-2">Tổng cộng: <b>${formatVND(showTotal)}</b></p>
                    <p class="text-gray-600 mb-8">Cảm ơn bạn đã đặt hàng. Shop sẽ liên hệ sớm để xác nhận đơn.</p>
                    <button onclick="window.location.href='${backUrl}'"
                            class="bg-black text-white px-6 py-3 rounded-lg font-semibold hover:bg-gray-800">
                        Tiếp tục mua sắm
                    </button>
                </div>`;
        } else {
            alert("Đặt hàng thành công! Mã đơn: " + showOrderId);
            window.location.href = backUrl;
        }
    } catch (err) {
        alert("Có lỗi khi gửi đơn: " + (err?.message || err));
    } finally {
        if (btn) { btn.disabled = false; btn.classList.remove('opacity-60'); }
    }
}

// Tự động render giỏ khi trang load
document.addEventListener('DOMContentLoaded', renderCart);
