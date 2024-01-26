import 'package:bloc_practice/bloc/favourite_app/favourite_app_bloc.dart';
import 'package:bloc_practice/bloc/favourite_app/favourite_app_event.dart';
import 'package:bloc_practice/bloc/favourite_app/favourite_app_state.dart';
import 'package:bloc_practice/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppScreen extends StatefulWidget {
  const FavouriteAppScreen({super.key});

  @override
  State<FavouriteAppScreen> createState() => _FavouriteAppScreenState();
}

class _FavouriteAppScreenState extends State<FavouriteAppScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteAppBloc>().add(FetchFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite App"),
        actions: [
          BlocBuilder<FavouriteAppBloc, FavouriteItemStates>(
            builder: (context, state) {
              return Visibility(
                visible: state.tempFavouriteItemList.isNotEmpty?true:false,
                child: IconButton(
                  onPressed: () {
                    context.read<FavouriteAppBloc>().add(DeleteItem());
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<FavouriteAppBloc, FavouriteItemStates>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ListStatus.failure:
                return const Text("Something went wrong");
              case ListStatus.success:
                return ListView.builder(
                  itemCount: state.favouriteItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.favouriteItemList[index];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: state.tempFavouriteItemList.contains(item)
                              ? true
                              : false,
                          onChanged: (value) {
                            if (value!) {
                              context
                                  .read<FavouriteAppBloc>()
                                  .add(SelectItem(item: item));
                            } else {
                              context
                                  .read<FavouriteAppBloc>()
                                  .add(UnSelectItem(item: item));
                            }
                          },
                        ),
                        title: Text(item.value.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            FavouriteItemModel itemModel = FavouriteItemModel(
                              id: item.id,
                              value: item.value,
                              isFavourite: item.isFavourite ? false : true,
                            );
                            context
                                .read<FavouriteAppBloc>()
                                .add(FavouriteItem(item: itemModel));
                          },
                          icon: Icon(
                            item.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: item.isFavourite ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
