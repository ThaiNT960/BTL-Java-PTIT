CREATE DATABASE IF NOT EXISTS ptitshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ptitshop;

-- 1. Bảng danh mục

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL
);

INSERT INTO categories (slug, name) VALUES
('tshirt', 'Áo thun'),
('hoodie', 'Hoodie'),
('jacket', 'Áo khoác'),
('accessories', 'Phụ kiện');

-- 2. Bảng sản phẩm

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    description TEXT,
    sizes VARCHAR(100),
    image VARCHAR(255),
    stock INT NOT NULL DEFAULT 20,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (name, category, price, description, sizes, image, stock) VALUES
('Áo thun PTIT Classic','tshirt',150000,'Áo thun cotton 100% với logo PTIT thêu tinh tế. Chất liệu mềm mại, thoáng mát.','S,M,L,XL,XXL','assets/img/ptit-tshirt-basic.jpg',50),
('Hoodie PTIT Premium','hoodie',350000,'Hoodie cao cấp với chất liệu nỉ dày dặn, giữ ấm tốt. Thiết kế hiện đại với logo PTIT nổi bật.','S,M,L,XL,XXL','assets/img/ptit-hoodie-black.jpg',40),
('Áo khoác PTIT Sport','jacket',450000,'Áo khoác thể thao chống gió, chống nước nhẹ. Phù hợp cho các hoạt động ngoài trời.','S,M,L,XL,XXL','assets/img/ptit-hoodie-black.jpg',35),
('Áo thun PTIT Polo','tshirt',200000,'Áo polo lịch sự với chất liệu pique cotton. Phù hợp cho môi trường học tập và làm việc.','S,M,L,XL,XXL','assets/img/ptit-polo-white.jpg',60),
('Hoodie PTIT Zip','hoodie',380000,'Hoodie có khóa kéo tiện lợi, dễ dàng mặc và tháo. Thiết kế trẻ trung, năng động.','S,M,L,XL,XXL','assets/img/ptit-hoodie-black.jpg',45),
('Áo khoác PTIT Bomber','jacket',500000,'Áo khoác bomber phong cách streetwear. Chất liệu cao cấp, form dáng hiện đại.','S,M,L,XL,XXL','assets/img/ptit-jacket-baseball.png',40),
('Balo PTIT Tech','accessories',280000,'Balo laptop chống nước với nhiều ngăn tiện ích. Thiết kế ergonomic, phù hợp cho sinh viên IT.','OneSize','assets/img/ptit-jacket-baseball.png',70),
('Mũ PTIT Cap','accessories',120000,'Mũ lưỡi trai với logo PTIT thêu nổi. Chất liệu cotton thoáng mát, có thể điều chỉnh size.','OneSize','assets/img/ptit-jacket-baseball.png',80),
('Áo thun PTIT Vintage','tshirt',180000,'Áo thun phong cách vintage với logo PTIT cổ điển. Chất liệu cotton pha tạo cảm giác mềm mại.','S,M,L,XL,XXL','assets/img/ptit-tshirt-couple.jpg',50),
('Túi xách PTIT Tote','accessories',150000,'Túi tote canvas bền đẹp với logo PTIT in silk. Phù hợp cho việc đi học và đi chơi.','OneSize','assets/img/ptit-jacket-baseball.png',60),
('Hoodie PTIT Oversized','hoodie',420000,'Hoodie form oversized trendy. Chất liệu nỉ cao cấp, thiết kế unisex phù hợp mọi giới tính.','S,M,L,XL,XXL','assets/img/ptit-hoodie-unisex.jpg',45),
('Áo khoác PTIT Denim','jacket',380000,'Áo khoác jeans với logo PTIT thêu tay. Phong cách casual, dễ phối đồ.','S,M,L,XL,XXL','assets/img/ptit-jacket-baseball.png',40);


-- 3. Bảng đơn hàng

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_code VARCHAR(50) NOT NULL UNIQUE,
    fullname VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    address VARCHAR(255),
    note TEXT,
    subtotal INT,
    discount INT DEFAULT 0,
    shipping_fee INT DEFAULT 35000,
    total INT,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 4. Bảng chi tiết đơn hàng

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NULL,
    product_name_snapshot VARCHAR(255),
    price INT,
    size VARCHAR(20),
    quantity INT DEFAULT 1,
    line_total INT,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);

