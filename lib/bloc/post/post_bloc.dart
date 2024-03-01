
import 'package:bloc/bloc.dart';
import 'package:bloc_practice/bloc/post/post_event.dart';
import 'package:bloc_practice/bloc/post/post_state.dart';
import 'package:bloc_practice/repository/post_repository.dart';
import 'package:bloc_practice/utils/enums.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();
  PostBloc() : super(const PostState()) {
    on<PostFetched>(fetchPostApi);
  }
  void fetchPostApi(PostFetched event, Emitter<PostState> emit)async{
   await postRepository.fetchPost().then((value){
      emit(state.copyWith(
        postStatus: PostStatus.success, message: "success",
        postList: value,
      ));
    }).onError((error, stackTrace){
      print(error);
      print(stackTrace);
      emit(state.copyWith(postStatus: PostStatus.failure, message: error.toString()));
    });
  }
}
