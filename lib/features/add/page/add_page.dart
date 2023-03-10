import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/features/add/cubit/add_cubit.dart';
import 'package:im_still_waiting/models/item_model.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? _imageURL;
  String? _title;
  DateTime? _releaseDate;

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
                    onPressed: _imageURL == null ||
                            _title == null ||
                            _releaseDate == null
                        ? null
                        : () {
                            context.read<AddCubit>().add(
                                  ItemModel(
                                    imageURL: _imageURL!,
                                    title: _title!,
                                    releaseDate: _releaseDate!,
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
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              body: _AddPageBody(
                onTitleChanged: (newValue) {
                  setState(() {
                    _title = newValue;
                  });
                },
                onImageUrlChanged: (newValue) {
                  setState(() {
                    _imageURL = newValue;
                  });
                },
                onDateChanged: (newValue) {
                  setState(() {
                    _releaseDate = newValue as DateTime?;
                  });
                },
                selectedDateFormatted: _releaseDate != null
                    ? DateFormat.yMMMMd().format(_releaseDate!)
                    : null,
              ),
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
    required this.onTitleChanged,
    required this.onImageUrlChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onTitleChanged;
  final Function(String) onImageUrlChanged;
  final Function(String) onDateChanged;
  final String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      children: [
        TextField(
          onChanged: onTitleChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Put name here',
            label: Text('What are you waiting for? 👀'),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          onChanged: onImageUrlChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'http:// ... .jpg',
            label: Text('Paste image URL'),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade400,
          ),
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                const Duration(days: 365 * 10),
              ),
            );
            onDateChanged(selectedDate as String);
          },
          child: Text(
            selectedDateFormatted ?? 'Choose release date',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
