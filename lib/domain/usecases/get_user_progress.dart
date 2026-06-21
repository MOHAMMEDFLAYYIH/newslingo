import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';

class GetUserProgress {
  final NewsRepository repository;

  GetUserProgress(this.repository);

  Future<UserProgress> call() {
    return repository.getUserProgress();
  }
}

class UpdateUserProgress {
  final NewsRepository repository;

  UpdateUserProgress(this.repository);

  Future<void> call(UserProgress progress) {
    return repository.updateUserProgress(progress);
  }
}
