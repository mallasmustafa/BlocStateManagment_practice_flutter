import 'package:bloc/bloc.dart';
import 'package:bloc_practice/bloc/favourite_app/favourite_app_event.dart';
import 'package:bloc_practice/bloc/favourite_app/favourite_app_state.dart';
import 'package:bloc_practice/repository/favourite_repository.dart';
import '../../model/favourite_item_model.dart';

class FavouriteAppBloc extends Bloc<FavouriteAppEvent, FavouriteItemStates> {
  FavouriteRepository favouriteRepository;
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> tempFavouriteList = [];
  FavouriteAppBloc(this.favouriteRepository)
      : super(const FavouriteItemStates()) {
    on<FetchFavouriteList>(fetchList);
    on<FavouriteItem>(_addFavouriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
    on<DeleteItem> (_deleteItem);
  }

  void fetchList(FetchFavouriteList event, Emitter<FavouriteItemStates> emit) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.success));
  }

  void _addFavouriteItem(FavouriteItem event, Emitter<FavouriteItemStates> emit) async{
    final index = favouriteList.indexWhere((element) => element.id==event.item.id);
    if(event.item.isFavourite){
     if(tempFavouriteList.contains(favouriteList[index])){
       tempFavouriteList.remove(favouriteList[index]);
       tempFavouriteList.add(event.item);
     }
    }else{
      if(tempFavouriteList.contains(favouriteList[index])){
        tempFavouriteList.remove(favouriteList[index]);
        tempFavouriteList.add(event.item);
      }
    }
    favouriteList[index] = event.item;
    emit(state.copyWith(favouriteItemList: List.from(favouriteList),
        tempFavouriteItemList: List.from(tempFavouriteList)));
  }

  void _selectItem(SelectItem event, Emitter<FavouriteItemStates>emit){
    tempFavouriteList.add(event.item);
    emit(state.copyWith(tempFavouriteItemList: List.from(tempFavouriteList)));
  }

  void _unSelectItem(UnSelectItem event, Emitter<FavouriteItemStates>emit){
     tempFavouriteList.remove(event.item);
    emit(state.copyWith(tempFavouriteItemList: List.from(tempFavouriteList)));
  }
  void _deleteItem(DeleteItem event, Emitter<FavouriteItemStates>emit){
    for(int i=0; i<tempFavouriteList.length; i++){
      favouriteList.remove(tempFavouriteList[i]);
    }
    tempFavouriteList.clear();
    emit(state.copyWith(
      favouriteItemList: List.from(favouriteList),
        tempFavouriteItemList: List.from(tempFavouriteList)));
  }
}
