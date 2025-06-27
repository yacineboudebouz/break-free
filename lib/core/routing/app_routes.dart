/// Route names and paths for the Bad Habit Killer app
class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  // Route paths
  static const String home = '/';
  static const String habitDetail = '/habit/:id';
  static const String addHabit = '/add-habit';
  static const String editHabit = '/edit-habit/:id';
  static const String articles = '/articles';
  static const String articleDetail = '/articles/:id';
  static const String settings = '/settings';
  static const String credits = '/credits';

  // Route names (for named navigation)
  static const String homeName = 'home';
  static const String habitDetailName = 'habit-detail';
  static const String addHabitName = 'add-habit';
  static const String editHabitName = 'edit-habit';
  static const String articlesName = 'articles';
  static const String articleDetailName = 'article-detail';
  static const String settingsName = 'settings';
  static const String creditsName = 'credits';

  // Parameter keys
  static const String idParam = 'id';

  /// Get habit detail route with id
  static String getHabitDetailRoute(String id) {
    return habitDetail.replaceAll(':id', id);
  }

  /// Get edit habit route with id
  static String getEditHabitRoute(String id) {
    return editHabit.replaceAll(':id', id);
  }

  /// Get article detail route with id
  static String getArticleDetailRoute(String id) {
    return articleDetail.replaceAll(':id', id);
  }
}
