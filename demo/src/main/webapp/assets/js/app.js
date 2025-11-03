document.addEventListener('DOMContentLoaded', () => {
    updateCartBadge();     // Cập nhật số lượng giỏ hàng
    updateMiniCart();       // Cập nhật mini-cart
});
function searchProducts() {
    const term = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('.product-card').forEach(card => {
        const title = card.querySelector('.product-title').textContent.toLowerCase();
        const desc = card.querySelector('.product-description').textContent.toLowerCase();
        card.style.display = (title.includes(term) || desc.includes(term)) ? 'block' : 'none';
    });
}
// Thêm sản phẩm vào giỏ
function addToCart(productId) {
    const sizeEl = document.getElementById(`size-${productId}`);
    const qtyEl  = document.getElementById(`qty-${productId}`);
    if (!sizeEl || !qtyEl) return;

    const quantity = Math.max(1, parseInt(qtyEl.value || '1', 10));
    const selectedSize = sizeEl.value;

    const card = sizeEl.closest('.product-card');
    if (!card) return;

    const name  = card.querySelector('.product-title')?.textContent.trim() || '';
    const price = parseInt(card.querySelector('.product-price')?.textContent.replace(/[^\d]/g, '') || 0, 10);
    const image = card.querySelector('.product-image')?.getAttribute('src') || '';
    if (!name || !price) return;

    const item = { id: productId, name, price, size: selectedSize, quantity, image };
    addItemToCart(item);
    updateCartBadge();
    updateMiniCart();
    showToast(`Đã thêm ${name} vào giỏ hàng`);
}

//  Hiển thị số lượng ở icon giỏ hàng
function updateCartBadge() {
    const cart = getCart();
    const total = cart.reduce((sum, item) => sum + item.quantity, 0);

    let badge = document.querySelector('.cart-badge');
    const cartLink = document.querySelector('a[href="cart.jsp"]');

    if (!badge && total > 0 && cartLink) {
        badge = document.createElement('span');
        badge.className = 'cart-badge';
        badge.style.cssText = `
            position:absolute;top:-8px;right:-8px;
            background:var(--primary-color);color:white;
            border-radius:50%;width:20px;height:20px;
            font-size:12px;display:flex;align-items:center;
            justify-content:center;font-weight:bold;
        `;
        cartLink.style.position = 'relative';
        cartLink.appendChild(badge);
    }

    if (badge) {
        badge.textContent = total;
        badge.style.display = total > 0 ? 'flex' : 'none';
    }
}

// Cập nhật mini-cart và tính tổng tiền
function updateMiniCart() {
    const miniCart = document.getElementById('miniCart');
    if (!miniCart) return;

    const cart = getCart();
    const itemsBox = document.getElementById('cartItems');
    const cartTotal = document.getElementById('cartTotal');
    const checkoutBtn = document.getElementById('checkoutBtn');
    const totalAmount = document.getElementById('totalAmount');

    if (!cart.length) {
        itemsBox.innerHTML = '<p style="text-align:center;color:#666;">Chưa có sản phẩm nào</p>';
        cartTotal.style.display = 'none';
        checkoutBtn.style.display = 'none';
        return;
    }

    let total = 0;
    itemsBox.innerHTML = cart.map(it => {
        const itemTotal = it.price * it.quantity;
        total += itemTotal;
        return `
        <div class="cart-item flex justify-between items-start py-2 border-b border-gray-200 last:border-0">
            <div>
                <div style="font-size:11px;font-weight:bold;color:#111;">${it.name}</div>
                <div style="font-size:11px;color:#666;margin-top:2px;">Size: ${it.size} | SL: ${it.quantity}</div>
            </div>
            <div style="font-size:11px;font-weight:700;color:#111;white-space:nowrap;text-align:right;">
                ${formatPrice(itemTotal)} VNĐ
            </div>
        </div>`;
    }).join('');

    totalAmount.textContent = formatPrice(total);
    cartTotal.style.display = 'block';
    checkoutBtn.style.display = 'block';
}

function goToOrder() {
    window.location.href = 'cart.jsp';
}

function showToast(message) {
    const toast = document.createElement('div');
    toast.style.cssText = `
        position: fixed;
        top: 16px;
        right: 16px;
        background: #ff4d4d;           /* đỏ */
        color: #fff;                   /* chữ trắng */
        padding: 4px 8px;             
        border-radius: 3px;
        z-index: 10000;
        font-size: 0.95rem;            
        font-weight: 500;
        box-shadow: 0 2px 4px rgba(0,0,0,0.15);
        transform: translateX(130%);
        transition: transform 0.35s ease;
        min-width: 100px;             
        text-align: center;
        `;
    toast.textContent = message;
    document.body.appendChild(toast);
    // Trượt vào
    setTimeout(() => { toast.style.transform = 'translateX(0)'; }, 100);
    // Trượt ra và xóa sau 3 giây
    setTimeout(() => {
        toast.style.transform = 'translateX(120%)';
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}


function formatPrice(price) {
    return new Intl.NumberFormat('vi-VN').format(price);
}


window.addToCart = addToCart;
window.goToOrder = goToOrder;

