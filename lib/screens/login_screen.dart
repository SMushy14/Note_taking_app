import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_cubit.dart';
import 'notes_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => NotesScreen(user: state.user!)),
          );
        }
        if (state.error != null) {
          String errorMessage;
          switch (state.error) {
            case 'user-not-found':
              errorMessage = 'No account found. Maybe try signing up instead?';
              break;
            case 'wrong-password':
              errorMessage = 'Incorrect password. Please try again.';
              break;
            case 'invalid-email':
              errorMessage = 'Invalid email address.';
              break;
            case 'weak-password':
              errorMessage = 'Password is too weak (min 6 characters).';
              break;
            case 'email-already-in-use':
              errorMessage = 'That email is already registered.';
              break;
            default:
              errorMessage = 'An unexpected error occurred. Please try again.';
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(isSignUp ? 'Sign Up' : 'Login'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    if (isSignUp) {
                      context.read<AuthCubit>().signUp(email, password);
                    } else {
                      context.read<AuthCubit>().login(email, password);
                    }
                  },
                  child: Text(isSignUp ? 'Sign Up' : 'Login'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignUp = !isSignUp;
                    });
                  },
                  child: Text(
                    isSignUp
                        ? 'Already have an account? Login'
                        : 'Create an account',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
