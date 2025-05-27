# Инструкция по замене иконки приложения

## Шаги для замены иконки:

### 1. Подготовка новой иконки
- Сохраните новую иконку (голубого персонажа) как PNG файл
- Рекомендуемый размер: 1024x1024 пикселей
- Убедитесь, что иконка имеет квадратную форму
- Фон должен быть прозрачным или подходящим цветом

### 2. Замена файла иконки
Замените файл `assets/icon/icon.png` на вашу новую иконку:
```bash
# Скопируйте вашу новую иконку в проект
cp /path/to/your/new_icon.png frontend/assets/icon/icon.png
```

### 3. Генерация иконок для всех платформ
Выполните следующие команды в папке frontend:

```bash
# Перейдите в папку frontend
cd frontend

# Установите зависимости (если еще не установлены)
flutter pub get

# Сгенерируйте иконки для всех платформ
flutter pub run flutter_launcher_icons:main
```

### 4. Проверка результата
После выполнения команды будут автоматически созданы иконки для:
- **Android**: все размеры в папках `android/app/src/main/res/mipmap-*`
- **iOS**: все размеры в папке `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### 5. Пересборка приложения
```bash
# Очистите кэш
flutter clean

# Пересоберите приложение
flutter run
```

## Текущая конфигурация в pubspec.yaml:
```yaml
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon/icon.png"
```

## Альтернативный способ (ручная замена):

Если автоматическая генерация не работает, можно заменить иконки вручную:

### Android:
Замените файлы в следующих папках:
- `android/app/src/main/res/mipmap-mdpi/launcher_icon.png` (48x48)
- `android/app/src/main/res/mipmap-hdpi/launcher_icon.png` (72x72)
- `android/app/src/main/res/mipmap-xhdpi/launcher_icon.png` (96x96)
- `android/app/src/main/res/mipmap-xxhdpi/launcher_icon.png` (144x144)
- `android/app/src/main/res/mipmap-xxxhdpi/launcher_icon.png` (192x192)

### iOS:
Замените файлы в папке `ios/Runner/Assets.xcassets/AppIcon.appiconset/`:
- Icon-App-20x20@1x.png (20x20)
- Icon-App-20x20@2x.png (40x40)
- Icon-App-20x20@3x.png (60x60)
- Icon-App-29x29@1x.png (29x29)
- Icon-App-29x29@2x.png (58x58)
- Icon-App-29x29@3x.png (87x87)
- Icon-App-40x40@1x.png (40x40)
- Icon-App-40x40@2x.png (80x80)
- Icon-App-40x40@3x.png (120x120)
- Icon-App-60x60@2x.png (120x120)
- Icon-App-60x60@3x.png (180x180)
- Icon-App-76x76@1x.png (76x76)
- Icon-App-76x76@2x.png (152x152)
- Icon-App-83.5x83.5@2x.png (167x167)
- Icon-App-1024x1024@1x.png (1024x1024)

## Примечания:
- Убедитесь, что новая иконка хорошо выглядит в маленьких размерах
- Проверьте иконку на разных фонах (светлом и темном)
- iOS требует иконки без прозрачности для некоторых размеров 