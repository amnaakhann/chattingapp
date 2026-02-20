import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity?> getSignedInUser() async {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    return remoteDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    return remoteDataSource.signOut();
  }
}
