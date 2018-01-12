# Build RPM with fpm tool in docker

## Mô tả
- Tạo môi trường build rpm trên docker bằng images centos:7, cài tool fpm. Thư mục /build được mount vào để dễ thao tác.
- Thư mục này cũng được mount với container checker để có thể test ngay.

## Cài đặt và chạy

#### Yêu cầu hệ thống

- Docker latest version
- Internet (to pull docker images)

#### Cài đặt
- Chạy file start_container_rpm_builder.sh
- Bên trong container:
    ```
    cd /build/BUILD/NGINX
    ./build-nginx.sh
    ```

- Sau khi cài quá trình build thành công, file rpm sẽ được lưu vào thư mục /build/RPMS

#### Kiểm tra
- Từ bên ngoài container, chạy file start_container_rpm_checker.sh
- Bên trong container, cd vào thư mục /build/RPMS và cài đặt gói rpm vừa build.

#### Maintainer

**1. Nguyễn Đăng Kiên** 
    
- Role: **Sysadmin**
- DOB: 1989 
- Email: [kiennd@appota.com](kiennd@appota.com)


