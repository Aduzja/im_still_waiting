import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/app/home/cubit/home_page_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('I\'m still waiting ⏲️'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: const _HomePageBody(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit()..start(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return ListView();
        },
      ),
    );
  }
}
