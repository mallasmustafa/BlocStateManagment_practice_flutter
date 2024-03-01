import 'package:bloc_practice/bloc/post/post_bloc.dart';
import 'package:bloc_practice/bloc/post/post_event.dart';
import 'package:bloc_practice/bloc/post/post_state.dart';
import 'package:bloc_practice/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("posts Apis"),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch(state.postStatus){
            case PostStatus.loading:
              return const Center(child: CircularProgressIndicator(),);
            case PostStatus.failure:
              return  Center(child: Text(state.message.toString()),);
            case PostStatus.success:
              return Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Search with email",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<PostBloc>().add(SearchItem(value));
                    },
                  ),
                  Expanded(
                    child:state.searchMessage.isNotEmpty? Center(child: Text(state.searchMessage.toString())) :ListView.builder(
                      itemCount: state.tempPostList.isEmpty? state.postList.length : state.tempPostList.length,
                      itemBuilder: (context, index) {
                        if(state.tempPostList.isNotEmpty){
                          final item = state.tempPostList[index];
                          return  Card(
                            child: ListTile(
                              title: Text(item.email.toString()),
                              subtitle: Text(item.body.toString()),
                            ),
                          );
                        }else{
                          final item = state.postList[index];
                          return  Card(
                            child: ListTile(
                              title: Text(item.email.toString()),
                              subtitle: Text(item.body.toString()),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
          }

        },
      ),
    );
  }
}
