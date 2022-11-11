import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/state/auth/models/auth_resut.dart';
import 'package:instantgram/state/auth/providers/auth_state_provider.dart';

final isLoggedProvider=Provider<bool>((ref){
  final authState=ref.watch(authStateProvider);
  return authState.result==AuthResult.success;
});