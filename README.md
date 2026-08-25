# PTIT SHOP (PTIT.STYLE)

Hệ thống Website Thương mại điện tử & Quản lý bán hàng thời trang/merchandise dành cho sinh viên PTIT, xây dựng trên nền tảng **Java Web (Servlet/JSP + JDBC)** và cơ sở dữ liệu **MySQL**.

---

## 📦 1. Cơ Sở Dữ Liệu

- 🗄️ File script database: [`ptitshop.sql`](ptitshop.sql) (tại thư mục gốc).
- Chứa toàn bộ cấu trúc bảng (`categories`, `products`, `orders`, `order_items`) và dữ liệu mẫu.

---

## 🛠️ 2. Yêu Cầu Môi Trường

- **JDK:** Java OpenJDK 17 trở lên.
- **Web Server:** [Apache Tomcat 10.1.x+](https://tomcat.apache.org/download-10.cgi) (Jakarta EE 10 / Servlet 6.0).
- **Database:** MySQL Server 8.0+.
- **Build Tool:** Apache Maven 3.8+.
- **IDE:** IntelliJ IDEA, Eclipse hoặc VS Code.

---

## 🚀 3. Hướng Dẫn Cài Đặt & Khởi Chạy

### Bước 1: Khởi tạo Database MySQL
Import file [`ptitshop.sql`](ptitshop.sql) vào MySQL để tạo database `ptitshop` cùng dữ liệu mẫu.

### Bước 2: Cấu hình kết nối MySQL trong mã nguồn
Chỉnh sửa tài khoản/mật khẩu MySQL (nếu khác `root`/`123456`) trong:
- [`ProductDAO.java`](ptitshop_web/src/main/java/com/ptit/shop/dao/ProductDAO.java)
- [`OrderDAO.java`](ptitshop_web/src/main/java/com/ptit/shop/dao/OrderDAO.java)

```java
private static final String URL  = "jdbc:mysql://localhost:3306/ptitshop?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
private static final String USER = "root";
private static final String PASS = "123456";
```

### Bước 3: Chạy trên IntelliJ IDEA
1. Mở dự án bằng IntelliJ IDEA.
2. Cấu hình **Tomcat Server** (Local) với Tomcat 10.1.x+.
3. Tại tab **Deployment**, chọn Artifact `ptitshop_web:war exploded` và đặt **Application context** là `/ptitshop_web` (hoặc `/`).
4. Nhấn **Run** để khởi chạy server.

*(Tùy chọn: Chạy `mvn clean package` trong thư mục `ptitshop_web` để xuất file `.war` deploy độc lập).*

---

## 🌐 4. Đường Dẫn Truy Cập

| Trang chức năng | Đường dẫn URL | Mô tả |
| :--- | :--- | :--- |
| 🏠 **Trang chủ** | [http://localhost:8080/ptitshop_web/home](http://localhost:8080/ptitshop_web/home) | Sản phẩm mới & sản phẩm bán chạy |
| 🛍️ **Cửa hàng / Sản phẩm** | [http://localhost:8080/ptitshop_web/products](http://localhost:8080/ptitshop_web/products) | Danh mục, tìm kiếm, bộ lọc & phân trang |
| 🛒 **Giỏ hàng & Đặt hàng** | [http://localhost:8080/ptitshop_web/cart.jsp](http://localhost:8080/ptitshop_web/cart.jsp) | Giỏ hàng, nhập thông tin và đặt hàng |
| 📦 **Tra cứu đơn hàng** | [http://localhost:8080/ptitshop_web/order-history.jsp](http://localhost:8080/ptitshop_web/order-history.jsp) | Tra cứu tình trạng đơn qua mã đơn |
| ⚙️ **Quản trị Admin** | [http://localhost:8080/ptitshop_web/admin.jsp](http://localhost:8080/ptitshop_web/admin.jsp) | Quản lý sản phẩm, đơn hàng & thống kê doanh thu |

---

<p align="center">
  <b>PTIT Java Project - Nhóm 16.17</b>
</p>
