import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zidiointernshipblogapp/core/Secrets/App_secret.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/dataSource/auth_data.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/repository/auth_repoimpl.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/repository/auth_repository.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/usecases/User_Sign_Up.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonkey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthData>(
    () => AuthDataImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
