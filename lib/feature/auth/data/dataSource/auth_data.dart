import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zidiointernshipblogapp/core/error/Exception.dart';
import 'package:zidiointernshipblogapp/feature/auth/data/model/user_model.dart';

abstract interface class AuthData {
  Future<UserModel> SignUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> SignInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthDataImpl implements AuthData {
  final SupabaseClient supabaseClient;
  AuthDataImpl(this.supabaseClient);
  @override
  Future<UserModel> SignInWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
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
}
