/// A simple usecase contract: takes Params and returns a Future of Result.
abstract class UseCase<Result, Params> {
  Future<Result> call(Params params);
}

class NoParams {}
