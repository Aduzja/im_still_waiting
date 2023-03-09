import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/features/add/cubit/add_cubit.dart';
import 'package:im_still_waiting/models/item_model.dart';

class AddPage extends StatelessWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(),
      child: BlocListener<AddCubit, AddState>(
        listener: (context, state) {
          if (state.saved == true) {
            Navigator.of(context).pop();
          } else if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('An error occured: ${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddCubit, AddState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.green.shade50,
              appBar: AppBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                centerTitle: true,
                title: const Text(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    'Add new item'),
                backgroundColor: Colors.green.shade300,
                actions: [
                  IconButton(
                    color: Colors.green.shade800,
                    onPressed: () {
                      context.read<AddCubit>().add(
                            ItemModel(
                              imageURL:
                                  'https://assets.reedpopcdn.com/psvr2-headline_EmqTJ9l.jpg/BROK/resize/1200x1200%3E/format/jpg/quality/70/psvr2-headline_EmqTJ9l.jpg',
                              title: 'Gogle VR SONY PlayStation VR2',
                              releaseDate: DateTime(2023, 2, 23),
                            ),
                          );
                    },
                    //   ItemModel(
                    //   imageURL:
                    //       'https://assets.reedpopcdn.com/psvr2-headline_EmqTJ9l.jpg/BROK/resize/1200x1200%3E/format/jpg/quality/70/psvr2-headline_EmqTJ9l.jpg',
                    //   title: 'Gogle VR SONY PlayStation VR2',
                    //   releaseDate: '2023-02-23',
                    // ),
                    // ItemModel(
                    //   imageURL:
                    //       'https://gamesmag.cz/wp-content/uploads/2021/12/1.png',
                    //   title: 'Sons of the Forest',
                    //   releaseDate: '2023-02-23',
                    // ),
                    icon: const Icon(
                      Icons.check,
                    ),
                  ),
                ],
              ),
              body: const _AddPageBody(),
            );
          },
        ),
      ),
    );
  }
}

class _AddPageBody extends StatelessWidget {
  const _AddPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      children: const [],
    );
  }
}
