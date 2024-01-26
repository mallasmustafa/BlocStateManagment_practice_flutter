import 'package:bloc_practice/model/favourite_item_model.dart';
import 'package:equatable/equatable.dart';

enum ListStatus { loading, success, failure }

class FavouriteItemStates extends Equatable {
  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> tempFavouriteItemList;
  final ListStatus listStatus;

  const FavouriteItemStates(
      {this.favouriteItemList = const [],
        this.tempFavouriteItemList = const [],
      this.listStatus = ListStatus.loading});

  FavouriteItemStates copyWith(
      {List<FavouriteItemModel>? favouriteItemList, ListStatus? listStatus, List<FavouriteItemModel>? tempFavouriteItemList}) {
    return FavouriteItemStates(
      favouriteItemList: favouriteItemList ?? this.favouriteItemList,
      listStatus: listStatus ?? this.listStatus,
      tempFavouriteItemList: tempFavouriteItemList??this.tempFavouriteItemList
    );
  }

  @override
  List<Object?> get props => [favouriteItemList, listStatus, tempFavouriteItemList];
}
