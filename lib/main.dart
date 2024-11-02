import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const ClockApp());
}

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int elapsedTime = 0;
  bool isRunning = false;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        elapsedTime += 10;
      });
    });
    isRunning = true;
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      isRunning = false;
      elapsedTime = 0;
    });
  }

  String formatTime(int milliseconds) {
    int totalSeconds = (milliseconds / 1000).truncate(); // Total seconds
    int seconds = totalSeconds % 60;
    String secondsStr = seconds.toString().padLeft(2, '0');
    return secondsStr;
  }

  String millisecondsOnly(int milliseconds) {
    // Get milliseconds within the current second (0-999) and then divide by 10
    int millisecondsPart = (milliseconds % 1000) ~/ 10;
    return millisecondsPart.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatTime(elapsedTime),
                  style: const TextStyle(
                      fontSize: 100, fontWeight: FontWeight.bold),
                ),
                const Text('.'),
                Text(
                  millisecondsOnly(elapsedTime),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    startTimer();
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    stopTimer();
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    resetTimer();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
