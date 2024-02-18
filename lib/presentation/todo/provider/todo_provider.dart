import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_state_management/models/todo.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@Riverpod(keepAlive: true)
class TodoNotifier extends _$TodoNotifier {
  @override
  List<Todo> build() => <Todo>[];

  create({required String title, required String body}) {
    Todo newTodo = Todo(
      id: const Uuid().v4(),
      title: title,
      body: body,
    );
    state = [...state, newTodo];
  }

  update({required Todo newTodo}) {
    int index = state.indexWhere((element) => element.id == newTodo.id);
    state[index] = newTodo;
    state = [...state];
  }

  delete({required String id}) {
    state.removeWhere((element) => element.id == id);
    state = [...state];
  }
}
