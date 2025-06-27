import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/datasources.dart';

/// Implementation of ArticleRepository using local data source
class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleLocalDataSource _articleLocalDataSource;

  ArticleRepositoryImpl({
    required ArticleLocalDataSource articleLocalDataSource,
  }) : _articleLocalDataSource = articleLocalDataSource;

  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    try {
      AppLogger.debug('Repository: Getting all articles');

      final articleModels = await _articleLocalDataSource.getAllArticles();
      final articles = articleModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Successfully retrieved ${articles.length} articles',
      );
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting all articles',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting all articles',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to get articles: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Article>> getArticleById(String id) async {
    try {
      AppLogger.debug('Repository: Getting article by ID: $id');

      if (id.trim().isEmpty) {
        AppLogger.warning('Repository: Empty article ID provided');
        return Left(ValidationFailure(message: 'Article ID cannot be empty'));
      }

      final articleModel = await _articleLocalDataSource.getArticleById(id);

      if (articleModel == null) {
        AppLogger.debug('Repository: Article not found with ID: $id');
        return Left(ValidationFailure(message: 'Article not found'));
      }

      final article = articleModel.toEntity();
      AppLogger.debug('Repository: Found article with ID: $id');
      return Right(article);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting article by ID: $id',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting article by ID: $id',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(message: 'Failed to get article: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> searchArticles(String query) async {
    try {
      AppLogger.debug('Repository: Searching articles with query: $query');

      if (query.trim().isEmpty) {
        AppLogger.debug(
          'Repository: Empty search query, returning all articles',
        );
        return getArticles();
      }

      final articleModels = await _articleLocalDataSource.searchArticles(
        query.trim(),
      );
      final articles = articleModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Search found ${articles.length} articles for query: $query',
      );
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error searching articles: $query',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error searching articles: $query',
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

  @override
  Future<Either<Failure, List<Article>>> getArticlesByCategory(
    ArticleCategory category,
  ) async {
    try {
      AppLogger.debug(
        'Repository: Getting articles by category: ${category.name}',
      );

      final articleModels = await _articleLocalDataSource.getArticlesByCategory(
        category.name,
      );
      final articles = articleModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Found ${articles.length} articles in category: ${category.name}',
      );
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting articles by category: ${category.name}',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting articles by category: ${category.name}',
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

  @override
  Future<Either<Failure, List<Article>>> getArticlesByTags(
    List<String> tags,
  ) async {
    try {
      AppLogger.debug(
        'Repository: Getting articles by tags: ${tags.join(", ")}',
      );

      if (tags.isEmpty) {
        AppLogger.debug('Repository: No tags provided, returning all articles');
        return getArticles();
      }

      final articleModels = await _articleLocalDataSource.getArticlesByTags(
        tags,
      );
      final articles = articleModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Found ${articles.length} articles with tags: ${tags.join(", ")}',
      );
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting articles by tags: ${tags.join(", ")}',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting articles by tags: ${tags.join(", ")}',
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

  @override
  Future<Either<Failure, List<Article>>> getArticlesByMood(
    ArticleMood mood,
  ) async {
    try {
      AppLogger.debug('Repository: Getting articles by mood: ${mood.name}');

      final articleModels = await _articleLocalDataSource.getArticlesByMood(
        mood.name,
      );
      final articles = articleModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Found ${articles.length} articles for mood: ${mood.name}',
      );
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting articles by mood: ${mood.name}',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting articles by mood: ${mood.name}',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get articles by mood: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getArticlesByDifficulty(
    ArticleDifficulty difficulty,
  ) async {
    try {
      AppLogger.debug(
        'Repository: Getting articles by difficulty: ${difficulty.name}',
      );

      final articleModels = await _articleLocalDataSource
          .getArticlesByDifficulty(difficulty.name);
      final articles = articleModels.map((model) => model.toEntity()).toList();

      AppLogger.debug(
        'Repository: Found ${articles.length} articles for difficulty: ${difficulty.name}',
      );
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting articles by difficulty: ${difficulty.name}',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting articles by difficulty: ${difficulty.name}',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get articles by difficulty: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getFeaturedArticles() async {
    try {
      AppLogger.debug('Repository: Getting featured articles');

      final articleModels = await _articleLocalDataSource.getFeaturedArticles();
      final articles = articleModels.map((model) => model.toEntity()).toList();

      AppLogger.debug('Repository: Found ${articles.length} featured articles');
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting featured articles',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting featured articles',
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

  @override
  Future<Either<Failure, List<Article>>> getArticlesWithFilters(
    ArticleFilters filters,
  ) async {
    try {
      AppLogger.debug(
        'Repository: Getting articles with filters: ${filters.activeFiltersDescription}',
      );

      // Start with all articles and apply filters progressively
      final allModels = await _articleLocalDataSource.getAllArticles();
      var articles = allModels.map((model) => model.toEntity()).toList();

      // Apply category filter
      if (filters.category != null) {
        articles = articles
            .where((article) => article.category == filters.category)
            .toList();
      }

      // Apply mood filter
      if (filters.mood != null) {
        articles = articles
            .where((article) => article.mood == filters.mood)
            .toList();
      }

      // Apply difficulty filter
      if (filters.difficulty != null) {
        articles = articles
            .where((article) => article.difficulty == filters.difficulty)
            .toList();
      }

      // Apply read time filters
      if (filters.minReadTime != null) {
        articles = articles
            .where((article) => article.readTimeMinutes >= filters.minReadTime!)
            .toList();
      }
      if (filters.maxReadTime != null) {
        articles = articles
            .where((article) => article.readTimeMinutes <= filters.maxReadTime!)
            .toList();
      }

      // Apply featured filter
      if (filters.isFeatured != null) {
        articles = articles
            .where((article) => article.isFeatured == filters.isFeatured)
            .toList();
      }

      // Apply tags filter
      if (filters.tags != null && filters.tags!.isNotEmpty) {
        articles = articles.where((article) {
          return filters.tags!.any((tag) => article.tags.contains(tag));
        }).toList();
      }

      // Apply search query filter
      if (filters.searchQuery != null &&
          filters.searchQuery!.trim().isNotEmpty) {
        final query = filters.searchQuery!.toLowerCase();
        articles = articles.where((article) {
          return article.title.toLowerCase().contains(query) ||
              article.summary.toLowerCase().contains(query) ||
              article.content.toLowerCase().contains(query) ||
              article.author.toLowerCase().contains(query) ||
              article.tags.any((tag) => tag.toLowerCase().contains(query));
        }).toList();
      }

      AppLogger.debug(
        'Repository: Found ${articles.length} articles with applied filters',
      );
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting articles with filters',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting articles with filters',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get articles with filters: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Map<ArticleCategory, int>>> getCategoryStats() async {
    try {
      AppLogger.debug('Repository: Getting category statistics');

      final articleModels = await _articleLocalDataSource.getAllArticles();
      final articles = articleModels.map((model) => model.toEntity()).toList();

      final categoryStats = <ArticleCategory, int>{};
      for (final article in articles) {
        categoryStats[article.category] =
            (categoryStats[article.category] ?? 0) + 1;
      }

      AppLogger.debug(
        'Repository: Successfully calculated category statistics',
      );
      return Right(categoryStats);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting category statistics',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting category statistics',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get category statistics: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Map<String, int>>> getTagStats() async {
    try {
      AppLogger.debug('Repository: Getting tag statistics');

      final articleModels = await _articleLocalDataSource.getAllArticles();
      final articles = articleModels.map((model) => model.toEntity()).toList();

      final tagStats = <String, int>{};
      for (final article in articles) {
        for (final tag in article.tags) {
          tagStats[tag] = (tagStats[tag] ?? 0) + 1;
        }
      }

      AppLogger.debug('Repository: Successfully calculated tag statistics');
      return Right(tagStats);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting tag statistics',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting tag statistics',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get tag statistics: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getArticlesByReadTime(
    int minMinutes,
    int maxMinutes,
  ) async {
    try {
      AppLogger.debug(
        'Repository: Getting articles by read time: $minMinutes-$maxMinutes minutes',
      );

      if (minMinutes < 0 || maxMinutes < 0 || minMinutes > maxMinutes) {
        return Left(ValidationFailure(message: 'Invalid read time range'));
      }

      final articleModels = await _articleLocalDataSource.getAllArticles();
      final articles = articleModels
          .map((model) => model.toEntity())
          .where(
            (article) =>
                article.readTimeMinutes >= minMinutes &&
                article.readTimeMinutes <= maxMinutes,
          )
          .toList();

      AppLogger.debug(
        'Repository: Found ${articles.length} articles in read time range: $minMinutes-$maxMinutes minutes',
      );
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting articles by read time',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting articles by read time',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get articles by read time: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getRecentArticles({
    int limit = 10,
  }) async {
    try {
      AppLogger.debug('Repository: Getting recent articles (limit: $limit)');

      final articleModels = await _articleLocalDataSource.getAllArticles();
      var articles = articleModels.map((model) => model.toEntity()).toList();

      // Sort by published date (most recent first)
      articles.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));

      if (articles.length > limit) {
        articles = articles.take(limit).toList();
      }

      AppLogger.debug('Repository: Found ${articles.length} recent articles');
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting recent articles',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting recent articles',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get recent articles: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getRandomArticles(int count) async {
    try {
      AppLogger.debug('Repository: Getting random articles (count: $count)');

      if (count <= 0) {
        return Left(ValidationFailure(message: 'Count must be positive'));
      }

      final articleModels = await _articleLocalDataSource.getAllArticles();
      var articles = articleModels.map((model) => model.toEntity()).toList();

      // Shuffle and take the requested count
      articles.shuffle();
      if (articles.length > count) {
        articles = articles.take(count).toList();
      }

      AppLogger.debug('Repository: Found ${articles.length} random articles');
      return Right(articles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting random articles',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting random articles',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get random articles: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getRecommendedArticles(
    List<String> habitCategories, {
    int limit = 5,
  }) async {
    try {
      AppLogger.debug(
        'Repository: Getting recommended articles for categories: ${habitCategories.join(", ")} (limit: $limit)',
      );

      if (habitCategories.isEmpty) {
        AppLogger.debug(
          'Repository: No habit categories provided, returning featured articles',
        );
        return getFeaturedArticles();
      }

      final articleModels = await _articleLocalDataSource.getAllArticles();
      var articles = articleModels.map((model) => model.toEntity()).toList();

      // Filter articles that match habit categories (simple matching by name)
      final relevantArticles = articles.where((article) {
        final categoryName = article.category.name.toLowerCase();
        return habitCategories.any(
          (habitCategory) =>
              categoryName.contains(habitCategory.toLowerCase()) ||
              habitCategory.toLowerCase().contains(categoryName),
        );
      }).toList();

      // If we don't have enough relevant articles, add some featured ones
      if (relevantArticles.length < limit) {
        final featuredArticles = articles
            .where(
              (article) =>
                  article.isFeatured && !relevantArticles.contains(article),
            )
            .toList();
        relevantArticles.addAll(featuredArticles);
      }

      // Sort by difficulty (easier first) and take the limit
      relevantArticles.sort(
        (a, b) => a.difficulty.index.compareTo(b.difficulty.index),
      );

      if (relevantArticles.length > limit) {
        relevantArticles.removeRange(limit, relevantArticles.length);
      }

      AppLogger.debug(
        'Repository: Found ${relevantArticles.length} recommended articles',
      );
      return Right(relevantArticles);
    } on DatabaseException catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Database error getting recommended articles',
        e,
        stackTrace,
      );
      return Left(DatabaseFailure(message: e.message));
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'Repository: Unexpected error getting recommended articles',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get recommended articles: ${e.toString()}',
        ),
      );
    }
  }
}
