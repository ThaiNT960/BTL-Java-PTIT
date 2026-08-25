// Khóa lưu trữ giỏ hàng trong localStorage
const CART_STORAGE_KEY = 'ptitShopCart';

//  Lấy giỏ hàng
function getCart() {
    try {
        const data = localStorage.getItem(CART_STORAGE_KEY);
        return data ? JSON.parse(data) : [];
    } catch (err) {
        console.error('Lỗi đọc giỏ hàng:', err);
        return [];
    }
}

//  Lưu giỏ hàng
function saveCart(cart) {
    try {
        localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(cart));
        return true;
    } catch (err) {
        console.error('Lỗi lưu giỏ hàng:', err);
        return false;
    }
}

// Thêm sản phẩm
function addItemToCart(item) {
    const cart = getCart();

    const idx = cart.findIndex(i => i.id === item.id && i.size === item.size);
    if (idx !== -1) {
        cart[idx].quantity += item.quantity;
    } else {
        cart.push({
            id: item.id,
            name: item.name,
            price: item.price,
            size: item.size,
            quantity: item.quantity,
            image: item.image,
            addedAt: new Date().toISOString()
        });
    }

    const ok = saveCart(cart);
    if (ok && typeof showMiniCart === 'function') showMiniCart();
    return ok;
}


// Cập nhật số lượng
function updateItemQuantity(productId, size, newQty) {
    const cart = getCart();
    const idx = cart.findIndex(it => it.id === productId && it.size === size);
    if (idx === -1) return false;

    if (newQty <= 0) cart.splice(idx, 1);
    else cart[idx].quantity = newQty;

    const ok = saveCart(cart);
    if (ok && typeof showMiniCart === 'function') showMiniCart();
    return ok;
}

//  Xóa toàn bộ giỏ hàng
function clearCart() {
    const ok = saveCart([]);
    if (ok && typeof showMiniCart === 'function') showMiniCart();
    return ok;
}
