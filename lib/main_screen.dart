import 'package:flutter/material.dart';
import 'package:riverpod_state_management/presentation/counter/screen/counter_screen.dart';
import 'package:riverpod_state_management/presentation/todo/screen/todo_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod State Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CounterScreen(),
                  ),
                );
              },
              child: const Text('Counter'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoScreen(),
                  ),
                );
              },
              child: const Text('Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
