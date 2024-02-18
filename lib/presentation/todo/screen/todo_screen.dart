import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_state_management/models/todo.dart';
import 'package:riverpod_state_management/presentation/todo/provider/todo_provider.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('rebuild');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _buildTodoForm(isUpdate: false);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer(
          builder: (context, widRef, child) {
            final todos = widRef.watch(todoNotifierProvider);
            if (todos.isEmpty) {
              return const Center(
                child: Text('Empty Todo'),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(todo.title),
                  subtitle: Text(todo.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _buildTodoForm(isUpdate: true, oldTodo: todo);
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(todoNotifierProvider.notifier)
                              .delete(id: todo.id);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: todos.length,
            );
          },
        ),
      ),
    );
  }

  _buildTodoForm({required bool isUpdate, Todo? oldTodo}) {
    if (isUpdate) {
      _titleController.text = oldTodo!.title;
      _bodyController.text = oldTodo.body;
    } else {
      _titleController.clear();
      _bodyController.clear();
    }
    showDialog(
      context: context,
      builder: (context) => Form(
        key: _formKey,
        child: SimpleDialog(
          contentPadding: const EdgeInsets.all(16),
          title: Text(isUpdate ? 'Update Todo' : 'Create Todo'),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _bodyController,
              decoration: const InputDecoration(
                hintText: 'Body',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter body';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (isUpdate) {
                    ref.read(todoNotifierProvider.notifier).update(
                          newTodo: oldTodo!.copyWith(
                            title: _titleController.text.trim(),
                            body: _bodyController.text.trim(),
                          ),
                        );
                  } else {
                    ref.read(todoNotifierProvider.notifier).create(
                        title: _titleController.text.trim(),
                        body: _bodyController.text.trim());
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
