
 import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> todosList;
   const TodoState({
     this.todosList= const []
   });
   TodoState copyWith({List<String>? todoList}){
     return TodoState(todosList: todoList?? this.todosList);
 }
   @override
   List<Object> get props => [todosList];
 }


