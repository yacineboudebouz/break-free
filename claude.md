# Bad Habit Killer - Flutter App Implementation Plan

## Project Overview
A Flutter application for tracking and managing habits with a focus on quitting bad habits and building good ones. The app features a unique devil/angel theme for different habit types and uses clean architecture with Riverpod 3.0 for state management.

## Technical Stack
- **Framework**: Flutter (SDK ^3.8.1)
- **State Management**: Riverpod 3.0
- **Navigation**: GoRouter
- **Local Storage**: sqflite
- **Logging**: logger package
- **Architecture**: Clean Architecture with Domain-Driven Design (Local-only)

## Required Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # State Management
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3
  
  # Navigation
  go_router: ^12.1.3
  
  # Database
  sqflite: ^2.3.0
  path: ^1.8.3
  
  # Logging
  logger: ^2.0.2+1
  
  # UI & Utilities
  equatable: ^2.0.5
  json_annotation: ^4.8.1
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  
  # Code Generation
  riverpod_generator: ^2.3.9
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
  
  # Testing
  mocktail: ^1.0.1
```

## Architecture Overview

### Folder Structure
```
lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── database_constants.dart
│   ├── di/
│   │   └── dependency_injection.dart
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── routing/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── theme_provider.dart
│   │   ├── angel_theme.dart
│   │   └── devil_theme.dart
│   └── utils/
│       ├── logger.dart
│       └── date_utils.dart
├── features/
│   ├── habits/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── habit_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── habit_model.dart
│   │   │   │   └── relapse_model.dart
│   │   │   └── repositories/
│   │   │       └── habit_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── habit.dart
│   │   │   │   └── relapse.dart
│   │   │   ├── repositories/
│   │   │   │   └── habit_repository.dart
│   │   │   └── usecases/
│   │   │       ├── add_habit.dart
│   │   │       ├── get_habits.dart
│   │   │       ├── update_habit.dart
│   │   │       ├── delete_habit.dart
│   │   │       ├── add_relapse.dart
│   │   │       └── get_habit_history.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── habits_provider.dart
│   │       │   └── habit_detail_provider.dart
│   │       ├── pages/
│   │       │   ├── habits_page.dart
│   │       │   ├── habit_detail_page.dart
│   │       │   └── add_habit_page.dart
│   │       └── widgets/
│   │           ├── habit_card.dart
│   │           ├── habit_search_bar.dart
│   │           ├── habit_list.dart
│   │           ├── angel_habit_card.dart
│   │           ├── devil_habit_card.dart
│   │           └── habit_stats_widget.dart
│   ├── articles/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── article_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── article_model.dart
│   │   │   └── repositories/
│   │   │       └── article_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── article.dart
│   │   │   ├── repositories/
│   │   │   │   └── article_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_articles.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── articles_provider.dart
│   │       ├── pages/
│   │       │   ├── articles_page.dart
│   │       │   └── article_detail_page.dart
│   │       └── widgets/
│   │           └── article_card.dart
│   ├── settings/
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── settings_page.dart
│   │       │   └── credits_page.dart
│   │       └── widgets/
│   │           └── theme_switcher.dart
│   └── shared/
│       └── widgets/
│           ├── app_drawer.dart
│           ├── custom_app_bar.dart
│           ├── loading_widget.dart
│           ├── error_widget.dart
│           └── empty_state_widget.dart
└── main.dart
```

## Core Features Implementation

### 1. Habit Management
- **Add Habit**: Create new habits with name, description, type (good/bad), and category
- **View Habits**: Display habits in a customized UI with devil/angel themes
- **Edit Habit**: Modify existing habits
- **Delete Habit**: Remove habits with confirmation
- **Search Habits**: Filter habits by name or category

### 2. Habit Tracking
- **Record Success**: Mark successful days for good habits
- **Record Relapse**: Mark relapses for bad habits with optional notes
- **View History**: Display habit history with streaks and statistics
- **Reset Habit**: Reset habit tracking to current date

### 3. Theming System
- **Light/Dark Mode**: Toggle between light and dark themes
- **Angel Theme**: Light, positive colors for good habits (whites, golds, blues)
- **Devil Theme**: Dark, intense colors for bad habits (reds, blacks, oranges)
- **Dynamic Theme**: Responsive theme switching based on habit type

### 4. Navigation
- **Main Screen**: Dashboard with habit overview
- **Habit Details**: Individual habit tracking and history
- **Articles**: Educational content about habits
- **Settings**: Theme preferences and app configuration
- **Credits**: App information and licenses

## Data Architecture (Local-Only)

### Local Data Sources
- **HabitLocalDataSource**: Handles all habit-related database operations
- **ArticleLocalDataSource**: Manages pre-loaded articles in the local database
- **No Remote Data Sources**: All data is stored and managed locally using SQLite

### Repository Pattern
- Repositories implement domain interfaces and delegate to local data sources only
- No network layer or remote data synchronization
- All operations are performed on the local SQLite database

### Data Flow
```
UI Layer (Widgets) 
    ↓
Presentation Layer (Providers/Notifiers)
    ↓
Domain Layer (Use Cases)
    ↓
Data Layer (Repository Implementation)
    ↓
Local Data Source (SQLite)
```

## Database Schema

### Habits Table
```sql
CREATE TABLE habits (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  type TEXT NOT NULL, -- 'good' or 'bad'
  category TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  streak_count INTEGER DEFAULT 0,
  last_success_date TEXT,
  is_active INTEGER DEFAULT 1
);
```

### Relapses Table
```sql
CREATE TABLE relapses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  habit_id INTEGER NOT NULL,
  date TEXT NOT NULL,
  note TEXT,
  created_at TEXT NOT NULL,
  FOREIGN KEY (habit_id) REFERENCES habits(id) ON DELETE CASCADE
);
```

### Articles Table
```sql
CREATE TABLE articles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  author TEXT,
  category TEXT,
  created_at TEXT NOT NULL,
  is_favorite INTEGER DEFAULT 0
);
```

## State Management with Riverpod

### Core Providers
- **ThemeProvider**: Manages app theme state
- **HabitsProvider**: Manages habits list and CRUD operations
- **HabitDetailProvider**: Manages individual habit details
- **ArticlesProvider**: Manages articles data
- **DatabaseProvider**: Provides database instance

### Example Provider Structure
```dart
@riverpod
class HabitsNotifier extends _$HabitsNotifier {
  @override
  Future<List<Habit>> build() async {
    return await ref.read(habitRepositoryProvider).getHabits();
  }

  Future<void> addHabit(Habit habit) async {
    await ref.read(habitRepositoryProvider).addHabit(habit);
    ref.invalidateSelf();
  }

  Future<void> updateHabit(Habit habit) async {
    await ref.read(habitRepositoryProvider).updateHabit(habit);
    ref.invalidateSelf();
  }
}
```

## UI Components

### Main Screen Layout
- **AppBar**: Custom app bar with search functionality
- **Drawer**: Navigation drawer with theme switcher
- **Body**: Split view with devil section (bad habits) and angel section (good habits)
- **FAB**: Floating action button to add new habits

### Habit Cards
- **Devil Card**: Dark theme with red accents for bad habits
- **Angel Card**: Light theme with blue/gold accents for good habits
- **Stats Display**: Streak counter, last success date, progress indicators

### Responsive Design
- **Mobile First**: Optimized for mobile devices
- **Tablet Support**: Responsive layout for larger screens
- **Accessibility**: Proper semantic labels and contrast ratios

## Error Handling

### Failure Classes
```dart
abstract class Failure extends Equatable {
  const Failure();
  
  @override
  List<Object> get props => [];
}

class DatabaseFailure extends Failure {
  final String message;
  const DatabaseFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  final String message;
  const CacheFailure(this.message);
  
  @override
  List<Object> get props => [message];
}
```

### Exception Handling
- **Try-Catch Blocks**: Proper exception handling in all async operations
- **User Feedback**: Meaningful error messages for users
- **Logging**: Comprehensive error logging for debugging

## Testing Strategy

### Unit Tests
- **Domain Layer**: Test all use cases and entities
- **Data Layer**: Test repositories and data sources
- **Providers**: Test Riverpod providers with mocks

### Widget Tests
- **UI Components**: Test individual widgets
- **Pages**: Test complete page functionality
- **Integration**: Test widget interactions

### Test Structure
```dart
void main() {
  group('HabitsNotifier', () {
    late MockHabitRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockHabitRepository();
      container = ProviderContainer(
        overrides: [
          habitRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    test('should return habits when getHabits is called', () async {
      // Test implementation
    });
  });
}
```

## Implementation Phases

### Phase 1: Core Setup
1. Set up dependencies and folder structure
2. Implement core architecture (DI, routing, themes)
3. Set up local database and models
4. Create basic UI components and local data sources

### Phase 2: Habit Management
1. Implement habit CRUD operations
2. Create habit list and detail pages
3. Add habit search functionality
4. Implement basic theming

### Phase 3: Tracking System
1. Add relapse/success tracking
2. Implement habit history
3. Create statistics display
4. Add habit reset functionality

### Phase 4: Additional Features
1. Implement articles section
2. Add settings and credits pages
3. Enhance theming system
4. Add responsive design

### Phase 5: Polish & Testing
1. Write comprehensive tests
2. Add error handling and logging
3. Optimize performance
4. Final UI/UX improvements

## Best Practices

### Code Quality
- **Documentation**: Comprehensive code documentation
- **SOLID Principles**: Follow SOLID design principles
- **Clean Code**: Readable and maintainable code
- **Type Safety**: Strong typing throughout the application

### Performance
- **Lazy Loading**: Load data only when needed
- **Caching**: Cache frequently accessed data
- **Optimized Builds**: Use const constructors where possible
- **Memory Management**: Proper disposal of resources

### Maintainability
- **Separation of Concerns**: Clear separation between layers
- **Dependency Injection**: Loose coupling between components
- **Testability**: Easy to test components
- **Extensibility**: Easy to add new features

This implementation plan provides a comprehensive roadmap for building the Bad Habit Killer app according to the specified requirements, following Flutter best practices and clean architecture principles.
