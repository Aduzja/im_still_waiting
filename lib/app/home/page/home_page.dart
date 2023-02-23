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
              color: Colors.white,
            ),
            'I\'M STILL WAITING'),
        backgroundColor: Colors.green.shade300,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle_rounded),
            color: Colors.green.shade800,
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
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            children: const [
              _ListViewItem(
                imageURL:
                    'https://assets.reedpopcdn.com/psvr2-headline_EmqTJ9l.jpg/BROK/resize/1200x1200%3E/format/jpg/quality/70/psvr2-headline_EmqTJ9l.jpg',
                title: 'Gogle VR SONY PlayStation VR2',
                releaseDate: '2023-02-23',
                daysLeft: 0,
              ),
              _ListViewItem(
                imageURL:
                    'https://gamesmag.cz/wp-content/uploads/2021/12/1.png',
                title: 'Sons of the Forest',
                releaseDate: '2023-02-23',
                daysLeft: 0,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    Key? key,
    required this.imageURL,
    required this.title,
    required this.releaseDate,
    required this.daysLeft,
  }) : super(key: key);

  final String imageURL;
  final String title;
  final String releaseDate;
  final int daysLeft;

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
                title,
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
                        imageURL,
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
                          '$daysLeft',
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
                      releaseDate,
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
