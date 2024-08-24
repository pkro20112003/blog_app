import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zidiointernshipblogapp/core/Secrets/App_secret.dart';
import 'package:zidiointernshipblogapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:zidiointernshipblogapp/core/network/connection_checker.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/dataSource/auth_data.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/repository/auth_repoimpl.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/repository/auth_repository.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/usecases/User_Sign_Up.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/usecases/current_user.dart';
import 'package:zidiointernshipblogapp/feature/auth/domain/usecases/user_login.dart';
import 'package:zidiointernshipblogapp/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:zidiointernshipblogapp/feature/blog/data/datasources/blog_remote_data_source.dart';
import 'package:zidiointernshipblogapp/feature/blog/data/repository/blog_repository_impl.dart';
import 'package:zidiointernshipblogapp/feature/blog/domain/repository/blog_repository.dart';
import 'package:zidiointernshipblogapp/feature/blog/domain/usecases/get_all_blogs.dart';
import 'package:zidiointernshipblogapp/feature/blog/domain/usecases/upload_blog.dart';
import 'package:zidiointernshipblogapp/feature/blog/presentation/bloc/blog_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecret.supabaseUrl,
    anonKey: AppSecret.supabaseAnonkey,
  );

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(InternetConnection()));
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthData>(
      () => AuthDataImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
