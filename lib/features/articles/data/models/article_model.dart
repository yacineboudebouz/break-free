import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/article.dart';

part 'article_model.g.dart';

/// Data model for Article entity with JSON and SQLite support
///
/// This model extends the domain Article entity and adds serialization
/// capabilities for database storage and JSON import/export.
/// Articles are read-only content, so this model focuses on efficient reading.
@JsonSerializable()
class ArticleModel extends Article {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.content,
    required super.author,
    required super.category,
    required super.mood,
    required super.difficulty,
    required super.tags,
    required super.readTimeMinutes,
    required super.publishedDate,
    super.isFeatured = false,
    super.thumbnailUrl,
    super.keyQuote,
    super.targetAudience,
    super.source,
  });

  /// Creates an ArticleModel from an Article entity
  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      id: article.id,
      title: article.title,
      summary: article.summary,
      content: article.content,
      author: article.author,
      category: article.category,
      mood: article.mood,
      difficulty: article.difficulty,
      tags: article.tags,
      readTimeMinutes: article.readTimeMinutes,
      publishedDate: article.publishedDate,
      isFeatured: article.isFeatured,
      thumbnailUrl: article.thumbnailUrl,
      keyQuote: article.keyQuote,
      targetAudience: article.targetAudience,
      source: article.source,
    );
  }

  /// Creates an ArticleModel from JSON
  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  /// Converts this model to JSON
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  /// Creates an ArticleModel from a SQLite database map
  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    // Parse tags from comma-separated string
    final tagsString = map['tags'] as String? ?? '';
    final tagsList = tagsString.isEmpty
        ? <String>[]
        : tagsString
              .split(',')
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty)
              .toList();

    return ArticleModel(
      id: map['id'] as String,
      title: map['title'] as String,
      summary: map['summary'] as String,
      content: map['content'] as String,
      author: map['author'] as String,
      category: ArticleCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ArticleCategory.general,
      ),
      mood: ArticleMood.values.firstWhere(
        (e) => e.name == map['mood'],
        orElse: () => ArticleMood.encouraging,
      ),
      difficulty: ArticleDifficulty.values.firstWhere(
        (e) => e.name == map['difficulty'],
        orElse: () => ArticleDifficulty.medium,
      ),
      tags: tagsList,
      readTimeMinutes: map['read_time_minutes'] as int,
      publishedDate: DateTime.fromMillisecondsSinceEpoch(
        map['published_date'] as int,
      ),
      isFeatured: (map['is_featured'] as int? ?? 0) == 1,
      thumbnailUrl: map['thumbnail_url'] as String?,
      keyQuote: map['key_quote'] as String?,
      targetAudience: map['target_audience'] as String?,
      source: map['source'] as String?,
    );
  }

  /// Converts this model to a SQLite database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'author': author,
      'category': category.name,
      'mood': mood.name,
      'difficulty': difficulty.name,
      'tags': tags.join(','), // Store as comma-separated string
      'read_time_minutes': readTimeMinutes,
      'published_date': publishedDate.millisecondsSinceEpoch,
      'is_featured': isFeatured ? 1 : 0,
      'thumbnail_url': thumbnailUrl,
      'key_quote': keyQuote,
      'target_audience': targetAudience,
      'source': source,
    };
  }

  /// Creates a copy of this model with updated values
  @override
  ArticleModel copyWith({
    String? id,
    String? title,
    String? summary,
    String? content,
    String? author,
    ArticleCategory? category,
    ArticleMood? mood,
    ArticleDifficulty? difficulty,
    List<String>? tags,
    int? readTimeMinutes,
    DateTime? publishedDate,
    bool? isFeatured,
    String? thumbnailUrl,
    String? keyQuote,
    String? targetAudience,
    String? source,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      author: author ?? this.author,
      category: category ?? this.category,
      mood: mood ?? this.mood,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      readTimeMinutes: readTimeMinutes ?? this.readTimeMinutes,
      publishedDate: publishedDate ?? this.publishedDate,
      isFeatured: isFeatured ?? this.isFeatured,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      keyQuote: keyQuote ?? this.keyQuote,
      targetAudience: targetAudience ?? this.targetAudience,
      source: source ?? this.source,
    );
  }

  /// Converts this model to a domain entity
  Article toEntity() {
    return Article(
      id: id,
      title: title,
      summary: summary,
      content: content,
      author: author,
      category: category,
      mood: mood,
      difficulty: difficulty,
      tags: tags,
      readTimeMinutes: readTimeMinutes,
      publishedDate: publishedDate,
      isFeatured: isFeatured,
      thumbnailUrl: thumbnailUrl,
      keyQuote: keyQuote,
      targetAudience: targetAudience,
      source: source,
    );
  }

  @override
  String toString() {
    return 'ArticleModel(id: $id, title: $title, category: $category, '
        'mood: $mood, readTime: $readTimeMinutes min, featured: $isFeatured)';
  }
}
