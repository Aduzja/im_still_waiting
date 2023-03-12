import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/models/item_model.dart';
import 'package:im_still_waiting/reporisories/items_repository.dart';

part 'waiting_list_state.dart';

class WaitingListCubit extends Cubit<WaitingListState> {
  WaitingListCubit(this._itemsRepository)
      : super(WaitingListState(itemModel: null));

  final ItemsRepository _itemsRepository;

  Future<void> getItemWithID(String id) async {
    final itemModel = await _itemsRepository.get(id: id);
    emit(WaitingListState(itemModel: itemModel));
  }
}
