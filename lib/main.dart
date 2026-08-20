import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Zamanlayıcı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE85D5D)),
        useMaterial3: true,
      ),
      home: const PomodoroHomePage(),
    );
  }
}

enum SessionType { focus, shortBreak, longBreak }

extension SessionTypeLabel on SessionType {
  String get label {
    switch (this) {
      case SessionType.focus:
        return 'Odaklanma';
      case SessionType.shortBreak:
        return 'Kısa Mola';
      case SessionType.longBreak:
        return 'Uzun Mola';
    }
  }

  Duration get duration {
    switch (this) {
      case SessionType.focus:
        return const Duration(minutes: 25);
      case SessionType.shortBreak:
        return const Duration(minutes: 5);
      case SessionType.longBreak:
        return const Duration(minutes: 15);
    }
  }
}

class PomodoroHomePage extends StatefulWidget {
  const PomodoroHomePage({super.key});

  @override
  State<PomodoroHomePage> createState() => _PomodoroHomePageState();
}

class _PomodoroHomePageState extends State<PomodoroHomePage> {
  SessionType _sessionType = SessionType.focus;
  late Duration _remaining = _sessionType.duration;
  Timer? _timer;
  bool _isRunning = false;
  int _completedFocusSessions = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 1) {
        timer.cancel();
        _onSessionComplete();
      } else {
        setState(() => _remaining -= const Duration(seconds: 1));
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _remaining = _sessionType.duration;
    });
  }

  void _onSessionComplete() {
    setState(() {
      _isRunning = false;
      if (_sessionType == SessionType.focus) {
        _completedFocusSessions++;
        _sessionType = _completedFocusSessions % 4 == 0
            ? SessionType.longBreak
            : SessionType.shortBreak;
      } else {
        _sessionType = SessionType.focus;
      }
      _remaining = _sessionType.duration;
    });
  }

  void _selectSession(SessionType type) {
    _timer?.cancel();
    setState(() {
      _sessionType = type;
      _remaining = type.duration;
      _isRunning = false;
    });
  }

  String get _formattedTime {
    final minutes = _remaining.inMinutes.toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pomodoro Zamanlayıcı')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton<SessionType>(
              segments: const [
                ButtonSegment(value: SessionType.focus, label: Text('Odak')),
                ButtonSegment(value: SessionType.shortBreak, label: Text('Kısa Mola')),
                ButtonSegment(value: SessionType.longBreak, label: Text('Uzun Mola')),
              ],
              selected: {_sessionType},
              onSelectionChanged: (selection) => _selectSession(selection.first),
            ),
            const SizedBox(height: 32),
            Text(
              _sessionType.label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _formattedTime,
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: _toggleTimer,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning ? 'Duraklat' : 'Başlat'),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Sıfırla'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Tamamlanan odak seansı: $_completedFocusSessions'),
          ],
        ),
      ),
    );
  }
}
