# pomodoro-flutter 🍅⏱️

Flutter (Material 3) ile geliştirilmiş, sade ve gerçek bir **Pomodoro /
odaklanma zamanlayıcı** uygulaması. Odak, kısa mola ve uzun mola seansları
arasında otomatik geçiş yapar; her 4 odak seansından sonra uzun molaya geçer.

## ✨ Özellikler

- 🎯 25 dakikalık odak seansı, 5 dakikalık kısa mola, 15 dakikalık uzun mola
- 🔄 Seans tamamlandığında bir sonraki seansa otomatik geçiş
- ⏸️ Başlat / Duraklat / Sıfırla kontrolleri
- 📊 Tamamlanan odak seansı sayacı
- 🎨 Material 3 tasarım dili

## 🖼️ Ekranlar

Uygulama tek bir ana ekrandan oluşur: üstte seans seçici (Odak / Kısa Mola /
Uzun Mola), ortada geri sayım ve altta kontrol butonları.

## 🚀 Kurulum ve çalıştırma

```bash
git clone https://github.com/OzgeCndn/pomodoro-flutter.git
cd pomodoro-flutter
flutter pub get
flutter run
```

## ✅ Testler

```bash
flutter test
```

`test/timer_logic_test.dart` seans sürelerini, etiketleri ve başlangıç
ekranının doğru render edildiğini doğrular.

## 📁 Proje yapısı

```
pomodoro-flutter/
├── lib/
│   └── main.dart          # Uygulamanın tamamı (UI + zamanlayıcı mantığı)
├── test/
│   └── timer_logic_test.dart
├── pubspec.yaml
└── README.md
```

## 📄 Lisans

MIT — detaylar için [LICENSE](LICENSE) dosyasına bakın.
