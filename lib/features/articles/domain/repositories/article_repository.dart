import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../entities/article.dart';

/// Repository interface for article management (read-only)
///
/// This abstract class defines the contract for article data operations.
/// Articles are pre-defined content, so this repository only provides
/// read operations with various filtering and search capabilities.
abstract class ArticleRepository {
  /// Retrieves all articles
  ///
  /// Returns `Right` with list of articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getArticles();

  /// Retrieves articles filtered by category
  ///
  /// [category] - The category to filter by
  /// Returns `Right` with filtered list of articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getArticlesByCategory(
    ArticleCategory category,
  );

  /// Retrieves articles filtered by mood
  ///
  /// [mood] - The mood to filter by
  /// Returns `Right` with filtered list of articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getArticlesByMood(ArticleMood mood);

  /// Retrieves articles filtered by difficulty level
  ///
  /// [difficulty] - The difficulty level to filter by
  /// Returns `Right` with filtered list of articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getArticlesByDifficulty(
    ArticleDifficulty difficulty,
  );

  /// Retrieves articles that contain any of the specified tags
  ///
  /// [tags] - List of tags to search for
  /// Returns `Right` with articles containing any of the tags on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getArticlesByTags(List<String> tags);

  /// Retrieves a specific article by ID
  ///
  /// [id] - The unique identifier of the article
  /// Returns `Right` with the article on success
  /// Returns `Left` with `Failure` on error (including not found)
  Future<Either<Failure, Article>> getArticleById(String id);

  /// Searches articles by text query
  ///
  /// [query] - The search term (searches title, summary, content, author, tags)
  /// Returns `Right` with list of matching articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> searchArticles(String query);

  /// Retrieves featured articles
  ///
  /// Returns `Right` with list of featured articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getFeaturedArticles();

  /// Retrieves articles with multiple filters
  ///
  /// [filters] - The filters to apply
  /// Returns `Right` with filtered list of articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getArticlesWithFilters(
    ArticleFilters filters,
  );

  /// Gets all available categories with article counts
  ///
  /// Returns `Right` with map of categories and their article counts on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, Map<ArticleCategory, int>>> getCategoryStats();

  /// Gets all available tags with usage counts
  ///
  /// Returns `Right` with map of tags and their usage counts on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, Map<String, int>>> getTagStats();

  /// Gets articles for a specific reading time range
  ///
  /// [minMinutes] - Minimum reading time in minutes
  /// [maxMinutes] - Maximum reading time in minutes
  /// Returns `Right` with articles in the time range on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getArticlesByReadTime(
    int minMinutes,
    int maxMinutes,
  );

  /// Gets recently published articles (based on publishedDate)
  ///
  /// [limit] - Maximum number of articles to return
  /// Returns `Right` with recently published articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getRecentArticles({int limit = 10});

  /// Gets random articles for discovery
  ///
  /// [count] - Number of random articles to return
  /// Returns `Right` with random articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getRandomArticles(int count);

  /// Gets article recommendations based on user's habit categories
  ///
  /// [habitCategories] - List of habit categories the user is working on
  /// [limit] - Maximum number of recommendations
  /// Returns `Right` with recommended articles on success
  /// Returns `Left` with `Failure` on error
  Future<Either<Failure, List<Article>>> getRecommendedArticles(
    List<String> habitCategories, {
    int limit = 5,
  });
}

/// Filters for article queries
class ArticleFilters extends Equatable {
  final ArticleCategory? category;
  final ArticleMood? mood;
  final ArticleDifficulty? difficulty;
  final List<String>? tags;
  final int? minReadTime;
  final int? maxReadTime;
  final bool? isFeatured;
  final String? searchQuery;

  const ArticleFilters({
    this.category,
    this.mood,
    this.difficulty,
    this.tags,
    this.minReadTime,
    this.maxReadTime,
    this.isFeatured,
    this.searchQuery,
  });

  /// Creates a copy with the given fields replaced
  ArticleFilters copyWith({
    ArticleCategory? category,
    ArticleMood? mood,
    ArticleDifficulty? difficulty,
    List<String>? tags,
    int? minReadTime,
    int? maxReadTime,
    bool? isFeatured,
    String? searchQuery,
  }) {
    return ArticleFilters(
      category: category ?? this.category,
      mood: mood ?? this.mood,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      minReadTime: minReadTime ?? this.minReadTime,
      maxReadTime: maxReadTime ?? this.maxReadTime,
      isFeatured: isFeatured ?? this.isFeatured,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  /// Checks if any filters are applied
  bool get hasActiveFilters {
    return category != null ||
        mood != null ||
        difficulty != null ||
        (tags != null && tags!.isNotEmpty) ||
        minReadTime != null ||
        maxReadTime != null ||
        isFeatured != null ||
        (searchQuery != null && searchQuery!.trim().isNotEmpty);
  }

  /// Gets a description of active filters
  String get activeFiltersDescription {
    final activeFilters = <String>[];

    if (category != null) {
      activeFilters.add('Category: ${category!.name}');
    }
    if (mood != null) {
      activeFilters.add('Mood: ${mood!.name}');
    }
    if (difficulty != null) {
      activeFilters.add('Difficulty: ${difficulty!.name}');
    }
    if (tags != null && tags!.isNotEmpty) {
      activeFilters.add('Tags: ${tags!.join(', ')}');
    }
    if (minReadTime != null || maxReadTime != null) {
      final min = minReadTime ?? 0;
      final max = maxReadTime ?? 999;
      activeFilters.add('Read time: $min-$max min');
    }
    if (isFeatured == true) {
      activeFilters.add('Featured only');
    }
    if (searchQuery != null && searchQuery!.trim().isNotEmpty) {
      activeFilters.add('Search: "${searchQuery!.trim()}"');
    }

    return activeFilters.isEmpty ? 'No filters' : activeFilters.join(', ');
  }

  @override
  List<Object?> get props => [
    category,
    mood,
    difficulty,
    tags,
    minReadTime,
    maxReadTime,
    isFeatured,
    searchQuery,
  ];
}
