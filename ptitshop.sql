DROP DATABASE IF EXISTS ptitshop;
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
('Áo thun Classic','tshirt',150000,'Áo thun cotton 100% với logo thêu tinh tế. Chất liệu mềm mại, thoáng mát.','S,M,L,XL,XXL','assets/img/ptit-tshirt-basic.jpg',50),
('Áo khoác Sport','jacket',450000,'Áo khoác thể thao chống gió, chống nước nhẹ. Phù hợp cho các hoạt động ngoài trời.','S,M,L,XL,XXL','assets/img/ptit-hoodie-black.jpg',35),
('Áo thun Polo','tshirt',200000,'Áo polo lịch sự với chất liệu pique cotton. Phù hợp cho môi trường học tập và làm việc.','S,M,L,XL,XXL','assets/img/ptit-polo-white.jpg',60),
('Áo thun Phối Màu','tshirt',220000,'Áo thun cotton phối màu colorblock độc đáo, phong cách hiện đại.','S,M,L,XL,XXL','assets/img/ptit-sweater-colorblock.webp',50),
('Túi xách Tote','accessories',150000,'Túi tote canvas bền đẹp với logo in silk. Phù hợp cho việc đi học và đi chơi.','OneSize','assets/img/ptit-tote-bag-white.jpg',60),
('Quần Jeans Nam Cổ Điển','accessories',350000,'Quần jeans nam màu xanh đậm, form đứng cổ điển. Chất liệu denim co giãn nhẹ, thoải mái.','28,29,30,31,32,33,34','assets/img/ptit-jeans-dark.jpg',55),
('Áo khoác Bomber','jacket',500000,'Áo khoác bomber phong cách streetwear. Chất liệu cao cấp, form dáng hiện đại.','S,M,L,XL,XXL','assets/img/ptit-jacket-baseball.png',40),
('Mũ Cap','accessories',120000,'Mũ lưỡi trai với logo thêu nổi. Chất liệu cotton thoáng mát, có thể điều chỉnh size.','OneSize','assets/img/ptit-cap-beige.png',80),
('Áo thun Vintage','tshirt',180000,'Áo thun phong cách vintage với logo cổ điển. Chất liệu cotton pha tạo cảm giác mềm mại.','S,M,L,XL,XXL','assets/img/ptit-tshirt-couple.jpg',50),
('Balo Tech','accessories',280000,'Balo laptop chống nước với nhiều ngăn tiện ích. Thiết kế ergonomic, phù hợp cho sinh viên.','OneSize','assets/img/ptit-tech-backpack-2.jpg',70),
('Hoodie Oversized','hoodie',420000,'Hoodie form oversized trendy. Chất liệu nỉ cao cấp, thiết kế unisex phù hợp mọi giới tính.','S,M,L,XL,XXL','assets/img/ptit-hoodie-unisex.jpg',45),
('Áo khoác Denim','jacket',380000,'Áo khoác jeans với logo thêu tay. Phong cách casual, dễ phối đồ.','S,M,L,XL,XXL','assets/img/ptit-jacket-denim.webp',40),
('Set Hoodie và Denim Jacket','hoodie',750000,'Set phối sẵn bao gồm Hoodie và Áo khoác Denim, phong cách đường phố năng động.','S,M,L,XL,XXL','assets/img/ptit-hoodie-denim-combo.jpg',25),
('Áo khoác UV có mũ','jacket',420000,'Áo khoác chống nắng mỏng có mũ, chất liệu thun lạnh thoáng mát. Phong cách thể thao, phù hợp dùng hằng ngày và hoạt động ngoài trời.','S,M,L,XL,XXL','assets/img/ptit-uv-hoodie.png',30),
('Hoodie Kem','hoodie',390000,'Hoodie màu kem sang trọng, chất liệu nỉ bông cao cấp, form dáng rộng rãi, thoải mái.','S,M,L,XL,XXL','assets/img/ptit-hoodie-cream.jpg',40),
('Hoodie Xanh Navy','hoodie',370000,'Hoodie màu xanh navy đậm, thiết kế basic với chữ in nổi bật. Phong cách trẻ trung, dễ phối đồ.','S,M,L,XL,XXL','assets/img/ptit-hoodie-blue.jpg',45),
('Áo khoác Zip Đỏ','jacket',480000,'Áo khoác có khóa kéo màu đỏ nổi bật, chất liệu nỉ dày dặn, có mũ. Phù hợp cho cả nam và nữ.','S,M,L,XL,XXL','assets/img/ptit-jacket-red-zip.png',35),
('Hoodie Zip','hoodie',380000,'Hoodie có khóa kéo tiện lợi, dễ dàng mặc và tháo. Thiết kế trẻ trung, năng động.','S,M,L,XL,XXL','assets/img/ptit-hoodie-zip-blue.jpg',45);


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

