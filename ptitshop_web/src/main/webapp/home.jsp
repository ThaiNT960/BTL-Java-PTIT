<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PTIT SHOP - Trang chủ</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

    <%@ include file="/WEB-INF/jsp/partials/head.jspf" %>

    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
            Oxygen, Ubuntu, Cantarell, sans-serif;
        }
        .product-card {
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }
        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 30px rgba(15, 23, 42, 0.12);
        }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">
<%@ include file="/WEB-INF/jsp/partials/header.jspf" %>

<main class="min-h-screen">
    <section id="default-carousel" class="relative w-full" data-carousel="slide">
        <div class="relative h-screen overflow-hidden bg-black">

            <div class="duration-700 ease-in-out" data-carousel-item="active">
                <div class="absolute inset-0 -z-10">
                    <img src="https://wallpaperaccess.com/full/9877749.jpg"
                         class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-black/30"></div>
                </div>

                <div class="max-w-7xl h-full mx-auto px-4 flex items-center">
                    <div class="p-4 bg-white/10 backdrop-blur-lg rounded-lg w-full lg:w-1/2">
                        <h2 class="text-5xl font-semibold text-white sm:text-7xl">
                            FIND CLOTHES THAT MATCHES YOUR STYLE
                        </h2>
                        <p class="mt-6 text-gray-100 text-lg sm:text-xl">
                            Our mission is to make you look good, feel great, and get noticed.
                        </p>

                        <div class="mt-8">
                            <a href="${pageContext.request.contextPath}/products"
                               class="inline-flex items-center text-white bg-red-500 hover:bg-red-700
                                      px-6 py-2.5 rounded-full text-sm font-medium">
                                Mua ngay →
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hidden duration-700 ease-in-out" data-carousel-item>
                <div class="absolute inset-0 -z-10">
                    <img src="https://images.augustman.com/wp-content/uploads/sites/4/2023/09/21172032/uniqlo-u-fallwinter-2023.jpeg"
                         class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-black/30"></div>
                </div>

                <div class="max-w-7xl h-full mx-auto px-4 flex items-center">
                    <div class="p-4 bg-white/10 backdrop-blur-lg rounded-lg w-full lg:w-1/2">
                        <h2 class="text-5xl font-semibold text-white sm:text-7xl">
                            NEW CASUAL COLLECTION
                        </h2>
                        <p class="mt-6 text-gray-100 text-lg sm:text-xl">
                            Thoải mái và phong cách cho mọi hoạt động hằng ngày.
                        </p>

                        <div class="mt-8">
                            <a href="${pageContext.request.contextPath}/products"
                               class="inline-flex items-center text-white bg-red-500 hover:bg-red-700
                                      px-6 py-2.5 rounded-full text-sm font-medium">
                                Khám phá →
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hidden duration-700 ease-in-out" data-carousel-item>
                <div class="absolute inset-0 -z-10">
                    <img src="https://shop-t1-na.gg/cdn/shop/files/logo-tee-web_2200x.jpg?v=1721257834"
                         class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-black/30"></div>
                </div>

                <div class="max-w-7xl h-full mx-auto px-4 flex items-center">
                    <div class="p-4 bg-white/10 backdrop-blur-lg rounded-lg w-full lg:w-1/2">
                        <h2 class="text-5xl font-semibold text-white sm:text-7xl">
                            DRESS FOR THE PARTY
                        </h2>
                        <p class="mt-6 text-gray-100 text-lg sm:text-xl">
                            Những bộ trang phục dự tiệc lộng lẫy và nổi bật nhất.
                        </p>

                        <div class="mt-8">
                            <a href="${pageContext.request.contextPath}/products"
                               class="inline-flex items-center text-white bg-red-500 hover:bg-red-700
                                      px-6 py-2.5 rounded-full text-sm font-medium">
                                Xem ngay →
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="py-12 bg-white border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4">

            <h2 class="text-3xl font-bold text-gray-900 text-center mb-10">
                SẢN PHẨM MỚI
            </h2>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">

                <c:if test="${empty newProducts}">
                    <div class="col-span-full text-center text-gray-500 py-5">
                        Chưa có sản phẩm mới.
                    </div>
                </c:if>

                <c:forEach var="p" items="${newProducts}">
                    <div class="product-card bg-white rounded-xl border overflow-hidden">
                        <a href="${pageContext.request.contextPath}/products?productId=${p.id}">
                            <div class="aspect-[3/4] bg-gray-100 overflow-hidden">
                                <img src="${pageContext.request.contextPath}/${p.image}"
                                     class="w-full h-full object-cover">
                            </div>
                            <div class="p-4">
                                <p class="text-xs text-gray-400 uppercase">${p.category}</p>
                                <p class="text-base font-semibold mt-1">${p.name}</p>
                                <p class="text-lg font-bold text-red-600 mt-2">
                                    <fmt:formatNumber value="${p.price}" type="number"/> đ
                                </p>
                            </div>
                        </a>
                    </div>
                </c:forEach>

            </div>
        </div>
    </section>

    <section class="py-12 bg-gray-50">
        <div class="max-w-7xl mx-auto px-4">

            <h2 class="text-3xl font-bold text-gray-900 text-center mb-10">
                BÁN CHẠY NHẤT
            </h2>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">

                <c:if test="${empty bestSellers}">
                    <div class="col-span-full text-center text-gray-500 py-5">
                        Chưa có sản phẩm bán chạy.
                    </div>
                </c:if>

                <c:forEach var="p" items="${bestSellers}">
                    <div class="product-card bg-white rounded-xl border overflow-hidden">
                        <a href="${pageContext.request.contextPath}/products?productId=${p.id}">
                            <div class="relative aspect-[3/4] bg-gray-100 overflow-hidden">
                                <img src="${pageContext.request.contextPath}/${p.image}"
                                     class="w-full h-full object-cover"/>
                                <span class="absolute top-3 left-3 bg-yellow-300 px-3 py-0.5
                                             rounded-full text-xs font-semibold text-yellow-900">
                                    🔥 Bán chạy
                                </span>
                            </div>

                            <div class="p-4">
                                <p class="text-xs text-gray-400 uppercase">${p.category}</p>
                                <p class="text-base font-semibold mt-1">${p.name}</p>
                                <p class="text-lg font-bold text-red-600 mt-2">
                                    <fmt:formatNumber value="${p.price}" type="number"/> đ
                                </p>
                            </div>
                        </a>
                    </div>
                </c:forEach>

            </div>
        </div>
    </section>


    <section
            class="bg-gray-100 py-20 sm:py-28 rounded-3xl border-8 border-white mx-4 sm:mx-8 lg:mx-16 mb-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center">
                <h2 class="text-4xl font-serif font-bold tracking-tight text-gray-900 sm:text-5xl">
                    DỰA VÀO PHONG CÁCH ĂN MẶC
                </h2>
            </div>

            <div class="mt-16 grid grid-cols-1 sm:grid-cols-2 gap-8">

                <a href="products"
                   class="group relative block w-full aspect-[4/3] rounded-2xl overflow-hidden shadow-lg">
                    <img src="https://th.bing.com/th/id/R.3b2f0d65a2313fac9f8b2c0538ecd992?rik=v82xb8LgYoBb%2fA&pid=ImgRaw&r=0"
                         alt="Man in a casual t-shirt"
                         class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
                    <h3 class="absolute top-6 left-6 text-3xl font-semibold text-white text-shadow-lg">
                        Casual</h3>
                </a>

                <a href="products"
                   class="group relative block w-full aspect-[4/3] rounded-2xl overflow-hidden shadow-lg">
                    <img src="https://2.bp.blogspot.com/-D2EQZDJFMMI/Tk_4SdBqcHI/AAAAAAAAIrI/w_xpQQp2ZXI/s1600/11_dg_crop.jpg"
                         alt="Man in a formal suit"
                         class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
                    <h3 class="absolute top-6 left-6 text-3xl font-semibold text-white text-shadow-lg">
                        Formal</h3>
                </a>

                <a href="products"
                   class="group relative block w-full aspect-[4/3] rounded-2xl overflow-hidden shadow-lg sm:aspect-auto sm:row-span-2">
                    <img src="https://th.bing.com/th/id/R.3b2f0d65a2313fac9f8b2c0538ecd992?rik=v82xb8LgYoBb%2fA&pid=ImgRaw&r=0"
                         alt="Woman in a party outfit"
                         class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
                    <h3 class="absolute top-6 left-6 text-3xl font-semibold text-white text-shadow-lg">Party
                    </h3>
                </a>

                <a href="products"
                   class="group relative block w-full aspect-[4/3] rounded-2xl overflow-hidden shadow-lg">
                    <img src="https://th.bing.com/th/id/R.3b2f0d65a2313fac9f8b2c0538ecd992?rik=v82xb8LgYoBb%2fA&pid=ImgRaw&r=0"
                         alt="Man in gym wear"
                         class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
                    <h3 class="absolute top-6 left-6 text-3xl font-semibold text-white text-shadow-lg">Gym
                    </h3>
                </a>

            </div>
        </div>
    </section>


    <section class="py-16 px-6 bg-gray-50">
        <div class="max-w-6xl mx-auto">
            <h2 class="text-4xl font-bold text-center mb-12">KHÁCH HÀNG HÀI LÒNG</h2>
            <div class="grid grid-cols-3 gap-6">
                <div class="bg-white p-6 rounded-lg">
                    <div class="star-rating mb-2">★★★★★</div>
                    <p class="font-semibold mb-2">Samantha D.</p>
                    <p class="text-gray-600 text-sm mb-4">"Tôi hoàn toàn thích chiếc áo thun này! Thiết kế
                        độc đáo và chất liệu cảm thấy tuyệt vời. Tôi đã nhận được rất nhiều lời khen về nó.
                        Nó đã trở thành chiếc áo thun yêu thích của tôi!"</p>
                    <p class="text-gray-500 text-xs">Đăng ngày 14 tháng 8 năm 2025</p>
                </div>
                <div class="bg-white p-6 rounded-lg">
                    <div class="star-rating mb-2">★★★★</div>
                    <p class="font-semibold mb-2">Alex M.</p>
                    <p class="text-gray-600 text-sm mb-4">"Chiếc áo thun vượt quá kỳ vọng của tôi! Các màu
                        sắc trông tuyệt vời và bản in rất sắc nét. Tôi cảm thấy rất tự tin khi mặc nó."</p>
                    <p class="text-gray-500 text-xs">Đăng ngày 15 tháng 8 năm 2025</p>
                </div>
                <div class="bg-white p-6 rounded-lg">
                    <div class="star-rating mb-2">★★★★★</div>
                    <p class="font-semibold mb-2">Ethan R.</p>
                    <p class="text-gray-600 text-sm mb-4">"Đây là một chiếc áo thun tuyệt vời dành cho bất
                        kỳ ai đánh giá cao thiết kế tốt. Mô hình rất phong cách và tôi yêu cách nó vừa vặn."
                    </p>
                    <p class="text-gray-500 text-xs">Đăng ngày 16 tháng 8 năm 2025</p>
                </div>
            </div>
        </div>
    </section>


    <section class="bg-black text-white py-16 px-6 rounded-2xl mx-6 mb-16">
        <div class="max-w-6xl mx-auto text-center">
            <h2 class="text-4xl font-bold mb-8">CẬP NHẬT THÔNG TIN VỀ<br>CÁC ƯU ĐÃI MỚI NHẤT CỦA CHÚNG
                TÔI</h2>
            <div class="flex gap-4 justify-center">
                <input type="email" placeholder="Nhập địa chỉ email của bạn"
                       class="px-6 py-3 rounded-full text-black w-80">
                <button
                        class="bg-white text-black px-8 py-3 rounded-full font-semibold hover:bg-gray-100">Đăng
                    ký nhận bản
                    tin
                </button>
            </div>
        </div>
    </section>

</main>

<jsp:include page="/WEB-INF/jsp/partials/footer.jspf" />

<!-- JS Carousel FLOWBITE-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>

<!-- JS khác -->
<script src="assets/js/mini_cart.js"></script>
<script src="assets/js/app.js"></script>
<script src="assets/js/product.js"></script>

</body>
</html>
