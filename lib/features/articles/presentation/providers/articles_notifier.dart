import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/logger.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../../domain/providers/usecase_providers.dart';
import '../../domain/usecases/get_articles.dart';
import '../../domain/usecases/search_articles.dart';

part 'articles_notifier.g.dart';

/// State class for articles management
class ArticlesState {
  final List<Article> articles;
  final List<Article> filteredArticles;
  final List<Article> favoriteArticles;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final ArticleFilters? filters;
  final bool isSearching;
  final List<String> searchHistory;

  const ArticlesState({
    this.articles = const [],
    this.filteredArticles = const [],
    this.favoriteArticles = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.filters,
    this.isSearching = false,
    this.searchHistory = const [],
  });

  ArticlesState copyWith({
    List<Article>? articles,
    List<Article>? filteredArticles,
    List<Article>? favoriteArticles,
    bool? isLoading,
    String? error,
    String? searchQuery,
    ArticleFilters? filters,
    bool? isSearching,
    List<String>? searchHistory,
    bool clearError = false,
  }) {
    return ArticlesState(
      articles: articles ?? this.articles,
      filteredArticles: filteredArticles ?? this.filteredArticles,
      favoriteArticles: favoriteArticles ?? this.favoriteArticles,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters ?? this.filters,
      isSearching: isSearching ?? this.isSearching,
      searchHistory: searchHistory ?? this.searchHistory,
    );
  }

  @override
  String toString() {
    return 'ArticlesState(articles: ${articles.length}, filteredArticles: ${filteredArticles.length}, isLoading: $isLoading, error: $error, searchQuery: $searchQuery)';
  }
}

/// Notifier for managing articles state
@riverpod
class ArticlesNotifier extends _$ArticlesNotifier {
  static final _logger = AppLogger.getLogger('ArticlesNotifier');

  @override
  ArticlesState build() {
    _logger.d('Building ArticlesNotifier');
    // Load articles on initialization
    _loadArticles();
    return const ArticlesState();
  }

  /// Load all articles
  Future<void> _loadArticles() async {
    try {
      _logger.d('Loading articles');
      state = state.copyWith(isLoading: true, clearError: true);

      final getArticlesUseCase = ref.read(getArticlesProvider);
      final result = await getArticlesUseCase(const GetArticlesParams());

      result.fold(
        (failure) {
          _logger.e('Failed to load articles: ${failure.message}');
          state = state.copyWith(isLoading: false, error: failure.message);
        },
        (articles) {
          _logger.i('Successfully loaded ${articles.length} articles');
          state = state.copyWith(
            isLoading: false,
            articles: articles,
            filteredArticles: articles,
          );
        },
      );
    } catch (e, stackTrace) {
      _logger.e(
        'Unexpected error loading articles: $e',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load articles: ${e.toString()}',
      );
    }
  }

  /// Refresh articles data
  Future<void> refreshArticles() async {
    _logger.d('Refreshing articles');
    await _loadArticles();
  }

  /// Search articles by query
  Future<void> searchArticles(String query) async {
    try {
      _logger.d('Searching articles with query: "$query"');

      if (query.trim().isEmpty) {
        // Reset to show all articles
        state = state.copyWith(
          searchQuery: '',
          filteredArticles: state.articles,
          isSearching: false,
          clearError: true,
        );
        return;
      }

      state = state.copyWith(
        isSearching: true,
        searchQuery: query,
        clearError: true,
      );

      final searchUseCase = ref.read(searchArticlesProvider);
      final result = await searchUseCase(SearchArticlesParams(query: query));

      result.fold(
        (failure) {
          _logger.e('Failed to search articles: ${failure.message}');
          state = state.copyWith(isSearching: false, error: failure.message);
        },
        (articles) {
          _logger.i('Found ${articles.length} articles for query: "$query"');

          // Add to search history if not empty results
          List<String> updatedHistory = List.from(state.searchHistory);
          if (articles.isNotEmpty && !updatedHistory.contains(query)) {
            updatedHistory.insert(0, query);
            if (updatedHistory.length > 10) {
              updatedHistory = updatedHistory.take(10).toList();
            }
          }

          state = state.copyWith(
            isSearching: false,
            filteredArticles: articles,
            searchHistory: updatedHistory,
          );
        },
      );
    } catch (e, stackTrace) {
      _logger.e(
        'Unexpected error searching articles: $e',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isSearching: false,
        error: 'Failed to search articles: ${e.toString()}',
      );
    }
  }

  /// Apply filters to articles
  Future<void> applyFilters(ArticleFilters filters) async {
    try {
      _logger.d('Applying filters: ${filters.activeFiltersDescription}');

      state = state.copyWith(
        isLoading: true,
        filters: filters,
        clearError: true,
      );

      final getArticlesUseCase = ref.read(getArticlesProvider);
      final result = await getArticlesUseCase(
        GetArticlesParams(filters: filters),
      );

      result.fold(
        (failure) {
          _logger.e('Failed to apply filters: ${failure.message}');
          state = state.copyWith(isLoading: false, error: failure.message);
        },
        (articles) {
          _logger.i('Applied filters, found ${articles.length} articles');
          state = state.copyWith(isLoading: false, filteredArticles: articles);
        },
      );
    } catch (e, stackTrace) {
      _logger.e(
        'Unexpected error applying filters: $e',
        error: e,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to apply filters: ${e.toString()}',
      );
    }
  }

  /// Clear all filters
  void clearFilters() {
    _logger.d('Clearing filters');
    state = state.copyWith(filters: null, filteredArticles: state.articles);
  }

  /// Clear search
  void clearSearch() {
    _logger.d('Clearing search');
    state = state.copyWith(searchQuery: '', filteredArticles: state.articles);
  }

  /// Toggle article as favorite (optional feature)
  void toggleFavorite(String articleId) {
    _logger.d('Toggling favorite for article: $articleId');

    final favorites = List<Article>.from(state.favoriteArticles);
    final existingIndex = favorites.indexWhere(
      (article) => article.id == articleId,
    );

    if (existingIndex >= 0) {
      // Remove from favorites
      favorites.removeAt(existingIndex);
      _logger.d('Removed article from favorites: $articleId');
    } else {
      // Add to favorites
      final article = state.articles.firstWhere(
        (article) => article.id == articleId,
        orElse: () => state.filteredArticles.firstWhere(
          (article) => article.id == articleId,
        ),
      );
      favorites.add(article);
      _logger.d('Added article to favorites: $articleId');
    }

    state = state.copyWith(favoriteArticles: favorites);
  }

  /// Clear search history
  void clearSearchHistory() {
    _logger.d('Clearing search history');
    state = state.copyWith(searchHistory: const []);
  }

  /// Get article by ID
  Article? getArticleById(String id) {
    return state.articles.cast<Article?>().firstWhere(
      (article) => article?.id == id,
      orElse: () => null,
    );
  }
}

// Convenience providers for specific states

/// Provider for articles loading state
@riverpod
bool articlesLoading(ArticlesLoadingRef ref) {
  return ref.watch(articlesNotifierProvider.select((state) => state.isLoading));
}

/// Provider for articles error state
@riverpod
String? articlesError(ArticlesErrorRef ref) {
  return ref.watch(articlesNotifierProvider.select((state) => state.error));
}

/// Provider for filtered articles
@riverpod
List<Article> filteredArticles(FilteredArticlesRef ref) {
  return ref.watch(
    articlesNotifierProvider.select((state) => state.filteredArticles),
  );
}

/// Provider for favorite articles
@riverpod
List<Article> favoriteArticles(FavoriteArticlesRef ref) {
  return ref.watch(
    articlesNotifierProvider.select((state) => state.favoriteArticles),
  );
}

/// Provider for current search query
@riverpod
String articlesSearchQuery(ArticlesSearchQueryRef ref) {
  return ref.watch(
    articlesNotifierProvider.select((state) => state.searchQuery),
  );
}

/// Provider for current filters
@riverpod
ArticleFilters? articlesFilters(ArticlesFiltersRef ref) {
  return ref.watch(articlesNotifierProvider.select((state) => state.filters));
}

/// Provider for search history
@riverpod
List<String> articlesSearchHistory(ArticlesSearchHistoryRef ref) {
  return ref.watch(
    articlesNotifierProvider.select((state) => state.searchHistory),
  );
}
