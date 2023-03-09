import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:im_still_waiting/features/add/page/add_page.dart';
import 'package:im_still_waiting/features/home/cubit/home_page_cubit.dart';
import 'package:im_still_waiting/features/login/page/user_profile.dart';
import 'package:im_still_waiting/models/item_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

var selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            'I\'M STILL WAITING'),
        backgroundColor: Colors.green.shade300,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle_rounded),
            color: Colors.green.shade800,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPage(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.green.shade300,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.green.shade200,
            padding: const EdgeInsets.all(10),
            gap: 10,
            selectedIndex: selectedIndex,
            onTabChange: (newIndex) {
              setState(() {
                selectedIndex = newIndex;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.list,
                text: 'List',
              ),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (selectedIndex == 0) {
            return const _HomePageBody();
          }
          return UserProfile(
            email: widget.user.email,
          );
        },
      ),
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
      child: BlocListener<HomePageCubit, HomePageState>(
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
                content: Text('Couldn\'t load data'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              children: [
                for (final itemModel in state.items)
                  Dismissible(
                    key: ValueKey(itemModel.id),
                    background: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.green.shade300,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(25),
                              child: Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(25),
                              child: Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      context.read<HomePageCubit>().remove(itemModel);
                    },
                    child: _ListViewItem(
                      itemModel: itemModel,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(15),
    );
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white60,
      ),
      child: Column(
        children: [
          Container(
            height: 35,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.orange.shade400,
            ),
            child: Center(
              child: Text(
                itemModel.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: borderRadius,
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: SizedBox.fromSize(
                      child: Image.network(
                        itemModel.imageURL,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.lightGreenAccent.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.white70,
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          '${itemModel.daysLeft}',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'days left',
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      itemModel.releaseDateFormatted,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
