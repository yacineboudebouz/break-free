import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';
import 'base_usecase.dart';

/// Use case for searching articles by text query
///
/// This use case handles searching through articles based on
/// text queries, searching title, summary, content, author, and tags.
class SearchArticles implements UseCase<List<Article>, SearchArticlesParams> {
  final ArticleRepository repository;

  const SearchArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(
    SearchArticlesParams params,
  ) async {
    try {
      AppLogger.info('Searching articles with query: "${params.query}"');

      if (params.query.trim().isEmpty) {
        AppLogger.warning('Search query is empty');
        return Left(ValidationFailure(message: 'Search query cannot be empty'));
      }

      if (params.query.trim().length < 2) {
        AppLogger.warning('Search query too short: "${params.query}"');
        return Left(
          ValidationFailure(
            message: 'Search query must be at least 2 characters long',
          ),
        );
      }

      // Search articles through repository
      final result = await repository.searchArticles(params.query.trim());

      return result.fold(
        (failure) {
          AppLogger.error('Failed to search articles: ${failure.message}');
          return Left(failure);
        },
        (articles) {
          AppLogger.info(
            'Successfully found ${articles.length} articles matching query: "${params.query}"',
          );
          return Right(articles);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error while searching articles',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to search articles: ${e.toString()}',
        ),
      );
    }
  }
}

/// Parameters for the SearchArticles use case
class SearchArticlesParams extends Equatable {
  final String query;

  const SearchArticlesParams({required this.query});

  @override
  List<Object?> get props => [query];
}
