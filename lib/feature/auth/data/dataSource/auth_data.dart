import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zidiointernshipblogapp/core/error/Exception.dart';

abstract interface class AuthData {
  Future<String> SignUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> SignInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthDataImpl implements AuthData {
  final SupabaseClient supabaseClient;
  AuthDataImpl(this.supabaseClient);
  @override
  Future<String> SignInWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<String> SignUpWithEmailPassword({
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
      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
