import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_flutter/main.dart';

void main() {
  group('SessionType', () {
    test('odak seansı süresi 25 dakikadır', () {
      expect(SessionType.focus.duration, const Duration(minutes: 25));
    });

    test('kısa mola süresi 5 dakikadır', () {
      expect(SessionType.shortBreak.duration, const Duration(minutes: 5));
    });

    test('uzun mola süresi 15 dakikadır', () {
      expect(SessionType.longBreak.duration, const Duration(minutes: 15));
    });

    test('etiketler doğru metni döndürür', () {
      expect(SessionType.focus.label, 'Odaklanma');
      expect(SessionType.shortBreak.label, 'Kısa Mola');
      expect(SessionType.longBreak.label, 'Uzun Mola');
    });
  });

  testWidgets('uygulama başlığı ve başlangıç süresi görünüyor', (tester) async {
    await tester.pumpWidget(const PomodoroApp());

    expect(find.text('25:00'), findsOneWidget);
    expect(find.text('Başlat'), findsOneWidget);
  });
}
