import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/providers.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/article_local_data_source.dart';
import '../repositories/article_repository_impl.dart';

part 'data_providers.g.dart';

/// Provider for ArticleLocalDataSource
@riverpod
ArticleLocalDataSource articleLocalDataSource(ArticleLocalDataSourceRef ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return ArticleLocalDataSourceImpl(databaseService);
}

/// Provider for ArticleRepository implementation
@riverpod
ArticleRepository articleRepository(ArticleRepositoryRef ref) {
  final articleLocalDataSource = ref.watch(articleLocalDataSourceProvider);
  return ArticleRepositoryImpl(articleLocalDataSource: articleLocalDataSource);
}
