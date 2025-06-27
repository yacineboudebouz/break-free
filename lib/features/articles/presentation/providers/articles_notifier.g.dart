// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$articlesLoadingHash() => r'7c843a16c12dbbeb9b81c185c69cf635571e86a2';

/// Provider for articles loading state
///
/// Copied from [articlesLoading].
@ProviderFor(articlesLoading)
final articlesLoadingProvider = AutoDisposeProvider<bool>.internal(
  articlesLoading,
  name: r'articlesLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$articlesLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticlesLoadingRef = AutoDisposeProviderRef<bool>;
String _$articlesErrorHash() => r'c404156d9d5bf7d6e673d4ad6dd9692c8ece6d11';

/// Provider for articles error state
///
/// Copied from [articlesError].
@ProviderFor(articlesError)
final articlesErrorProvider = AutoDisposeProvider<String?>.internal(
  articlesError,
  name: r'articlesErrorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$articlesErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticlesErrorRef = AutoDisposeProviderRef<String?>;
String _$filteredArticlesHash() => r'ce15e6bf3719db45426bbfe4697b4616b4dfa70b';

/// Provider for filtered articles
///
/// Copied from [filteredArticles].
@ProviderFor(filteredArticles)
final filteredArticlesProvider = AutoDisposeProvider<List<Article>>.internal(
  filteredArticles,
  name: r'filteredArticlesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredArticlesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredArticlesRef = AutoDisposeProviderRef<List<Article>>;
String _$favoriteArticlesHash() => r'fdc1c1d4bd2142dfb7c8b7f9abd160fff17d3ba4';

/// Provider for favorite articles
///
/// Copied from [favoriteArticles].
@ProviderFor(favoriteArticles)
final favoriteArticlesProvider = AutoDisposeProvider<List<Article>>.internal(
  favoriteArticles,
  name: r'favoriteArticlesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteArticlesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteArticlesRef = AutoDisposeProviderRef<List<Article>>;
String _$articlesSearchQueryHash() =>
    r'cf0c12795fc0b1ccc456df3bfd9ce1398f36d367';

/// Provider for current search query
///
/// Copied from [articlesSearchQuery].
@ProviderFor(articlesSearchQuery)
final articlesSearchQueryProvider = AutoDisposeProvider<String>.internal(
  articlesSearchQuery,
  name: r'articlesSearchQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$articlesSearchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticlesSearchQueryRef = AutoDisposeProviderRef<String>;
String _$articlesFiltersHash() => r'ab16d0c57ebdf9a459222ca03d1e7fde3344c6e9';

/// Provider for current filters
///
/// Copied from [articlesFilters].
@ProviderFor(articlesFilters)
final articlesFiltersProvider = AutoDisposeProvider<ArticleFilters?>.internal(
  articlesFilters,
  name: r'articlesFiltersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$articlesFiltersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticlesFiltersRef = AutoDisposeProviderRef<ArticleFilters?>;
String _$articlesSearchHistoryHash() =>
    r'73633b7110ef4d29b852e10d016754359dc5d921';

/// Provider for search history
///
/// Copied from [articlesSearchHistory].
@ProviderFor(articlesSearchHistory)
final articlesSearchHistoryProvider =
    AutoDisposeProvider<List<String>>.internal(
      articlesSearchHistory,
      name: r'articlesSearchHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articlesSearchHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArticlesSearchHistoryRef = AutoDisposeProviderRef<List<String>>;
String _$articlesNotifierHash() => r'29983edc2faad412b0674cc9eae7cfce762eea86';

/// Notifier for managing articles state
///
/// Copied from [ArticlesNotifier].
@ProviderFor(ArticlesNotifier)
final articlesNotifierProvider =
    AutoDisposeNotifierProvider<ArticlesNotifier, ArticlesState>.internal(
      ArticlesNotifier.new,
      name: r'articlesNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$articlesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ArticlesNotifier = AutoDisposeNotifier<ArticlesState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
