// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
  id: json['id'] as String,
  title: json['title'] as String,
  summary: json['summary'] as String,
  content: json['content'] as String,
  author: json['author'] as String,
  category: $enumDecode(_$ArticleCategoryEnumMap, json['category']),
  mood: $enumDecode(_$ArticleMoodEnumMap, json['mood']),
  difficulty: $enumDecode(_$ArticleDifficultyEnumMap, json['difficulty']),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  readTimeMinutes: (json['readTimeMinutes'] as num).toInt(),
  publishedDate: DateTime.parse(json['publishedDate'] as String),
  isFeatured: json['isFeatured'] as bool? ?? false,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  keyQuote: json['keyQuote'] as String?,
  targetAudience: json['targetAudience'] as String?,
  source: json['source'] as String?,
);

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'author': instance.author,
      'category': _$ArticleCategoryEnumMap[instance.category]!,
      'mood': _$ArticleMoodEnumMap[instance.mood]!,
      'difficulty': _$ArticleDifficultyEnumMap[instance.difficulty]!,
      'tags': instance.tags,
      'readTimeMinutes': instance.readTimeMinutes,
      'publishedDate': instance.publishedDate.toIso8601String(),
      'isFeatured': instance.isFeatured,
      'thumbnailUrl': instance.thumbnailUrl,
      'keyQuote': instance.keyQuote,
      'targetAudience': instance.targetAudience,
      'source': instance.source,
    };

const _$ArticleCategoryEnumMap = {
  ArticleCategory.motivation: 'motivation',
  ArticleCategory.tips: 'tips',
  ArticleCategory.successStories: 'successStories',
  ArticleCategory.science: 'science',
  ArticleCategory.mindfulness: 'mindfulness',
  ArticleCategory.health: 'health',
  ArticleCategory.productivity: 'productivity',
  ArticleCategory.personal: 'personal',
  ArticleCategory.addiction: 'addiction',
  ArticleCategory.general: 'general',
};

const _$ArticleMoodEnumMap = {
  ArticleMood.encouraging: 'encouraging',
  ArticleMood.inspiring: 'inspiring',
  ArticleMood.educational: 'educational',
  ArticleMood.calming: 'calming',
  ArticleMood.energizing: 'energizing',
  ArticleMood.hopeful: 'hopeful',
  ArticleMood.practical: 'practical',
};

const _$ArticleDifficultyEnumMap = {
  ArticleDifficulty.easy: 'easy',
  ArticleDifficulty.medium: 'medium',
  ArticleDifficulty.advanced: 'advanced',
};
