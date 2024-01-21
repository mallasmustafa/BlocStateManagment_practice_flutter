
import 'package:bloc/bloc.dart';
import 'package:bloc_practice/bloc/todo/todo_event.dart';
import 'package:bloc_practice/bloc/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<String> todos = [];
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(_addTodoEvents);
    on<RemoveTodoEvent>(_removeTodoEvent);
  }
  void _addTodoEvents(AddTodoEvent event, Emitter<TodoState> emit){
    todos.add(event.task);
    emit(state.copyWith(todoList: List.from(todos)));
  }
  void _removeTodoEvent(RemoveTodoEvent event, Emitter<TodoState> emit){
    todos.remove(event.task);
    emit(state.copyWith(todoList: List.from(todos)));
  }
}
