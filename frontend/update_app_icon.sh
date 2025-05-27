#!/bin/bash

# Скрипт для замены иконки приложения DevUP

echo "🎨 Замена иконки приложения DevUP..."

# Проверяем, что мы в правильной директории
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Ошибка: Запустите скрипт из папки frontend"
    exit 1
fi

# Проверяем наличие flutter_launcher_icons
if ! grep -q "flutter_launcher_icons" pubspec.yaml; then
    echo "❌ Ошибка: flutter_launcher_icons не найден в pubspec.yaml"
    exit 1
fi

echo "📦 Установка зависимостей..."
flutter pub get

echo "🔧 Генерация иконок для всех платформ..."
flutter pub run flutter_launcher_icons:main

if [ $? -eq 0 ]; then
    echo "✅ Иконки успешно сгенерированы!"
    echo ""
    echo "📱 Сгенерированы иконки для:"
    echo "   • Android (все размеры в android/app/src/main/res/mipmap-*)"
    echo "   • iOS (все размеры в ios/Runner/Assets.xcassets/AppIcon.appiconset/)"
    echo ""
    echo "🚀 Для применения изменений выполните:"
    echo "   flutter clean && flutter run"
else
    echo "❌ Ошибка при генерации иконок"
    exit 1
fi 