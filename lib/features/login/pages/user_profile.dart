import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_still_waiting/features/login/cubit/login_cubit.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: CircleAvatar(
              backgroundColor: Colors.orange.shade600,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          Text('You\'re sign in as $email'),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade400,
            ),
            onPressed: () {
              context.read<LoginCubit>().signOut();
            },
            child: const Text(
              'Sign out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
