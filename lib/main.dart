import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'bloc/auth_cubit.dart';
import 'bloc/notes_cubit.dart';
import 'data/auth_repository.dart';
import 'data/notes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => NotesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => NotesCubit(context.read<NotesRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Mini Notes',
          theme: ThemeData(primarySwatch: Colors.purple),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
