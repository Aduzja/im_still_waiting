import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/models/item_model.dart';
import 'package:im_still_waiting/reporisories/items_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._itemsRepository) : super(const HomePageState());

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getItemsStream().listen(
      (items) {
        emit(HomePageState(items: items));
      },
    )..onError(
        (error) {
          emit(const HomePageState(loadingErrorOccured: true));
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemsRepository.delete(id: documentID);
    } catch (error) {
      emit(
        const HomePageState(removingErrorOccured: true),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
