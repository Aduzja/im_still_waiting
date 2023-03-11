import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/models/item_model.dart';
import 'package:im_still_waiting/reporisories/items_repository.dart';

part 'waiting_list_state.dart';

class WaitingListCubit extends Cubit<WaitingListState> {
WaitingListCubit(this._itemsRepository) : super(const WaitingListState());

  final ItemsRepository _itemsRepository;

  Future<void> getItemWithID(String itemID) async {
    try {
      final itemModel = await _itemsRepository.getItemWithID(itemID);
      emit(WaitingListState(itemModel: itemModel));
    } catch (error) {
      emit(
        const WaitingListState(
          loadingErrorOccured: true,
        ),
      );
    }
  }
}
