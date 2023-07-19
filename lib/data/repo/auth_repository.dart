import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/common/http_client.dart';
import 'package:nike_ecommerce_app/data/auth_info.dart';
import 'package:nike_ecommerce_app/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);

  AuthRepository(this.dataSource);

  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _persistAuth(authInfo);
    debugPrint(authInfo.accessToken.toString());
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo =
        await dataSource.refreshToken(authChangeNotifier.value!.refreshToken);
    _persistAuth(authInfo);
  }

  @override
  Future<void> signUp(String username, String password) async {
    final AuthInfo authInfo = await dataSource.signUp(username, password);
    _persistAuth(authInfo);
    debugPrint(authInfo.accessToken.toString());
  }

  Future<void> _persistAuth(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accessToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
    loadAuthInfo(); // ****************************************
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString("access_token") ?? '';
    final refreshToken = sharedPreferences.getString("refresh_token") ?? '';

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreshToken);
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
