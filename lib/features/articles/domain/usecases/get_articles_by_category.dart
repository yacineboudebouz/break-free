import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';
import 'base_usecase.dart';

/// Use case for retrieving articles by category
///
/// This use case handles fetching articles filtered by a specific category.
class GetArticlesByCategory
    implements UseCase<List<Article>, GetArticlesByCategoryParams> {
  final ArticleRepository repository;

  const GetArticlesByCategory(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(
    GetArticlesByCategoryParams params,
  ) async {
    try {
      AppLogger.info('Getting articles by category: ${params.category.name}');

      // Get articles by category through repository
      final result = await repository.getArticlesByCategory(params.category);

      return result.fold(
        (failure) {
          AppLogger.error(
            'Failed to get articles by category: ${failure.message}',
          );
          return Left(failure);
        },
        (articles) {
          AppLogger.info(
            'Successfully retrieved ${articles.length} articles for category: ${params.category.name}',
          );
          return Right(articles);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error while getting articles by category',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get articles by category: ${e.toString()}',
        ),
      );
    }
  }
}

/// Parameters for the GetArticlesByCategory use case
class GetArticlesByCategoryParams extends Equatable {
  final ArticleCategory category;

  const GetArticlesByCategoryParams({required this.category});

  @override
  List<Object?> get props => [category];
}
