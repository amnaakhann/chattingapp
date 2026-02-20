import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class GetSignedInUser {
  final AuthRepository repository;
  GetSignedInUser(this.repository);

  Future<UserEntity?> call() async {
    return repository.getSignedInUser();
  }
}
