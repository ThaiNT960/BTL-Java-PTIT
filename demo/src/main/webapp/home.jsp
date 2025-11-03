<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PTIT SHOP - Cửa hàng quần áo trực tuyến</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <%@ include file="/WEB-INF/jsp/partials/head.jspf" %>
    <style>
        .aspect-h-4 {
            --tw-aspect-h: 4;
        }

        .aspect-w-3 {
            position: relative;
            padding-bottom: calc(var(--tw-aspect-h) / var(--tw-aspect-w) * 100%);
            --tw-aspect-w: 3;
        }

        .aspect-w-3>* {
            position: absolute;
            height: 100%;
            width: 100%;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
        }

        @keyframes wiggle-more {

            0%,
            100% {
                transform: rotate(-3deg);
            }

            50% {
                transform: rotate(3deg);
            }
        }

        .animate-wiggle-more {
            animation: wiggle-more 1s ease-in-out infinite;
        }
    </style>
</head>

<body class="font-sans bg-white text-black">
<%@ include file="/WEB-INF/jsp/partials/header.jspf" %>
<main>
    <section id="default-carousel" class="relative w-full" data-carousel="slide">

        <div class="relative h-screen overflow-hidden">

            <div class="hidden duration-700 ease-in-out" data-carousel-item>
                <div class="absolute inset-0 -z-10">
                    <img src="https://wallpaperaccess.com/full/9877749.jpg"
                         class="w-full h-full object-cover" alt="Slide 1 Background">
                    <div class="absolute inset-0 bg-black/30"></div>
                </div>

                <div class="max-w-7xl h-full mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-start">
                    <div class="p-4 rounded-lg bg-white/10 backdrop-blur-lg w-full lg:w-1/2">
                        <div class="mx-auto max-w-6xl lg:mx-0">
                            <h2
                                    class="text-5xl font-semibold tracking-tight text-white sm:text-7xl text-shadow-lg">
                                FIND CLOTHES THAT MATCHES YOUR STYLE
                            </h2>
                            <p
                                    class="mt-8 text-lg font-small text-pretty text-gray-100 sm:text-xl/8 text-shadow-lg">
                                Our mission is to make you look good, feel great, and get noticed. Explore
                                our
                                collection of
                                trendy and stylish clothing.
                            </p>
                        </div>
                        <div class="mx-auto mt-10 max-w-2xl lg:mx-0 lg:max-w-none">
                            <div
                                    class="inline-flex text-white bg-red-400 hover:bg-red-800 focus:outline-none focus:ring-4 focus:ring-red-300 font-medium rounded-full text-sm px-5 py-2.5 text-center me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800 animate-wiggle-more">
                                <a href="products" class="group">
                                    Mua ngay
                                    <span aria-hidden="true"
                                          class="inline-block ml-1 transition-transform duration-200 ease-in-out group-hover:translate-x-2">→</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hidden duration-700 ease-in-out" data-carousel-item>
                <div class="absolute inset-0 -z-10">
                    <img src="https://images.augustman.com/wp-content/uploads/sites/4/2023/09/21172032/uniqlo-u-fallwinter-2023.jpeg"
                         class="w-full h-full object-cover" alt="Slide 2 Background">
                    <div class="absolute inset-0 bg-black/30"></div>
                </div>

                <div class="max-w-7xl h-full mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-start">
                    <div class="p-4 rounded-lg bg-white/10 backdrop-blur-lg w-full lg:w-1/2">
                        <div class="mx-auto max-w-6xl lg:mx-0">
                            <h2
                                    class="text-5xl font-semibold tracking-tight text-white sm:text-7xl text-shadow-lg">
                                NEW CASUAL COLLECTION
                            </h2>
                            <p
                                    class="mt-8 text-lg font-small text-pretty text-gray-100 sm:text-xl/8 text-shadow-lg">
                                Thoải mái và phong cách cho mọi hoạt động hàng ngày của bạn.
                            </p>
                        </div>
                        <div class="mx-auto mt-10 max-w-2xl lg:mx-0 lg:max-w-none">
                            <div
                                    class="inline-flex text-white bg-red-400 hover:bg-red-800 focus:outline-none focus:ring-4 focus:ring-red-300 font-medium rounded-full text-sm px-5 py-2.5 text-center me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800 animate-wiggle-more">
                                <a href="products" class="group">
                                    Khám phá ngay
                                    <span aria-hidden="true"
                                          class="inline-block ml-1 transition-transform duration-200 ease-in-out group-hover:translate-x-2">→</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hidden duration-700 ease-in-out" data-carousel-item>
                <div class="absolute inset-0 -z-10">
                    <img src="https://shop-t1-na.gg/cdn/shop/files/logo-tee-web_2200x.jpg?v=1721257834"
                         class="w-full h-full object-cover" alt="Slide 3 Background">
                    <div class="absolute inset-0 bg-black/30"></div>
                </div>

                <div class="max-w-7xl h-full mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-start">
                    <div class="p-4 rounded-lg bg-white/10 backdrop-blur-lg w-full lg:w-1/2">
                        <div class="mx-auto max-w-6xl lg:mx-0">
                            <h2
                                    class="text-5xl font-semibold tracking-tight text-white sm:text-7xl text-shadow-lg">
                                DRESS FOR THE PARTY
                            </h2>
                            <p
                                    class="mt-8 text-lg font-small text-pretty text-gray-100 sm:text-xl/8 text-shadow-lg">
                                Những bộ trang phục dự tiệc lộng lẫy và nổi bật nhất đang chờ bạn.
                            </p>
                        </div>
                        <div class="mx-auto mt-10 max-w-2xl lg:mx-0 lg:max-w-none">
                            <div
                                    class="inline-flex text-white bg-red-400 hover:bg-red-800 focus:outline-none focus:ring-4 focus:ring-red-300 font-medium rounded-full text-sm px-5 py-2.5 text-center me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800 animate-wiggle-more">
                                <a href="products" class="group">
                                    Xem sản phẩm nổi bật
                                    <span aria-hidden="true"
                                          class="inline-block ml-1 transition-transform duration-200 ease-in-out group-hover:translate-x-2">→</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="absolute z-30 flex -translate-x-1/2 bottom-5 left-1/2 space-x-3 rtl:space-x-reverse">
            <button type="button" class="w-3 h-3 rounded-full" aria-current="true" aria-label="Slide 1"
                    data-carousel-slide-to="0"></button>
            <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 2"
                    data-carousel-slide-to="1"></button>
            <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 3"
                    data-carousel-slide-to="2"></button>
        </div>

        <button type="button"
                class="absolute top-0 start-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
                data-carousel-prev>
                        <span
                                class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none transition-all duration-300 ease-in-out">
                            <svg class="w-4 h-4 text-gray-800 dark:text-gray-800 rtl:rotate-180" aria-hidden="true"
                                 xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                      stroke-width="2" d="M5 1 1 5l4 4" />
                            </svg>
                            <span class="sr-only">Previous</span>
                        </span>
        </button>
        <button type="button"
                class="absolute top-0 end-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none"
                data-carousel-next>
                        <span
                                class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none transition-all duration-300 ease-in-out">
                            <svg class="w-4 h-4 text-gray-800 dark:text-gray-800 rtl:rotate-180" aria-hidden="true"
                                 xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                      stroke-width="2" d="m1 9 4-4-4-4" />
                            </svg>
                            <span class="sr-only">Next</span>
                        </span>
        </button>
    </section>
    <div class="w-full flex items-center justify-center">
        <div class="flex-grow h-px bg-gray-200"></div>

        <span class="px-4 text-gray-400">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                            <path
                                    d="M12 2l3.09 6.26L22 9.27l-5 4.87L18.18 22 12 18.77 5.82 22 7 14.14 2 9.27l6.91-1.01L12 2z">
                            </path>
                        </svg>
                    </span>

        <div class="flex-grow h-px bg-gray-200"></div>
    </div>
    <section aria-labelledby="new-arrivals-heading" class="py-10 sm:py-14">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 id="new-arrivals-heading"
                    class="text-4xl font-serif font-bold tracking-tight text-gray-900 sm:text-5xl">SẢN PHẨM
                    MỚI</h2>
            </div>
            <div id="new-arrivals-grid"
                 class="grid grid-cols-1 gap-y-12 gap-x-8 sm:grid-cols-2 lg:grid-cols-4">
                <div class="group relative"> <a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://shop-t1-na.gg/cdn/shop/files/2024-T1-Worlds-Uniform-Jersey-Front.jpg?v=1727393754"
                             alt="Beige trench coat on a hanger."
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">

                        <div class="absolute inset-0 flex items-center justify-center
                                        bg-black/20
                                        opacity-0 group-hover:opacity-100
                                        transition-all duration-300">

                            <button class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                               transform translate-y-4 group-hover:translate-y-0
                                               transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$200</p>
                    </div>
                </a>
                </div>
                <div class="group relative"><a href="products">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://shop-t1-na.gg/cdn/shop/files/LoL_-2025-T1-Uniform-Jacket_Front.jpg?v=1738018530"
                             alt="Woman in a green knitted sweater."
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div class="absolute inset-0 flex items-center justify-center
                                                                            bg-black/20
                                                                            opacity-0 group-hover:opacity-100
                                                                            transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                   transform translate-y-4 group-hover:translate-y-0
                                                                                   transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Green Comfy Knit Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$120</p>
                    </div>
                </a></div>
                <div class="bg-orange-100 rounded-lg p-6 flex flex-col justify-between">
                    <div>
                        <h3 class="text-2xl font-semibold text-gray-900">Khám phá bộ sưu tập thường ngày
                        </h3><a href="products"
                                class="mt-2 inline-block font-medium text-orange-600 hover:text-orange-800 animate-wiggle-more">Mua
                        ngay
                        &rarr;</a>
                    </div>
                    <div class="mt-4"><img
                            src="https://shop-t1-na.gg/cdn/shop/files/2024-T1-Worlds-Uniform-Jersey-Front.jpg?v=1727393754"
                            alt="Stylish man in casual wear." class="w-full h-48 object-cover rounded-md">
                    </div>
                </div>
                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://shop-t1-na.gg/cdn/shop/files/2024-T1-Worlds-Uniform-Jersey-Front.jpg?v=1727393754"
                             alt="Woman wearing a stylish headscarf."
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Down Collection</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$45</p>

                    </div>
                </a></div>
            </div>
            <div class="mt-16 text-center">
                <a href="#"
                   class="inline-flex text-white bg-red-400 hover:bg-red-800 focus:outline-none focus:ring-4 focus:ring-red-300 font-medium rounded-full text-sm px-5 py-2.5 text-center me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800">
                    Xem tất cả <span aria-hidden="true">&rarr;</span>
                </a>
            </div>
        </div>
    </section>
    <section aria-labelledby="new-arrivals-heading" class="py-10 sm:py-14">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="text-center mb-16">
                <h2 id="new-arrivals-heading"
                    class="text-4xl font-serif font-bold tracking-tight text-gray-900 sm:text-5xl">Bán chạy
                    nhất</h2>
            </div>

            <div class="grid grid-cols-1 gap-y-12 gap-x-8 sm:grid-cols-2 lg:grid-cols-4">
                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/463426/item/goods_01_463426.jpg?width=750"
                             alt="Sweater"
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div
                                class="absolute inset-0 flex items-center justify-center
                                                                                                                bg-black/20
                                                                                                                opacity-0 group-hover:opacity-100
                                                                                                                transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                                                       transform translate-y-4 group-hover:translate-y-0
                                                                                                                       transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$200</p>
                        <!-- Rating -->
                        <div class="flex items-center">
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                        </div>
                        <!-- End Rating -->
                    </div>
                </a></div>

                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://image.uniqlo.com/UQ/ST3/WesternCommon/imagesgoods/449860/item/goods_10_449860.jpg?width=750"
                             alt="Green Comfy Knit Sweater"
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div
                                class="absolute inset-0 flex items-center justify-center
                                                                                                                bg-black/20
                                                                                                                opacity-0 group-hover:opacity-100
                                                                                                                transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                                                       transform translate-y-4 group-hover:translate-y-0
                                                                                                                       transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Green Comfy Knit Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$120</p>
                        <!-- Rating -->
                        <div class="flex items-center">
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                        </div>
                        <!-- End Rating -->
                    </div>
                </a></div>

                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/463426/item/goods_01_463426.jpg?width=750"
                             alt="Another sweater"
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div
                                class="absolute inset-0 flex items-center justify-center
                                                                                                                bg-black/20
                                                                                                                opacity-0 group-hover:opacity-100
                                                                                                                transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                                                       transform translate-y-4 group-hover:translate-y-0
                                                                                                                       transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Another Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$150</p>
                        <!-- Rating -->
                        <div class="flex items-center">
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                        </div>
                        <!-- End Rating -->
                    </div>
                </a></div>

                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://image.uniqlo.com/UQ/ST3/WesternCommon/imagesgoods/449860/item/goods_10_449860.jpg?width=750"
                             alt="Another green sweater"
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div
                                class="absolute inset-0 flex items-center justify-center
                                                                                                                bg-black/20
                                                                                                                opacity-0 group-hover:opacity-100
                                                                                                                transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                                                       transform translate-y-4 group-hover:translate-y-0
                                                                                                                       transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Another Green Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$180</p>
                        <!-- Rating -->
                        <div class="flex items-center">
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                        </div>
                        <!-- End Rating -->
                    </div>
                </a></div>
                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/463426/item/goods_01_463426.jpg?width=750"
                             alt="Another sweater"
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div
                                class="absolute inset-0 flex items-center justify-center
                                                                                                                bg-black/20
                                                                                                                opacity-0 group-hover:opacity-100
                                                                                                                transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                                                       transform translate-y-4 group-hover:translate-y-0
                                                                                                                       transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Another Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$150</p>
                        <!-- Rating -->
                        <div class="flex items-center">
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                        </div>
                        <!-- End Rating -->
                    </div>
                </a></div>
                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/463426/item/goods_01_463426.jpg?width=750"
                             alt="Another sweater"
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div
                                class="absolute inset-0 flex items-center justify-center
                                                                                                                bg-black/20
                                                                                                                opacity-0 group-hover:opacity-100
                                                                                                                transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                                                       transform translate-y-4 group-hover:translate-y-0
                                                                                                                       transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Another Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$150</p>
                        <!-- Rating -->
                        <div class="flex items-center">
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                        </div>
                        <!-- End Rating -->
                    </div>
                </a></div>
                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/463426/item/goods_01_463426.jpg?width=750"
                             alt="Another sweater"
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div
                                class="absolute inset-0 flex items-center justify-center
                                                                                                                bg-black/20
                                                                                                                opacity-0 group-hover:opacity-100
                                                                                                                transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                                                       transform translate-y-4 group-hover:translate-y-0
                                                                                                                       transition-transform duration-300 ease-in-out">
                                Xem nhanh
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Another Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$150</p>
                        <!-- Rating -->
                        <div class="flex items-center">
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                        </div>
                        <!-- End Rating -->
                    </div>
                </a></div>
                <div class="group"><a href="#">
                    <div class="w-full aspect-w-3 aspect-h-4 overflow-hidden rounded-lg bg-gray-100">
                        <img src="https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/463426/item/goods_01_463426.jpg?width=750"
                             alt="Another sweater"
                             class="w-full h-full object-cover object-center transition-transform duration-300 group-hover:scale-105">
                        <div
                                class="absolute inset-0 flex items-center justify-center
                                                                                                                bg-black/20
                                                                                                                opacity-0 group-hover:opacity-100
                                                                                                                transition-all duration-300">

                            <button
                                    class="bg-white text-black text-sm font-medium py-2 px-5 rounded-full
                                                                                                                       transform translate-y-4 group-hover:translate-y-0
                                                                                                                       transition-transform duration-300 ease-in-out">
                                Quick View
                            </button>
                        </div>
                    </div>
                    <div class="mt-4">
                        <h3 class="text-base font-medium text-gray-900">Another Sweater</h3>
                        <p class="mt-1 text-lg font-semibold text-gray-700">$150</p>
                        <!-- Rating -->
                        <div class="flex items-center">
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-yellow-400 dark:text-yellow-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                            <svg class="shrink-0 size-5 text-gray-300 dark:text-neutral-600"
                                 xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" viewBox="0 0 16 16">
                                <path
                                        d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z">
                                </path>
                            </svg>
                        </div>
                        <!-- End Rating -->
                    </div>
                </a></div>

            </div>

            <div class="mt-16 text-center">
                <a href="products"
                   class="inline-flex text-white bg-red-400 hover:bg-red-800 focus:outline-none focus:ring-4 focus:ring-red-300 font-medium rounded-full text-sm px-5 py-2.5 text-center me-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800">
                    Xem tất cả <span aria-hidden="true">&rarr;</span>
                </a>
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
                    <p class="text-gray-500 text-xs">Đăng ngày 14 tháng 8 năm 2023</p>
                </div>
                <div class="bg-white p-6 rounded-lg">
                    <div class="star-rating mb-2">★★★★</div>
                    <p class="font-semibold mb-2">Alex M.</p>
                    <p class="text-gray-600 text-sm mb-4">"Chiếc áo thun vượt quá kỳ vọng của tôi! Các màu
                        sắc trông tuyệt vời và bản in rất sắc nét. Tôi cảm thấy rất tự tin khi mặc nó."</p>
                    <p class="text-gray-500 text-xs">Đăng ngày 15 tháng 8 năm 2023</p>
                </div>
                <div class="bg-white p-6 rounded-lg">
                    <div class="star-rating mb-2">★★★★★</div>
                    <p class="font-semibold mb-2">Ethan R.</p>
                    <p class="text-gray-600 text-sm mb-4">"Đây là một chiếc áo thun tuyệt vời dành cho bất
                        kỳ ai đánh giá cao thiết kế tốt. Mô hình rất phong cách và tôi yêu cách nó vừa vặn."
                    </p>
                    <p class="text-gray-500 text-xs">Đăng ngày 16 tháng 8 năm 2023</p>
                </div>
            </div>
        </div>
    </section>


    <section class="bg-black text-white py-16 px-6 rounded-2xl mx-6 mb-16">
        <div class="max-w-6xl mx-auto text-center">
            <h2 class="text-4xl font-bold mb-8">CẬP NHẬT THÔNG TIN VỀ<br>CÁC ƯU ĐÃI MỚI NHẤT CỦA CHÚNG TÔI
            </h2>
            <div class="flex gap-4 justify-center">
                <input type="email" placeholder="Nhập địa chỉ email của bạn"
                       class="px-6 py-3 rounded-full text-black w-80">
                <button
                        class="bg-white text-black px-8 py-3 rounded-full font-semibold hover:bg-gray-100">Đăng
                    ký nhận bản tin</button>
            </div>
        </div>
    </section>


    <jsp:include page="/WEB-INF/jsp/partials/footer.jspf" />

</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
</body>

</html>