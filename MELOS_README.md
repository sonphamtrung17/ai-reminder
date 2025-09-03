# Melos Scripts Guide - Base Project Bloc

Dự án này sử dụng **Melos** để quản lý monorepo với nhiều package Flutter. Dưới đây là hướng dẫn sử dụng các script có sẵn.

## 🚀 Cài đặt Melos

```bash
# Cài đặt Melos globally
dart pub global activate melos

# Hoặc sử dụng Flutter
flutter pub global activate melos
```

## 📦 Package Management

### Cài đặt dependencies
```bash
# Cài đặt dependencies cho tất cả packages
melos run pub_get

# Nâng cấp dependencies
melos run pub_upgrade

# Kiểm tra dependencies cũ
melos run pub_outdated
```

## 🔧 Code Generation

### Build Runner
```bash
# Generate code một lần
melos run build_runner

# Generate code trong watch mode (tự động khi có thay đổi)
melos run build_runner_watch

# Clean build outputs
melos run build_runner_clean
```

## 🎯 Code Quality

### Phân tích code
```bash
# Chạy Flutter analyzer
melos run analyze

# Format code
melos run format

# Kiểm tra format (không thay đổi)
melos run format_check
```

## 🧪 Testing

### Chạy tests
```bash
# Chạy tất cả tests
melos run test

# Chạy tests với coverage
melos run test_coverage
```

## 🧹 Development Workflow

### Clean project
```bash
# Clean build artifacts
melos run clean

# Deep clean (xóa tất cả build files và lock files)
melos run clean_all
```

## 🎨 Flutter Launcher Icons

### Generate app icons
```bash
# Development environment
melos run generate_icons_dev

# Staging environment
melos run generate_icons_staging

# Production environment
melos run generate_icons_prod
```

## 🔄 Combined Workflows

### Setup project
```bash
# Setup hoàn chỉnh: pub get + code generation
melos run setup
```

### Pre-commit checks
```bash
# Chạy tất cả checks trước khi commit
melos run pre_commit
```

### Validate project
```bash
# Validate toàn bộ project
melos run validate
```

## 📋 Danh sách tất cả scripts

```bash
# Xem tất cả scripts có sẵn
melos run --help

# Xem chi tiết một script cụ thể
melos run <script_name> --help
```

## 🏗️ Cấu trúc Project

```
base-project-bloc/
├── lib/                    # Main app
├── shared/                 # Shared utilities
├── network/                # Network services
├── translate/              # Internationalization
├── tools/                  # Development tools
├── melos.yaml             # Melos configuration
└── pubspec.yaml           # Main dependencies
```

## ⚡ Scripts thường dùng

### Development workflow
```bash
# 1. Setup project
melos run setup

# 2. Development với watch mode
melos run build_runner_watch

# 3. Pre-commit validation
melos run pre_commit
```

### CI/CD workflow
```bash
# 1. Install dependencies
melos run pub_get

# 2. Generate code
melos run build_runner

# 3. Validate code
melos run validate

# 4. Run tests
melos run test
```

## 🔍 Troubleshooting

### Nếu gặp lỗi với build_runner
```bash
# Clean và regenerate
melos run build_runner_clean
melos run build_runner
```

### Nếu có vấn đề với dependencies
```bash
# Clean tất cả và cài lại
melos run clean_all
melos run pub_get
```

### Nếu có vấn đề với format
```bash
# Format lại toàn bộ code
melos run format
```

## 📚 Tài liệu tham khảo

- [Melos Documentation](https://melos.invertase.dev/)
- [Flutter Bloc](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## 🤝 Contributing

Khi thêm script mới vào `melos.yaml`, hãy:
1. Thêm description rõ ràng
2. Sử dụng packageFilters phù hợp
3. Cập nhật README này
4. Test script trước khi commit

