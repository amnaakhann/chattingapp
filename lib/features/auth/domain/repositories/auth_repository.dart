import '../../domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getSignedInUser();
  Future<UserEntity> signInWithGoogle();
  Future<void> signOut();
}
