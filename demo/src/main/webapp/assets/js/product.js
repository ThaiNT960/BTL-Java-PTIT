// Phân trang  & search
(function () {
    const PAGE_SIZE = 9;
    const grid = document.getElementById('productGrid');
    const pagination = document.querySelector('.flex.justify-center.items-center.gap-4.mb-8');

    // Gắn sự kiện Enter để tìm kiếm
    const navSearch = document.querySelector('nav input[type="text"]');
    if (navSearch) {
        navSearch.id = 'searchInput';
        navSearch.addEventListener('keydown', (e) => {
            if (e.key === 'Enter' && typeof window.searchProducts === 'function') {
                window.searchProducts();
            }
        });
    }

    if (!grid || !pagination) return;

    function setup() {
        const items = Array.from(grid.children);
        if (!items.length) return;

        const totalPages = Math.max(1, Math.ceil(items.length / PAGE_SIZE));
        let currentPage = 1;

        const btns = Array.from(pagination.querySelectorAll('button, span'));
        const prevBtn = btns.find(b => b.tagName === 'BUTTON' && b.textContent.trim().startsWith('←'));
        const nextBtn = btns.find(b => b.tagName === 'BUTTON' && b.textContent.trim().endsWith('→'));

        // Xóa số trang cũ, giữ Prev/Next
        btns.forEach(el => {
            if (el !== prevBtn && el !== nextBtn) el.remove();
        });

        function createPageButton(n) {
            const b = document.createElement('button');
            b.className = 'px-4 py-2 border border-gray-300 rounded hover:bg-gray-100';
            b.textContent = String(n);
            b.onclick = () => goto(n);
            return b;
        }

        function reflectButtons() {
            Array.from(pagination.querySelectorAll('button'))
                .filter(b => b !== prevBtn && b !== nextBtn).forEach(b => b.remove());
            Array.from(pagination.querySelectorAll('span.text-gray-600')).forEach(s => s.remove());

            const windowSize = 5;
            let start = Math.max(1, currentPage - Math.floor(windowSize / 2));
            let end = Math.min(totalPages, start + windowSize - 1);
            if (end - start + 1 < windowSize) start = Math.max(1, end - windowSize + 1);

            const insertBeforeNext = (node) => pagination.insertBefore(node, nextBtn);

            if (start > 1) {
                insertBeforeNext(createPageButton(1));
                const dots = document.createElement('span');
                dots.className = 'text-gray-600';
                dots.textContent = '...';
                insertBeforeNext(dots);
            }
            for (let i = start; i <= end; i++) {
                const b = createPageButton(i);
                if (i === currentPage) b.className = 'px-4 py-2 bg-black text-white rounded';
                insertBeforeNext(b);
            }
            if (end < totalPages) {
                const dots2 = document.createElement('span');
                dots2.className = 'text-gray-600';
                dots2.textContent = '...';
                insertBeforeNext(dots2);
                insertBeforeNext(createPageButton(totalPages));
            }

            if (prevBtn) {
                prevBtn.disabled = (currentPage === 1);
                prevBtn.classList.toggle('opacity-50', currentPage === 1);
                prevBtn.onclick = () => goto(currentPage - 1);
            }
            if (nextBtn) {
                nextBtn.disabled = (currentPage === totalPages);
                nextBtn.classList.toggle('opacity-50', currentPage === totalPages);
                nextBtn.onclick = () => goto(currentPage + 1);
            }
        }

        function renderPage() {
            const start = (currentPage - 1) * PAGE_SIZE;
            const end = start + PAGE_SIZE;
            items.forEach((el, i) => {
                el.style.display = (i >= start && i < end) ? '' : 'none';
            });
            reflectButtons();
        }

        function goto(n) {
            currentPage = Math.min(totalPages, Math.max(1, n));
            renderPage();
            grid.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }

        renderPage();
    }

    // Đợi khi sản phẩm render xong mới phân trang
    if (grid.children.length) {
        setup();
    } else {
        const obs = new MutationObserver(() => {
            if (grid.children.length) {
                obs.disconnect();
                setup();
            }
        });
        obs.observe(grid, { childList: true });
    }
})();

const miniCart = document.getElementById('miniCart');
const closeBtn = document.getElementById('closeMiniCart');

if (closeBtn) {
    closeBtn.addEventListener('click', () => {
        miniCart.classList.add('hidden');
    });
}
function showMiniCart() {
    miniCart.classList.remove('hidden');
}
window.showMiniCart = showMiniCart;
