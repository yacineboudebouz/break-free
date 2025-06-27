import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';
import 'base_usecase.dart';

/// Use case for retrieving articles with optional filtering
///
/// This use case handles fetching articles from the repository with
/// various filtering options including category, mood, difficulty, etc.
class GetArticles implements UseCase<List<Article>, GetArticlesParams> {
  final ArticleRepository repository;

  const GetArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(GetArticlesParams params) async {
    try {
      AppLogger.info(
        'Getting articles with filters: ${params.filters?.activeFiltersDescription ?? "no filters"}',
      );

      late Either<Failure, List<Article>> result;

      if (params.filters != null && params.filters!.hasActiveFilters) {
        // Apply filters
        result = await repository.getArticlesWithFilters(params.filters!);
      } else {
        // Get all articles
        result = await repository.getArticles();
      }

      return result.fold(
        (failure) {
          AppLogger.error('Failed to get articles: ${failure.message}');
          return Left(failure);
        },
        (articles) {
          AppLogger.info('Successfully retrieved ${articles.length} articles');
          return Right(articles);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error while getting articles', e, stackTrace);
      return Left(
        UnexpectedFailure(message: 'Failed to get articles: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for the GetArticles use case
class GetArticlesParams extends Equatable {
  final ArticleFilters? filters;

  const GetArticlesParams({this.filters});

  @override
  List<Object?> get props => [filters];
}
