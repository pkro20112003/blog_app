import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zidiointernshipblogapp/core/theme/theme.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/pages/Signin_page.dart';
import 'package:zidiointernshipblogapp/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
    );
  }
}
