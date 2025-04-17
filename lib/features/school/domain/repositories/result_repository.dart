import '../entities/result.dart';

abstract class ResultRepository {
  Future<List<Result>> getResults();
}
