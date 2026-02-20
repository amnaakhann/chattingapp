import 'package:flutter/foundation.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthState {
  final UserEntity? user;
  final bool loading;
  final String? error;

  AuthState({this.user, this.loading = false, this.error});

  AuthState copyWith({UserEntity? user, bool? loading, String? error}) {
    return AuthState(user: user ?? this.user, loading: loading ?? this.loading, error: error ?? this.error);
  }
}

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;
  AuthState _state = AuthState();

  AuthState get state => _state;

  AuthProvider(this.repository) {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _state = _state.copyWith(loading: true);
    notifyListeners();
    final u = await repository.getSignedInUser();
    _state = _state.copyWith(user: u, loading: false);
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    _state = _state.copyWith(loading: true);
    notifyListeners();
    try {
      final u = await repository.signInWithGoogle();
      _state = _state.copyWith(user: u, loading: false);
    } catch (e) {
      _state = _state.copyWith(error: e.toString(), loading: false);
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await repository.signOut();
    _state = AuthState();
    notifyListeners();
  }
}
