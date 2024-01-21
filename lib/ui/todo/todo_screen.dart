import 'package:bloc_practice/bloc/todo/todo_bloc.dart';
import 'package:bloc_practice/bloc/todo/todo_event.dart';
import 'package:bloc_practice/bloc/todo/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if(state.todosList.isEmpty){
            return const Center(child: Text("No Todo found"),);
          }else if(state.todosList.isNotEmpty){

          }else{
          return  SizedBox();
          }
          return ListView.builder(
            itemCount: state.todosList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.todosList[index]),
                trailing: IconButton(
                    onPressed: () {
                      context.read<TodoBloc>().add(RemoveTodoEvent(state.todosList[index]));
                    }, icon: const Icon(Icons.delete)),
              );
            },);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for(int i = 0; i<10; i++) {
            context.read<TodoBloc>().add(AddTodoEvent('Task $i'));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}