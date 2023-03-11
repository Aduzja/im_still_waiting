import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/features/waiting_list/cubit/waiting_list_cubit.dart';
import 'package:im_still_waiting/reporisories/items_repository.dart';

class WaitingListPage extends StatelessWidget {
  const WaitingListPage({
    Key? key,
    required this.email,
    required this.itemID,
  }) : super(key: key);

  final String? email;
  final String itemID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return WaitingListCubit(ItemsRepository())..getItemWithID(itemID);
      },
      child: BlocConsumer<WaitingListCubit, WaitingListState>(
        listener: (context, state) {
          if (state.removingErrorOccured) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Unable to remove the item'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state.loadingErrorOccured) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Couldn\'t load data :('),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Can\'t Wait 🤩'),
            ),
            body: const _DetailsPageBody(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back),
            ),
          );
        },
      ),
    );
  }
}

class _DetailsPageBody extends StatelessWidget {
  const _DetailsPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaitingListCubit, WaitingListState>(
      builder: (context, state) {
        final itemModel = state.itemModel;
        if (itemModel == null) {
          return const SizedBox.shrink();
        }
        return ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: NetworkImage(
                    itemModel.imageURL,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          itemModel.title,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(itemModel.releaseDateFormatted),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text('${itemModel.daysLeft}'),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(''),
            ),
          ],
        );
      },
    );
  }
}
