part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  const HomePageState({
    this.items = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
  final List<ItemModel> items;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
}
