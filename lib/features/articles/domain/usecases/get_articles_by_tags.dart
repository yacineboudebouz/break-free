import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';
import 'base_usecase.dart';

/// Use case for retrieving articles by tags
///
/// This use case handles fetching articles that contain any of the specified tags.
class GetArticlesByTags
    implements UseCase<List<Article>, GetArticlesByTagsParams> {
  final ArticleRepository repository;

  const GetArticlesByTags(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(
    GetArticlesByTagsParams params,
  ) async {
    try {
      AppLogger.info('Getting articles by tags: ${params.tags.join(", ")}');

      if (params.tags.isEmpty) {
        AppLogger.warning('Tags list is empty');
        return Left(ValidationFailure(message: 'Tags list cannot be empty'));
      }

      // Validate tags
      for (final tag in params.tags) {
        if (tag.trim().isEmpty) {
          AppLogger.warning('Empty tag found in tags list');
          return Left(ValidationFailure(message: 'Tags cannot be empty'));
        }
      }

      // Get articles by tags through repository
      final result = await repository.getArticlesByTags(params.tags);

      return result.fold(
        (failure) {
          AppLogger.error('Failed to get articles by tags: ${failure.message}');
          return Left(failure);
        },
        (articles) {
          AppLogger.info(
            'Successfully retrieved ${articles.length} articles for tags: ${params.tags.join(", ")}',
          );
          return Right(articles);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error while getting articles by tags',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get articles by tags: ${e.toString()}',
        ),
      );
    }
  }
}

/// Parameters for the GetArticlesByTags use case
class GetArticlesByTagsParams extends Equatable {
  final List<String> tags;

  const GetArticlesByTagsParams({required this.tags});

  @override
  List<Object?> get props => [tags];
}
