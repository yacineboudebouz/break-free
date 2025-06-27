import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/logger.dart';

part 'search_notifier.g.dart';

/// State class for global search management
class SearchState {
  final String query;
  final List<String> history;
  final List<String> suggestions;
  final bool isActive;
  final SearchScope scope;

  const SearchState({
    this.query = '',
    this.history = const [],
    this.suggestions = const [],
    this.isActive = false,
    this.scope = SearchScope.all,
  });

  SearchState copyWith({
    String? query,
    List<String>? history,
    List<String>? suggestions,
    bool? isActive,
    SearchScope? scope,
  }) {
    return SearchState(
      query: query ?? this.query,
      history: history ?? this.history,
      suggestions: suggestions ?? this.suggestions,
      isActive: isActive ?? this.isActive,
      scope: scope ?? this.scope,
    );
  }

  @override
  String toString() {
    return 'SearchState(query: $query, isActive: $isActive, scope: $scope, history: ${history.length} items)';
  }
}

/// Search scope enum for filtering search results
enum SearchScope { all, habits, articles }

/// Notifier for managing global search state
@riverpod
class SearchNotifier extends _$SearchNotifier {
  static final _logger = AppLogger.getLogger('SearchNotifier');

  @override
  SearchState build() {
    _logger.d('Building SearchNotifier');
    return const SearchState();
  }

  /// Update search query
  void updateQuery(String query) {
    _logger.d('Updating search query: "$query"');
    state = state.copyWith(query: query);

    // Generate suggestions based on history
    if (query.isNotEmpty) {
      final suggestions = state.history
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .take(5)
          .toList();

      state = state.copyWith(suggestions: suggestions);
    } else {
      state = state.copyWith(suggestions: []);
    }
  }

  /// Execute search and add to history
  void executeSearch(String query) {
    if (query.trim().isEmpty) return;

    _logger.d('Executing search: "$query"');

    // Add to history if not already present
    List<String> updatedHistory = List.from(state.history);
    updatedHistory.removeWhere((item) => item == query); // Remove if exists
    updatedHistory.insert(0, query); // Add to beginning

    // Keep only last 20 searches
    if (updatedHistory.length > 20) {
      updatedHistory = updatedHistory.take(20).toList();
    }

    state = state.copyWith(
      query: query,
      history: updatedHistory,
      suggestions: [],
    );
  }

  /// Activate search mode
  void activateSearch() {
    _logger.d('Activating search');
    state = state.copyWith(isActive: true);
  }

  /// Deactivate search mode
  void deactivateSearch() {
    _logger.d('Deactivating search');
    state = state.copyWith(isActive: false, query: '', suggestions: []);
  }

  /// Change search scope
  void changeScope(SearchScope scope) {
    _logger.d('Changing search scope to: $scope');
    state = state.copyWith(scope: scope);
  }

  /// Clear search query
  void clearQuery() {
    _logger.d('Clearing search query');
    state = state.copyWith(query: '', suggestions: []);
  }

  /// Clear search history
  void clearHistory() {
    _logger.d('Clearing search history');
    state = state.copyWith(history: [], suggestions: []);
  }

  /// Remove item from history
  void removeFromHistory(String item) {
    _logger.d('Removing from history: "$item"');
    final updatedHistory = state.history.where((h) => h != item).toList();
    state = state.copyWith(history: updatedHistory);
  }

  /// Get recent searches (last 5)
  List<String> getRecentSearches() {
    return state.history.take(5).toList();
  }

  /// Get suggestions based on current query
  List<String> getSuggestions() {
    return state.suggestions;
  }
}
