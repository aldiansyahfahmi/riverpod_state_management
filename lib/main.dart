import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_management/main_screen.dart';
import 'package:riverpod_state_management/presentation/counter/screen/counter_screen.dart';
import 'package:riverpod_state_management/presentation/todo_list/screen/todo_list_screen.dart';
import 'package:riverpod_state_management/presentation/users/screen/users_screen.dart';
import 'package:riverpod_state_management/router/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod State Management',
      home: const MainScreen(),
      routes: {
        AppRoutes.counter: (context) => const CounterScreen(),
        AppRoutes.todoList: (context) => const TodoListScreen(),
        AppRoutes.users: (context) => const UsersScreen(),
      },
    );
  }
}
