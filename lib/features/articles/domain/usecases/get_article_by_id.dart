import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';
import 'base_usecase.dart';

/// Use case for retrieving a specific article by its ID
///
/// This use case handles fetching a single article for detailed view.
class GetArticleById implements UseCase<Article, GetArticleByIdParams> {
  final ArticleRepository repository;

  const GetArticleById(this.repository);

  @override
  Future<Either<Failure, Article>> call(GetArticleByIdParams params) async {
    try {
      AppLogger.info('Getting article by ID: ${params.articleId}');

      if (params.articleId.trim().isEmpty) {
        AppLogger.warning('Article ID is empty');
        return Left(ValidationFailure(message: 'Article ID cannot be empty'));
      }

      // Get the article through repository
      final result = await repository.getArticleById(params.articleId);

      return result.fold(
        (failure) {
          AppLogger.error('Failed to get article: ${failure.message}');
          return Left(failure);
        },
        (article) {
          AppLogger.info('Successfully retrieved article: ${article.title}');
          return Right(article);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error while getting article by ID',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to get article: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for the GetArticleById use case
class GetArticleByIdParams extends Equatable {
  final String articleId;

  const GetArticleByIdParams({required this.articleId});

  @override
  List<Object?> get props => [articleId];
}
