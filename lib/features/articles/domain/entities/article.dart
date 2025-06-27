import 'package:equatable/equatable.dart';

/// Represents the category of an article
enum ArticleCategory {
  motivation,
  tips,
  successStories,
  science,
  mindfulness,
  health,
  productivity,
  personal,
  addiction,
  general,
}

/// Represents the mood/tone of an article
enum ArticleMood {
  encouraging,
  inspiring,
  educational,
  calming,
  energizing,
  hopeful,
  practical,
}

/// Represents the difficulty level of reading
enum ArticleDifficulty { easy, medium, advanced }

/// Domain entity representing a pre-defined inspirational article
///
/// Articles are read-only content that provide motivation, tips,
/// success stories, and educational content to help users with their habits.
class Article extends Equatable {
  /// Unique identifier for the article
  final String id;

  /// Title of the article
  final String title;

  /// Brief summary or excerpt
  final String summary;

  /// Full content of the article (markdown supported)
  final String content;

  /// Author name
  final String author;

  /// Category the article belongs to
  final ArticleCategory category;

  /// Mood/tone of the article
  final ArticleMood mood;

  /// Reading difficulty level
  final ArticleDifficulty difficulty;

  /// Tags for better searchability
  final List<String> tags;

  /// Estimated reading time in minutes
  final int readTimeMinutes;

  /// Date when the article was published/added
  final DateTime publishedDate;

  /// Whether the article is featured/highlighted
  final bool isFeatured;

  /// URL to thumbnail image (optional)
  final String? thumbnailUrl;

  /// Quote or key takeaway from the article
  final String? keyQuote;

  /// Target audience (optional)
  final String? targetAudience;

  /// Source or reference (optional)
  final String? source;

  const Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.author,
    required this.category,
    required this.mood,
    required this.difficulty,
    required this.tags,
    required this.readTimeMinutes,
    required this.publishedDate,
    this.isFeatured = false,
    this.thumbnailUrl,
    this.keyQuote,
    this.targetAudience,
    this.source,
  });

  /// Creates a copy of this article with the given fields replaced with new values
  Article copyWith({
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
    return Article(
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

  /// Validates the article data
  ///
  /// Returns a list of validation errors, empty if valid
  List<String> validate() {
    final errors = <String>[];

    if (title.trim().isEmpty) {
      errors.add('Article title cannot be empty');
    }

    if (title.trim().length > 200) {
      errors.add('Article title cannot exceed 200 characters');
    }

    if (summary.trim().isEmpty) {
      errors.add('Article summary cannot be empty');
    }

    if (summary.trim().length > 500) {
      errors.add('Article summary cannot exceed 500 characters');
    }

    if (content.trim().isEmpty) {
      errors.add('Article content cannot be empty');
    }

    if (author.trim().isEmpty) {
      errors.add('Article author cannot be empty');
    }

    if (author.trim().length > 100) {
      errors.add('Article author name cannot exceed 100 characters');
    }

    if (readTimeMinutes <= 0) {
      errors.add('Read time must be greater than 0');
    }

    if (readTimeMinutes > 120) {
      errors.add('Read time cannot exceed 120 minutes');
    }

    if (publishedDate.isAfter(DateTime.now())) {
      errors.add('Published date cannot be in the future');
    }

    if (tags.isEmpty) {
      errors.add('Article must have at least one tag');
    }

    if (tags.length > 10) {
      errors.add('Article cannot have more than 10 tags');
    }

    for (final tag in tags) {
      if (tag.trim().isEmpty) {
        errors.add('Tags cannot be empty');
        break;
      }
      if (tag.trim().length > 50) {
        errors.add('Tag cannot exceed 50 characters');
        break;
      }
    }

    return errors;
  }

  /// Checks if the article is valid
  bool get isValid => validate().isEmpty;

  /// Gets a human-readable reading time description
  String get readTimeDescription {
    if (readTimeMinutes == 1) return '1 minute read';
    if (readTimeMinutes < 60) return '$readTimeMinutes minutes read';

    final hours = readTimeMinutes ~/ 60;
    final minutes = readTimeMinutes % 60;

    if (minutes == 0) {
      return hours == 1 ? '1 hour read' : '$hours hours read';
    }

    return '$hours hr $minutes min read';
  }

  /// Gets a human-readable difficulty description
  String get difficultyDescription {
    switch (difficulty) {
      case ArticleDifficulty.easy:
        return 'Easy read';
      case ArticleDifficulty.medium:
        return 'Medium read';
      case ArticleDifficulty.advanced:
        return 'Advanced read';
    }
  }

  /// Gets a user-friendly category name
  String get categoryDisplayName {
    switch (category) {
      case ArticleCategory.motivation:
        return 'Motivation';
      case ArticleCategory.tips:
        return 'Tips & Advice';
      case ArticleCategory.successStories:
        return 'Success Stories';
      case ArticleCategory.science:
        return 'Science & Research';
      case ArticleCategory.mindfulness:
        return 'Mindfulness';
      case ArticleCategory.health:
        return 'Health & Wellness';
      case ArticleCategory.productivity:
        return 'Productivity';
      case ArticleCategory.personal:
        return 'Personal Development';
      case ArticleCategory.addiction:
        return 'Addiction Recovery';
      case ArticleCategory.general:
        return 'General';
    }
  }

  /// Gets a user-friendly mood description
  String get moodDisplayName {
    switch (mood) {
      case ArticleMood.encouraging:
        return 'Encouraging';
      case ArticleMood.inspiring:
        return 'Inspiring';
      case ArticleMood.educational:
        return 'Educational';
      case ArticleMood.calming:
        return 'Calming';
      case ArticleMood.energizing:
        return 'Energizing';
      case ArticleMood.hopeful:
        return 'Hopeful';
      case ArticleMood.practical:
        return 'Practical';
    }
  }

  /// Gets an appropriate emoji for the category
  String get categoryEmoji {
    switch (category) {
      case ArticleCategory.motivation:
        return '💪';
      case ArticleCategory.tips:
        return '💡';
      case ArticleCategory.successStories:
        return '🎉';
      case ArticleCategory.science:
        return '🔬';
      case ArticleCategory.mindfulness:
        return '🧘';
      case ArticleCategory.health:
        return '🌱';
      case ArticleCategory.productivity:
        return '⚡';
      case ArticleCategory.personal:
        return '✨';
      case ArticleCategory.addiction:
        return '🛡️';
      case ArticleCategory.general:
        return '📖';
    }
  }

  /// Gets an appropriate emoji for the mood
  String get moodEmoji {
    switch (mood) {
      case ArticleMood.encouraging:
        return '👏';
      case ArticleMood.inspiring:
        return '🌟';
      case ArticleMood.educational:
        return '🎓';
      case ArticleMood.calming:
        return '🕊️';
      case ArticleMood.energizing:
        return '⚡';
      case ArticleMood.hopeful:
        return '🌈';
      case ArticleMood.practical:
        return '🔧';
    }
  }

  /// Checks if the article matches a search query
  bool matchesQuery(String query) {
    final lowerQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowerQuery) ||
        summary.toLowerCase().contains(lowerQuery) ||
        content.toLowerCase().contains(lowerQuery) ||
        author.toLowerCase().contains(lowerQuery) ||
        tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
  }

  /// Checks if the article contains any of the specified tags
  bool containsTags(List<String> searchTags) {
    final lowerSearchTags = searchTags.map((tag) => tag.toLowerCase()).toList();
    final lowerArticleTags = tags.map((tag) => tag.toLowerCase()).toList();

    return lowerSearchTags.any(
      (searchTag) =>
          lowerArticleTags.any((articleTag) => articleTag.contains(searchTag)),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    summary,
    content,
    author,
    category,
    mood,
    difficulty,
    tags,
    readTimeMinutes,
    publishedDate,
    isFeatured,
    thumbnailUrl,
    keyQuote,
    targetAudience,
    source,
  ];

  @override
  String toString() {
    return 'Article(id: $id, title: $title, category: $category, '
        'mood: $mood, readTime: $readTimeMinutes min)';
  }
}
