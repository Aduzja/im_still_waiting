part of 'waiting_list_cubit.dart';

class WaitingListState {
  const WaitingListState({
    this.itemModel,
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
  final ItemModel? itemModel;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
}
