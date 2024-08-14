import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zidiointernshipblogapp/core/Secrets/App_secret.dart';
import 'package:zidiointernshipblogapp/core/theme/theme.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/dataSource/auth_data.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/repository/auth_repoimpl.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/usecases/User_Sign_Up.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/pages/Signin_page.dart';
// ignore: unused_import
import 'package:zidiointernshipblogapp/feature/auth/presentation/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabaseAnonkey);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => AuthBloc(
                userSignUp: UserSignUp(
                  AuthRepositoryImpl(
                    AuthDataImpl(
                      supabase.client,
                    ),
                  ),
                ),
              ))
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
