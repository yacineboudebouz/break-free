import 'package:sqflite/sqflite.dart' hide DatabaseException;

import '../../../../core/database/database_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/article.dart';
import '../models/article_model.dart';

/// Abstract interface for article local data source
/// Articles are read-only and pre-seeded in the database
abstract class ArticleLocalDataSource {
  /// Get all articles from local storage
  Future<List<ArticleModel>> getAllArticles();

  /// Get an article by ID from local storage
  Future<ArticleModel?> getArticleById(String id);

  /// Search articles by title, content, or tags
  Future<List<ArticleModel>> searchArticles(String query);

  /// Get articles by category
  Future<List<ArticleModel>> getArticlesByCategory(String category);

  /// Get articles by mood
  Future<List<ArticleModel>> getArticlesByMood(String mood);

  /// Get articles by difficulty level
  Future<List<ArticleModel>> getArticlesByDifficulty(String difficulty);

  /// Get featured articles
  Future<List<ArticleModel>> getFeaturedArticles();

  /// Get articles with specific tags
  Future<List<ArticleModel>> getArticlesByTags(List<String> tags);

  /// Get articles by target audience
  Future<List<ArticleModel>> getArticlesByTargetAudience(String audience);

  /// Get random articles for inspiration
  Future<List<ArticleModel>> getRandomArticles(int count);

  /// Get articles suitable for a specific reading time
  Future<List<ArticleModel>> getArticlesByReadTime(int maxMinutes);

  /// Seed initial articles data (called during app initialization)
  Future<void> seedArticles();

  /// Check if articles are already seeded
  Future<bool> isDataSeeded();
}

/// Implementation of article local data source using SQLite
class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final DatabaseService _databaseService;

  ArticleLocalDataSourceImpl(this._databaseService);

  static const String _tableName = 'articles';

  @override
  Future<List<ArticleModel>> getAllArticles() async {
    try {
      AppLogger.debug('Getting all articles from local storage');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(_tableName, orderBy: 'published_date DESC');

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug(
        'Retrieved ${articles.length} articles from local storage',
      );
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get all articles', e, stackTrace);
      throw DatabaseException(message: 'Failed to retrieve articles: $e');
    }
  }

  @override
  Future<ArticleModel?> getArticleById(String id) async {
    try {
      AppLogger.debug('Getting article by ID: $id');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isEmpty) {
        AppLogger.debug('Article not found with ID: $id');
        return null;
      }

      final article = ArticleModel.fromMap(maps.first);
      AppLogger.debug('Retrieved article: ${article.title}');
      return article;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get article by ID: $id', e, stackTrace);
      throw DatabaseException(message: 'Failed to retrieve article: $e');
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      AppLogger.debug('Searching articles with query: $query');

      final db = await _databaseService.getDatabase();
      final searchQuery = '%$query%';

      final maps = await db.query(
        _tableName,
        where:
            'title LIKE ? OR content LIKE ? OR tags LIKE ? OR summary LIKE ?',
        whereArgs: [searchQuery, searchQuery, searchQuery, searchQuery],
        orderBy: 'published_date DESC',
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug(
        'Found ${articles.length} articles matching query: $query',
      );
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to search articles with query: $query',
        e,
        stackTrace,
      );
      throw DatabaseException(message: 'Failed to search articles: $e');
    }
  }

  @override
  Future<List<ArticleModel>> getArticlesByCategory(String category) async {
    try {
      AppLogger.debug('Getting articles by category: $category');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'category = ?',
        whereArgs: [category],
        orderBy: 'published_date DESC',
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug(
        'Found ${articles.length} articles in category: $category',
      );
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get articles by category: $category',
        e,
        stackTrace,
      );
      throw DatabaseException(
        message: 'Failed to get articles by category: $e',
      );
    }
  }

  @override
  Future<List<ArticleModel>> getArticlesByMood(String mood) async {
    try {
      AppLogger.debug('Getting articles by mood: $mood');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'mood = ?',
        whereArgs: [mood],
        orderBy: 'published_date DESC',
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug('Found ${articles.length} articles with mood: $mood');
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get articles by mood: $mood', e, stackTrace);
      throw DatabaseException(message: 'Failed to get articles by mood: $e');
    }
  }

  @override
  Future<List<ArticleModel>> getArticlesByDifficulty(String difficulty) async {
    try {
      AppLogger.debug('Getting articles by difficulty: $difficulty');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'difficulty = ?',
        whereArgs: [difficulty],
        orderBy: 'published_date DESC',
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug(
        'Found ${articles.length} articles with difficulty: $difficulty',
      );
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get articles by difficulty: $difficulty',
        e,
        stackTrace,
      );
      throw DatabaseException(
        message: 'Failed to get articles by difficulty: $e',
      );
    }
  }

  @override
  Future<List<ArticleModel>> getFeaturedArticles() async {
    try {
      AppLogger.debug('Getting featured articles');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'is_featured = ?',
        whereArgs: [1],
        orderBy: 'published_date DESC',
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug('Found ${articles.length} featured articles');
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get featured articles', e, stackTrace);
      throw DatabaseException(message: 'Failed to get featured articles: $e');
    }
  }

  @override
  Future<List<ArticleModel>> getArticlesByTags(List<String> tags) async {
    try {
      AppLogger.debug('Getting articles by tags: ${tags.join(", ")}');

      final db = await _databaseService.getDatabase();

      // Build WHERE clause for multiple tags (OR condition)
      final whereClauses = tags.map((_) => 'tags LIKE ?').join(' OR ');
      final whereArgs = tags.map((tag) => '%$tag%').toList();

      final maps = await db.query(
        _tableName,
        where: whereClauses,
        whereArgs: whereArgs,
        orderBy: 'published_date DESC',
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug('Found ${articles.length} articles with specified tags');
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get articles by tags', e, stackTrace);
      throw DatabaseException(message: 'Failed to get articles by tags: $e');
    }
  }

  @override
  Future<List<ArticleModel>> getArticlesByTargetAudience(
    String audience,
  ) async {
    try {
      AppLogger.debug('Getting articles by target audience: $audience');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'target_audience = ? OR target_audience IS NULL',
        whereArgs: [audience],
        orderBy: 'published_date DESC',
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug(
        'Found ${articles.length} articles for audience: $audience',
      );
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get articles by target audience: $audience',
        e,
        stackTrace,
      );
      throw DatabaseException(
        message: 'Failed to get articles by target audience: $e',
      );
    }
  }

  @override
  Future<List<ArticleModel>> getRandomArticles(int count) async {
    try {
      AppLogger.debug('Getting $count random articles');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        orderBy: 'RANDOM()',
        limit: count,
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug('Retrieved ${articles.length} random articles');
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get random articles', e, stackTrace);
      throw DatabaseException(message: 'Failed to get random articles: $e');
    }
  }

  @override
  Future<List<ArticleModel>> getArticlesByReadTime(int maxMinutes) async {
    try {
      AppLogger.debug('Getting articles with read time <= $maxMinutes minutes');

      final db = await _databaseService.getDatabase();
      final maps = await db.query(
        _tableName,
        where: 'read_time_minutes <= ?',
        whereArgs: [maxMinutes],
        orderBy: 'published_date DESC',
      );

      final articles = maps.map((map) => ArticleModel.fromMap(map)).toList();

      AppLogger.debug(
        'Found ${articles.length} articles with read time <= $maxMinutes min',
      );
      return articles;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get articles by read time', e, stackTrace);
      throw DatabaseException(
        message: 'Failed to get articles by read time: $e',
      );
    }
  }

  @override
  Future<void> seedArticles() async {
    try {
      AppLogger.info('Seeding articles data...');

      final db = await _databaseService.getDatabase();

      // Sample articles data for the devil/angel themed bad habit killer app
      final sampleArticles = [
        ArticleModel(
          id: 'article_1',
          title: 'Breaking the Devil\'s Chains: Your First Steps to Freedom',
          summary:
              'Learn how to identify the mental chains that bind you to bad habits and take your first steps toward liberation.',
          content: '''
# Breaking the Devil's Chains: Your First Steps to Freedom

Bad habits are like invisible chains forged by the devil himself. They bind us to behaviors that we know are harmful, yet we find ourselves powerless to break free. The good news is that liberation is possible, and it starts with understanding what these chains really are.

## Understanding Your Mental Chains

The first step to freedom is recognizing that these chains exist primarily in your mind. Every time you give in to a bad habit, you're essentially choosing to put on another link in the chain. But here's the secret: if you forged these chains, you also have the power to break them.

## The Angel's Toolkit for Freedom

1. **Awareness**: The angel's first gift is awareness. Start by simply observing your habits without judgment.
2. **Choice**: Recognize that in every moment, you have a choice. The devil whispers that you don't, but that's a lie.
3. **Small Steps**: Don't try to break all chains at once. Start with one link at a time.

## Your Battle Plan

- Identify your strongest chain (your most persistent bad habit)
- Choose one small action you can take today to weaken it
- Celebrate every small victory - the angels rejoice with you
- When you stumble, remember: even angels had to learn to fly

Remember, every moment you resist is a moment you're choosing the angel's path over the devil's temptation. You have more power than you realize.
          ''',
          author: 'Seraphim Gabriel',
          category: ArticleCategory.motivation,
          mood: ArticleMood.encouraging,
          difficulty: ArticleDifficulty.easy,
          tags: ['motivation', 'first-steps', 'mindset', 'freedom'],
          readTimeMinutes: 5,
          publishedDate: DateTime.now().subtract(const Duration(days: 7)),
          isFeatured: true,
          keyQuote:
              'If you forged these chains, you also have the power to break them.',
          targetAudience: 'beginners',
        ),

        ArticleModel(
          id: 'article_2',
          title: 'The Angel\'s Guide to Habit Replacement',
          summary:
              'Discover how to replace destructive habits with life-giving ones using the angel\'s wisdom.',
          content: '''
# The Angel's Guide to Habit Replacement

The devils of habit are cunning. They know that simply trying to stop a bad habit leaves a void - and they're ready to fill it with something even worse. But the angels have a better strategy: replacement.

## Why Replacement Works

When you try to simply eliminate a habit, you're fighting against your brain's natural patterns. It's like trying to dam a river - the water will find another way through. Instead, redirect the river.

## The Angel's Replacement Strategy

### 1. Identify the Trigger
Every habit has a trigger - a specific situation, emotion, or time that starts the habit loop. The angels teach us to observe these triggers with compassion, not judgment.

### 2. Find the True Need
What is your habit really giving you? Stress relief? Social connection? A sense of control? The devil offers cheap substitutes, but the angels can help you find healthy ways to meet these same needs.

### 3. Design Your Replacement
Your replacement habit should:
- Address the same underlying need
- Be easier to do than the bad habit
- Give you immediate satisfaction
- Align with your values

## Examples of Angelic Replacements

- **Smoking → Deep breathing exercises**: Both provide stress relief and a mental break
- **Mindless scrolling → Reading inspirational quotes**: Both provide mental stimulation and escape
- **Stress eating → Going for a walk**: Both provide comfort and stress relief

## The 21-Day Angel Challenge

Commit to your replacement habit for 21 days. The angels will strengthen you each day, and by day 21, your new habit will begin to feel natural.

Remember: you're not just breaking bad habits - you're building a better version of yourself.
          ''',
          author: 'Michael Archangel',
          category: ArticleCategory.tips,
          mood: ArticleMood.encouraging,
          difficulty: ArticleDifficulty.medium,
          tags: ['habit-replacement', 'strategies', 'behavioral-change'],
          readTimeMinutes: 8,
          publishedDate: DateTime.now().subtract(const Duration(days: 14)),
          isFeatured: true,
          keyQuote:
              'You\'re not just breaking bad habits - you\'re building a better version of yourself.',
          targetAudience: 'intermediate',
        ),

        ArticleModel(
          id: 'article_3',
          title: 'When You Stumble: The Angel\'s Forgiveness',
          summary:
              'Learn how to recover from setbacks with grace and continue your journey toward freedom.',
          content: '''
# When You Stumble: The Angel's Forgiveness

The devil's cruelest trick isn't tempting you to fall - it's convincing you that falling makes you a failure. But the angels know better. They know that stumbling is part of learning to walk, and falling is part of learning to fly.

## The Devil's Lie vs. The Angel's Truth

**The Devil whispers:** "You've ruined everything. You're weak. You'll never change."
**The Angel reminds you:** "One moment doesn't define you. Get up, dust yourself off, and keep going."

## The Sacred Art of Getting Back Up

### Step 1: Pause and Breathe
Don't let the devil's shame spiral take control. Take three deep breaths and remember: you are not your mistakes.

### Step 2: Learn from the Fall
- What led to the stumble?
- What can you do differently next time?
- What support do you need?

### Step 3: Recommit Immediately
Don't wait for Monday, next month, or next year. The angels are ready to help you right now, in this very moment.

## The Power of Self-Compassion

Research shows that self-compassion is more effective than self-criticism for creating lasting change. When you treat yourself with kindness, you:
- Reduce the shame that feeds bad habits
- Increase motivation to try again
- Build resilience for future challenges

## Your Angelic Affirmation

When you stumble, repeat this: "I am human, I am learning, and I am worthy of love and forgiveness. This moment does not define me. I choose to get up and try again."

## The 24-Hour Rule

Give yourself 24 hours to feel disappointed, then consciously choose to move forward. The angels will be waiting to help you rise.

Remember: even the angels fell before they learned to soar. Your stumbles are not failures - they're lessons in disguise.
          ''',
          author: 'Raphael the Healer',
          category: ArticleCategory.personal,
          mood: ArticleMood.calming,
          difficulty: ArticleDifficulty.easy,
          tags: ['recovery', 'self-compassion', 'resilience', 'forgiveness'],
          readTimeMinutes: 6,
          publishedDate: DateTime.now().subtract(const Duration(days: 21)),
          isFeatured: false,
          keyQuote:
              'Your stumbles are not failures - they\'re lessons in disguise.',
          targetAudience: 'anyone',
        ),

        ArticleModel(
          id: 'article_4',
          title: 'The Science of Temptation: Understanding Your Enemy',
          summary:
              'Dive deep into the neuroscience behind addiction and temptation to better understand and overcome them.',
          content: '''
# The Science of Temptation: Understanding Your Enemy

Knowledge is power, and understanding how temptation works in your brain is one of the most powerful weapons in your arsenal against bad habits. Let's pull back the curtain on the devil's tricks.

## Your Brain on Temptation

When you're tempted, several things happen in your brain:

### The Dopamine Hit
Your brain releases dopamine not when you engage in the habit, but when you anticipate it. This is why just thinking about your bad habit can feel so compelling.

### The Prefrontal Cortex Shutdown
Stress, fatigue, and strong emotions can temporarily shut down your prefrontal cortex - the part of your brain responsible for decision-making and impulse control.

### The Habit Loop
Habits follow a simple loop: Cue → Routine → Reward. Once this loop is established, it becomes automatic.

## The Devil's Favorite Conditions

Temptation is strongest when you're:
- **H**ungry
- **A**ngry
- **L**onely
- **T**ired

(Remember: HALT before you act!)

## The Angel's Counterstrike

### Strengthen Your Prefrontal Cortex
- Meditation and mindfulness practices
- Regular exercise
- Adequate sleep
- Proper nutrition

### Disrupt the Habit Loop
- Change your environment (remove cues)
- Interrupt the routine with a replacement
- Find new ways to get the same reward

### Use Implementation Intentions
Instead of vague goals like "I won't smoke," create specific if-then plans: "If I feel the urge to smoke, then I will do 10 deep breaths."

## The Power of Understanding

When you understand that temptation is a neurological process, not a moral failing, you can:
- Respond with strategy instead of shame
- Prepare for predictable challenges
- Work with your brain instead of against it

## Building Your Resistance

Every time you resist temptation, you're literally strengthening neural pathways that make future resistance easier. You're training your brain to choose the angel's path.

The devil wants you to think you're powerless, but science shows you have more control than you realize.
          ''',
          author: 'Dr. Gabriel Cognitive',
          category: ArticleCategory.science,
          mood: ArticleMood.educational,
          difficulty: ArticleDifficulty.advanced,
          tags: ['neuroscience', 'dopamine', 'brain', 'willpower', 'research'],
          readTimeMinutes: 10,
          publishedDate: DateTime.now().subtract(const Duration(days: 28)),
          isFeatured: false,
          keyQuote:
              'Every time you resist temptation, you\'re literally strengthening neural pathways.',
          targetAudience: 'advanced',
        ),

        ArticleModel(
          id: 'article_5',
          title: 'Building Your Angel Army: The Power of Support',
          summary:
              'Learn how to build a support network that will help you stay accountable and motivated on your journey.',
          content: '''
# Building Your Angel Army: The Power of Support

The devil wants you to fight alone, isolated and ashamed. But the angels know the secret: transformation happens in community. You were never meant to fight this battle by yourself.

## Why Support Matters

Research consistently shows that people with strong support networks are:
- 5x more likely to successfully change habits
- More resilient in the face of setbacks
- Happier and more motivated throughout the process

## Types of Angels in Your Army

### The Accountability Angel
This person checks in on your progress regularly. They ask the hard questions with love: "How did you do this week?" "What challenges are you facing?"

### The Encouragement Angel
This is your cheerleader. They celebrate your victories, no matter how small, and remind you of your strength when you're feeling weak.

### The Wisdom Angel
This person has walked the path before you. They share their experiences, strategies, and hard-won wisdom.

### The Professional Angel
Sometimes you need expert help - therapists, counselors, or coaches who specialize in behavior change.

## Finding Your Angels

### Family and Friends
Start with people who already love and support you. Be specific about what kind of help you need.

### Support Groups
- Online communities
- Local meetups
- 12-step programs
- Hobby groups that support your new habits

### Professional Help
Don't hesitate to seek professional support. There's no shame in getting expert help.

## Being an Angel for Others

One of the best ways to strengthen your own commitment is to help others. When you become someone else's accountability angel, you reinforce your own values and commitment.

## Creating Your Support Plan

1. **Identify your needs**: What kind of support would be most helpful?
2. **Reach out**: Ask specific people for specific types of support
3. **Be a good army member**: Show up for others as you want them to show up for you
4. **Express gratitude**: Thank your angels regularly

## The Ripple Effect

When you successfully change your habits with support, you become proof that change is possible. Your success gives others permission to believe they can change too.

Remember: asking for help isn't weakness - it's wisdom. Even the mightiest angels work together.
          ''',
          author: 'Uriel the Wise',
          category: ArticleCategory.general,
          mood: ArticleMood.encouraging,
          difficulty: ArticleDifficulty.medium,
          tags: ['support', 'community', 'accountability', 'relationships'],
          readTimeMinutes: 7,
          publishedDate: DateTime.now().subtract(const Duration(days: 35)),
          isFeatured: true,
          keyQuote: 'Asking for help isn\'t weakness - it\'s wisdom.',
          targetAudience: 'anyone',
        ),
      ];

      // Insert articles using batch insert for efficiency
      final batch = db.batch();
      for (final article in sampleArticles) {
        batch.insert(
          _tableName,
          article.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);

      AppLogger.info('Successfully seeded ${sampleArticles.length} articles');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to seed articles data', e, stackTrace);
      throw DatabaseException(message: 'Failed to seed articles: $e');
    }
  }

  @override
  Future<bool> isDataSeeded() async {
    try {
      final db = await _databaseService.getDatabase();
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $_tableName',
      );
      final count = result.first['count'] as int;

      final seeded = count > 0;
      AppLogger.debug('Articles data seeded: $seeded (count: $count)');
      return seeded;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to check if articles data is seeded',
        e,
        stackTrace,
      );
      return false;
    }
  }
}
