import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}
class AddTodoEvent extends TodoEvent{
  final String task;

  const AddTodoEvent(this.task);
  @override
  List<Object> get props => [task];
}
class RemoveTodoEvent extends TodoEvent{
  final Object task;

  RemoveTodoEvent(this.task);

  @override
  List<Object> get props => [task];
}
