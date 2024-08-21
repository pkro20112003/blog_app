import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zidiointernshipblogapp/core/error/Exception.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/model/user_model.dart';

abstract interface class AuthData {
  Session? get currentUserSession;
  Future<UserModel> SignUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> SignInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentuserData();
}

class AuthDataImpl implements AuthData {
  final SupabaseClient supabaseClient;
  AuthDataImpl(this.supabaseClient);
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> SignInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException("user is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> SignUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {"name": name},
      );
      if (response.user == null) {
        throw ServerException("user is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentuserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from("profiles").select().eq(
              'id',
              currentUserSession!.user.id,
            );
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
