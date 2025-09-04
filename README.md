# Base Project Bloc 🚀

## 💻 Tổng quan
Project này là một template Flutter sử dụng flutter_bloc, được tổ chức theo mô hình đa module để dễ dàng mở rộng, bảo trì và tái sử dụng. Các module chính gồm: `app`, `domain`, `network`, `shared`, `tools`, và `translate`.

## 🗂️ Cấu trúc thư mục

- **app/** 📱: Chứa mã nguồn chính của ứng dụng Flutter, cấu hình, assets, và các file liên quan đến build cho Android/iOS.
- **domain/** 🧠: Định nghĩa các entity, repository, logic nghiệp vụ cốt lõi.
- **network/** 🌐: Xử lý các vấn đề liên quan đến API, HTTP, và các service mạng.
- **shared/** 🛠️: Chứa các thành phần dùng chung như tiện ích, widget, hoặc các hàm helper.
- **tools/** ⚙️: Các công cụ hỗ trợ phát triển, build, hoặc cấu hình môi trường.
- **translate/** 🌏: Quản lý đa ngôn ngữ, các file đa ngôn ngữ.

## 📖 Cách sử dụng

### Pre-install
- Nếu đã cài `melos` thì bỏ qua
- Install melos:
```sh
dart pub global activate melos
```

### 1. Cài đặt dependencies
- Chạy lệnh sau ở root để cài đặt tất cả các package:
```sh
flutter pub get
make sync
```
- Sửa file root/env_config.yaml tương ứng với app sẽ có bao nhiêu flavor (app_name, bundle_id, variables)

### 2. Chạy `tools` generate flavor tương ứng
- Trước khi chạy tools, ta sẽ cần update hoặc tạo file mới cho flavor để có thể gen icon tương ứng.
Ví dụ: app có 3 flavor dev, staging, prod thì sẽ cần 3 file tương ứng: 

```sh
app/flutter_launcher_icons-dev.yaml
app/flutter_launcher_icons-staging.yaml
app/flutter_launcher_icons-prod.yaml
```

Sau khi có đủ file flutter_launcher_icons, ta chạy lệnh để generate icon app (Khi nào muốn thay đổi icon app thì làm các bước này)
```sh
make update_app_icon
```

- Sau đó chạy lệnh để generate flavor
```sh
make gen_env
```

### 3. Thêm module mới
- Tạo thư mục mới ở cấp cao nhất (ví dụ: `root/analytics/`).
- Thêm file `pubspec.yaml` và cấu trúc thư mục chuẩn.
- Thêm module vào workspace trong `melos.yaml` nếu có.

## 🚧 Cấu trúc thư mục

```bash
base_project_bloc/
├── app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── app.dart
│   │   ├── blocs/
│   │   ├── components/
│   │   ├── config/
│   │   ├── di/
│   │   ├── features/
│   │   ├── navigation/
│   │   └── theme/
│   ├── assets/
│   ├── android/
│   ├── ios/
│   ├── pubspec.yaml
├── domain/
├── network/
├── shared/
├── tools/
├── translate/
├── env_config.yaml
├── makefile
├── pubspec.yaml
└── README.md
```

## 📚 Tài liệu tham khảo
- [Melos](https://melos.dev/): Quản lý multi-package cho Dart/Flutter.
- [Bloc](https://bloclibrary.dev/): Kiến trúc quản lý state cho Flutter.

## 💬 Liên hệ
Nếu có vấn đề hoặc cần hỗ trợ, vui lòng liên hệ [profile](https://github.com/sonphamtrung17)
