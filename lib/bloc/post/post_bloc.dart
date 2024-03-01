import 'package:bloc/bloc.dart';
import 'package:bloc_practice/bloc/post/post_event.dart';
import 'package:bloc_practice/bloc/post/post_state.dart';
import 'package:bloc_practice/model/post_model.dart';
import 'package:bloc_practice/repository/post_repository.dart';
import 'package:bloc_practice/utils/enums.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  List<PostModel> tempPostList = [];
  PostRepository postRepository = PostRepository();
  PostBloc() : super(const PostState()) {
    on<PostFetched>(fetchPostApi);
    on<SearchItem>(_filterList);
  }
  void _filterList(SearchItem event, Emitter<PostState> emit) async {
    if(event.stSearch.isEmpty){
      emit(state.copyWith(tempPostList: [], searchMessage: ''));
    }else{
      tempPostList = state.postList
          .where((element) => element.email.toString().toLowerCase().contains(event.stSearch.toLowerCase()))
          .toList();
      if(tempPostList.isEmpty){
        emit(state.copyWith(tempPostList: tempPostList, searchMessage:  "No data found"));
      }else{
        emit(state.copyWith(tempPostList: tempPostList, searchMessage: ""));

      }
    }
  }

  void fetchPostApi(PostFetched event, Emitter<PostState> emit) async {
    await postRepository.fetchPost().then((value) {
      emit(state.copyWith(
        postStatus: PostStatus.success,
        message: "success",
        postList: value,
      ));
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      emit(state.copyWith(
          postStatus: PostStatus.failure, message: error.toString()));
    });
  }
}
