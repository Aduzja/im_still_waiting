import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:im_still_waiting/features/login/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCreatingAccount == true
                    ? 'Register'.toUpperCase()
                    : 'Sign in'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: widget.passwordController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(errorMessage),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade400,
                    ),
                    onPressed: () async {
                      if (isCreatingAccount == true) {
                        try {
                          await (context.read<LoginCubit>().createUser(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                              ));
                        } catch (error) {
                          setState(() {
                            errorMessage = 'Something went wrong';
                          });
                        }
                      } else {
                        try {
                          await (context.read<LoginCubit>().signIn(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                              ));
                        } catch (error) {
                          setState(() {
                            errorMessage = 'Something went wrong';
                          });
                        }
                      }
                    },
                    child: Text(
                      isCreatingAccount == true
                          ? 'Register'.toUpperCase()
                          : 'Sign In'.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: Text(
                    'Create account',
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                ),
              ],
              if (isCreatingAccount == true) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: Text(
                    'Already have account?',
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              LoginIn(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginIn extends StatelessWidget {
  LoginIn({super.key});

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          _googleSignIn.signIn().then((value) {
            // String userName = value!.displayName!;
            // String profilePicture = value.photoUrl!;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/google_icon.png",
              height: 20,
            ),
            const Text(
              '  Login with Google',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
