/// A simple usecase contract: takes Params and returns a Future of Type T.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams {}
