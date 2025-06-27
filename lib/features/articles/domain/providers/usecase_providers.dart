import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/providers/data_providers.dart';
import '../usecases/get_articles.dart';
import '../usecases/get_article_by_id.dart';
import '../usecases/get_articles_by_category.dart';
import '../usecases/get_articles_by_tags.dart';
import '../usecases/get_featured_articles.dart';
import '../usecases/search_articles.dart';

part 'usecase_providers.g.dart';

/// Provider for GetArticles use case
@riverpod
GetArticles getArticles(GetArticlesRef ref) {
  return GetArticles(ref.watch(articleRepositoryProvider));
}

/// Provider for GetArticleById use case
@riverpod
GetArticleById getArticleById(GetArticleByIdRef ref) {
  return GetArticleById(ref.watch(articleRepositoryProvider));
}

/// Provider for GetArticlesByCategory use case
@riverpod
GetArticlesByCategory getArticlesByCategory(GetArticlesByCategoryRef ref) {
  return GetArticlesByCategory(ref.watch(articleRepositoryProvider));
}

/// Provider for GetArticlesByTags use case
@riverpod
GetArticlesByTags getArticlesByTags(GetArticlesByTagsRef ref) {
  return GetArticlesByTags(ref.watch(articleRepositoryProvider));
}

/// Provider for GetFeaturedArticles use case
@riverpod
GetFeaturedArticles getFeaturedArticles(GetFeaturedArticlesRef ref) {
  return GetFeaturedArticles(ref.watch(articleRepositoryProvider));
}

/// Provider for SearchArticles use case
@riverpod
SearchArticles searchArticles(SearchArticlesRef ref) {
  return SearchArticles(ref.watch(articleRepositoryProvider));
}
