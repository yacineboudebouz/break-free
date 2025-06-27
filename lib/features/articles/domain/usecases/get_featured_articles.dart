import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';
import 'base_usecase.dart';

/// Use case for retrieving featured articles
///
/// This use case handles fetching articles that are marked as featured
/// for highlighting on the main articles page.
class GetFeaturedArticles implements UseCaseNoParams<List<Article>> {
  final ArticleRepository repository;

  const GetFeaturedArticles(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call() async {
    try {
      AppLogger.info('Getting featured articles');

      // Get featured articles through repository
      final result = await repository.getFeaturedArticles();

      return result.fold(
        (failure) {
          AppLogger.error(
            'Failed to get featured articles: ${failure.message}',
          );
          return Left(failure);
        },
        (articles) {
          AppLogger.info(
            'Successfully retrieved ${articles.length} featured articles',
          );
          return Right(articles);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error while getting featured articles',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get featured articles: ${e.toString()}',
        ),
      );
    }
  }
}
