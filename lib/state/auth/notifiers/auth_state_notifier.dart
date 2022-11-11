import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/auth/backend/authenticator.dart';
import 'package:instantgram/state/auth/models/auth_resut.dart';
import 'package:instantgram/state/auth/models/auth_state.dart';
import 'package:instantgram/state/posts/typedefs/user_id.dart';
import 'package:instantgram/state/user_info/backend/user_ifo_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unkown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logout() async {
    state = state.copiedWithIsLoading(true);
    _authenticator.logout();
    state = const AuthState.unkown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfoStorage(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
