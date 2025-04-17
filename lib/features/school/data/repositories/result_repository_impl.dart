import '../../domain/entities/result.dart';
import '../../domain/repositories/result_repository.dart';
import '../data_sources/results_api.dart';

class ResultRepositoryImpl implements ResultRepository {
  final ResultsApi api;

  ResultRepositoryImpl(this.api);

  @override
  Future<List<Result>> getResults() => api.fetchResults();
}
