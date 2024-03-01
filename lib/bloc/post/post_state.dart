
import 'package:bloc_practice/utils/enums.dart';
import 'package:equatable/equatable.dart';

import '../../model/post_model.dart';

 class PostState extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> postList;
  final List<PostModel> tempPostList;
  final String message;
  final String searchMessage;

  const PostState({
    this.postStatus = PostStatus.loading,
     this.postList = const<PostModel>[],
     this.tempPostList = const<PostModel>[],
    this.message ='',
    this.searchMessage='',
  });
  PostState copyWith({PostStatus? postStatus,List<PostModel>? postList, String? message,List<PostModel>? tempPostList,String? searchMessage }){
    return PostState(
      postStatus: postStatus??this.postStatus,
      postList: postList??this.postList,
      message: message??this.message,
      tempPostList: tempPostList??this.tempPostList,
      searchMessage: searchMessage??this.searchMessage,
    );
}
  @override
  List<Object?> get props => [postStatus, postList,message,tempPostList,searchMessage];
}
