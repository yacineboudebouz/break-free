# Bad Habit Killer - Detailed Implementation Plan

## Overview
This plan breaks down the implementation of the Bad Habit Killer Flutter app into detailed phases with specific tasks and subtasks. Each task is designed to follow clean architecture principles with Riverpod 3.0 state management.

---

## **PHASE 1: PROJECT FOUNDATION & SETUP**

### Task 1.1: Project Dependencies & Configuration
**Subtasks:**
- [ ] 1.1.1 Update `pubspec.yaml` with all required dependencies
  - Add flutter_riverpod ^2.4.9
  - Add riverpod_annotation ^2.3.3
  - Add go_router ^12.1.3
  - Add sqflite ^2.3.0
  - Add path ^1.8.3
  - Add logger ^2.0.2+1
  - Add equatable ^2.0.5
  - Add json_annotation ^4.8.1
  - Add intl ^0.18.1
  - Add dev dependencies (riverpod_generator, build_runner, etc.)
- [ ] 1.1.2 Configure analysis_options.yaml for strict linting
- [ ] 1.1.3 Set up build.yaml for code generation
- [ ] 1.1.4 Run `flutter pub get` and `flutter packages pub run build_runner build`

### Task 1.2: Core Architecture Setup
**Subtasks:**
- [ ] 1.2.1 Create folder structure following clean architecture
  - Create `lib/core/` with subdirectories
  - Create `lib/features/` with feature modules
  - Create `lib/shared/` for shared components
- [ ] 1.2.2 Set up core constants
  - Create `app_constants.dart` (app name, version, etc.)
  - Create `database_constants.dart` (table names, columns)
- [ ] 1.2.3 Set up dependency injection container
  - Create `dependency_injection.dart` with provider setup
- [ ] 1.2.4 Create base error handling classes
  - Create `failures.dart` with abstract Failure class
  - Create `exceptions.dart` with custom exceptions
- [ ] 1.2.5 Set up logging utility
  - Create `logger.dart` with configured Logger instance
  - Set up different log levels for debug/release

### Task 1.3: Database Foundation
**Subtasks:**
- [ ] 1.3.1 Design database schema
  - Create habits table schema
  - Create relapses table schema  
  - Create articles table schema
- [ ] 1.3.2 Create database helper class
  - Implement SQLite database creation
  - Handle database versioning and migrations
  - Create singleton pattern for database access
- [ ] 1.3.3 Set up database provider with Riverpod
  - Create database provider
  - Handle database initialization

---

## **PHASE 2: DOMAIN LAYER IMPLEMENTATION**

### Task 2.1: Habit Domain Layer
**Subtasks:**
- [ ] 2.1.1 Create Habit entity
  - Define Habit class with all properties (id, name, description, type, etc.)
  - Implement equality and toString methods
  - Add validation logic
- [ ] 2.1.2 Create Relapse entity
  - Define Relapse class (id, habitId, date, note, etc.)
  - Implement relationships with Habit
- [ ] 2.1.3 Create Habit repository interface
  - Define abstract methods (getHabits, addHabit, updateHabit, etc.)
  - Include proper return types with Either<Failure, Success>
- [ ] 2.1.4 Create Use Cases
  - `AddHabit` use case with validation
  - `GetHabits` use case with filtering options
  - `UpdateHabit` use case
  - `DeleteHabit` use case
  - `AddRelapse` use case
  - `GetHabitHistory` use case
  - `SearchHabits` use case

### Task 2.2: Articles Domain Layer
**Subtasks:**
- [ ] 2.2.1 Create Article entity
  - Define Article class (id, title, content, author, category, etc.)
- [ ] 2.2.2 Create Article repository interface
  - Define methods for article management
- [ ] 2.2.3 Create Article use cases
  - `GetArticles` use case
  - `GetArticleById` use case
  - `SearchArticles` use case

---

## **PHASE 3: DATA LAYER IMPLEMENTATION**

### Task 3.1: Data Models
**Subtasks:**
- [ ] 3.1.1 Create HabitModel extending Habit entity
  - Add JSON serialization/deserialization
  - Add toMap/fromMap methods for SQLite
  - Implement proper type conversions
- [ ] 3.1.2 Create RelapseModel extending Relapse entity
  - Add database mapping methods
  - Handle date serialization
- [ ] 3.1.3 Create ArticleModel extending Article entity
  - Add database mapping functionality

### Task 3.2: Local Data Sources
**Subtasks:**
- [ ] 3.2.1 Implement HabitLocalDataSource
  - Create CRUD operations for habits
  - Implement search functionality
  - Add proper error handling and logging
  - Handle SQL exceptions properly
- [ ] 3.2.2 Implement RelapseLocalDataSource  
  - Create relapse tracking operations
  - Implement history retrieval
  - Add relationship queries with habits
- [ ] 3.2.3 Implement ArticleLocalDataSource
  - Create article retrieval operations
  - Implement search functionality
  - Seed initial articles data

### Task 3.3: Repository Implementations
**Subtasks:**
- [ ] 3.3.1 Implement HabitRepositoryImpl
  - Implement all interface methods
  - Add proper error mapping (exceptions to failures)
  - Include comprehensive logging
  - Handle edge cases and validation
- [ ] 3.3.2 Implement ArticleRepositoryImpl
  - Implement article repository methods
  - Add error handling

---

## **PHASE 4: THEMING SYSTEM**

### Task 4.1: Base Theme Architecture
**Subtasks:**
- [ ] 4.1.1 Create AppTheme base class
  - Define color schemes for light/dark modes
  - Set up typography and component themes
  - Define consistent spacing and sizing
- [ ] 4.1.2 Create AngelTheme class
  - Light, positive colors (whites, golds, light blues)
  - Soft, rounded design elements
  - Inspirational color palette
- [ ] 4.1.3 Create DevilTheme class
  - Dark, intense colors (reds, blacks, oranges)
  - Sharp, edgy design elements
  - Warning/danger color palette

### Task 4.2: Theme Management with Riverpod
**Subtasks:**
- [ ] 4.2.1 Create ThemeProvider with Riverpod
  - Manage theme state (light/dark mode)
  - Persist theme preference locally
  - Provide theme switching functionality
- [ ] 4.2.2 Create theme switching logic
  - Implement theme toggle methods
  - Handle system theme detection
  - Save theme preference to local storage

### Task 4.3: Apply Themes to MaterialApp
**Subtasks:**
- [ ] 4.3.1 Configure MaterialApp with dynamic theming
  - Set up theme and darkTheme properties
  - Connect with ThemeProvider
  - Ensure proper theme switching

---

## **PHASE 5: NAVIGATION WITH GOROUTER**

### Task 5.1: Router Configuration
**Subtasks:**
- [ ] 5.1.1 Create route definitions
  - Define all route paths and names
  - Create route constants file
- [ ] 5.1.2 Set up GoRouter configuration
  - Configure main routes (home, habit details, add habit)
  - Set up nested routes for drawer navigation
  - Implement route transitions
- [ ] 5.1.3 Create navigation providers
  - Set up router provider with Riverpod
  - Handle navigation state management

### Task 5.2: Route Implementation
**Subtasks:**
- [ ] 5.2.1 Implement main app routes
  - Home/Main screen route
  - Habit detail route with parameters
  - Add/Edit habit routes
- [ ] 5.2.2 Implement drawer routes
  - Articles screen route
  - Settings screen route  
  - Credits screen route
- [ ] 5.2.3 Add route guards and validation
  - Parameter validation
  - Navigation error handling

---

## **PHASE 6: PRESENTATION LAYER - PROVIDERS**

### Task 6.1: Habit Management Providers
**Subtasks:**
- [ ] 6.1.1 Create HabitsNotifier with Riverpod
  - Manage habits list state
  - Implement CRUD operations
  - Add search and filtering functionality
  - Handle loading and error states
- [ ] 6.1.2 Create HabitDetailNotifier
  - Manage individual habit state
  - Handle relapse/success tracking
  - Manage habit history
- [ ] 6.1.3 Create AddHabitNotifier
  - Handle form state management
  - Implement validation logic
  - Manage habit creation flow

### Task 6.2: Other Feature Providers
**Subtasks:**
- [ ] 6.2.1 Create ArticlesNotifier
  - Manage articles state
  - Implement search functionality
- [ ] 6.2.2 Create SearchNotifier
  - Handle search state across features
  - Implement search history

---

## **PHASE 7: UI COMPONENTS - SHARED WIDGETS**

### Task 7.1: Core UI Components
**Subtasks:**
- [ ] 7.1.1 Create CustomAppBar widget
  - Implement responsive app bar
  - Add search functionality
  - Include theme-aware styling
- [ ] 7.1.2 Create AppDrawer widget
  - Implement navigation drawer
  - Add theme switcher
  - Include user preferences access
- [ ] 7.1.3 Create LoadingWidget
  - Custom loading indicators
  - Different loading states
- [ ] 7.1.4 Create ErrorWidget
  - Error display with retry functionality
  - Different error types handling
- [ ] 7.1.5 Create EmptyStateWidget
  - Empty state illustrations
  - Call-to-action buttons

### Task 7.2: Habit-Specific Components
**Subtasks:**
- [ ] 7.2.1 Create base HabitCard widget
  - Common habit card structure
  - Responsive design
- [ ] 7.2.2 Create AngelHabitCard widget
  - Extend base HabitCard
  - Apply angel theme styling
  - Add good habit specific features
- [ ] 7.2.3 Create DevilHabitCard widget
  - Extend base HabitCard
  - Apply devil theme styling
  - Add bad habit specific features
- [ ] 7.2.4 Create HabitSearchBar widget
  - Search input with filtering
  - Real-time search suggestions
- [ ] 7.2.5 Create HabitStatsWidget
  - Display habit statistics
  - Streak counters and progress
- [ ] 7.2.6 Create HabitList widget
  - Scrollable habit list
  - Handle empty states
  - Implement pull-to-refresh

---

## **PHASE 8: MAIN SCREENS IMPLEMENTATION**

### Task 8.1: Main/Home Screen
**Subtasks:**
- [ ] 8.1.1 Create HabitsPage structure
  - Set up responsive layout
  - Implement split view (devil/angel sections)
  - Add floating action button for adding habits
- [ ] 8.1.2 Implement habit sections
  - Bad habits section with devil theme
  - Good habits section with angel theme
  - Section headers and dividers
- [ ] 8.1.3 Add search functionality
  - Integrate search bar
  - Implement real-time filtering
  - Handle search states
- [ ] 8.1.4 Connect with providers
  - Connect to HabitsNotifier
  - Handle loading and error states
  - Implement pull-to-refresh

### Task 8.2: Habit Detail Screen
**Subtasks:**
- [ ] 8.2.1 Create HabitDetailPage layout
  - Habit information display
  - Action buttons (relapse/success)
  - History section
- [ ] 8.2.2 Implement relapse/success tracking
  - Quick action buttons
  - Note input functionality
  - Date reset logic
- [ ] 8.2.3 Create history display
  - Timeline view of relapses/successes
  - Statistics and streaks
  - Visual progress indicators
- [ ] 8.2.4 Add edit functionality
  - Navigation to edit screen
  - Delete confirmation dialog

### Task 8.3: Add/Edit Habit Screen
**Subtasks:**
- [ ] 8.3.1 Create AddHabitPage form
  - Input fields (name, description, type, category)
  - Form validation
  - Habit type selection (good/bad)
- [ ] 8.3.2 Implement form validation
  - Real-time validation
  - Error message display
  - Save/cancel functionality
- [ ] 8.3.3 Handle edit mode
  - Pre-populate form for editing
  - Update vs create logic

---

## **PHASE 9: ADDITIONAL FEATURES**

### Task 9.1: Articles Screen
**Subtasks:**
- [ ] 9.1.1 Create ArticlesPage
  - List view of available articles
  - Search functionality
  - Category filtering
- [ ] 9.1.2 Create ArticleDetailPage
  - Full article display
  - Reading progress
  - Share functionality
- [ ] 9.1.3 Create ArticleCard widget
  - Article preview cards
  - Category indicators
  - Read status

### Task 9.2: Settings Screen
**Subtasks:**
- [ ] 9.2.1 Create SettingsPage layout
  - Settings categories
  - Theme switching option
  - Other preferences
- [ ] 9.2.2 Implement ThemeSwitcher widget
  - Light/dark mode toggle
  - Visual feedback
  - Persistence handling
- [ ] 9.2.3 Add other preferences
  - Notification settings (future)
  - Data export options (future)

### Task 9.3: Credits Screen
**Subtasks:**
- [ ] 9.3.1 Create CreditsPage
  - App information display
  - Developer credits
  - License information
- [ ] 9.3.2 Implement license display
  - Package licenses list
  - Legal information
  - Contact information

---

## **PHASE 10: INTEGRATION & TESTING**

### Task 10.1: Unit Testing
**Subtasks:**
- [ ] 10.1.1 Test domain layer
  - Entity tests
  - Use case tests
  - Repository interface tests
- [ ] 10.1.2 Test data layer
  - Model serialization tests
  - Data source tests
  - Repository implementation tests
- [ ] 10.1.3 Test providers
  - Notifier state management tests
  - Provider interaction tests

### Task 10.2: Widget Testing
**Subtasks:**
- [ ] 10.2.1 Test shared widgets
  - Component rendering tests
  - Interaction tests
  - Theme application tests
- [ ] 10.2.2 Test feature screens
  - Page navigation tests
  - Form functionality tests
  - State display tests

### Task 10.3: Integration Testing
**Subtasks:**
- [ ] 10.3.1 Test complete user flows
  - Add habit flow
  - Track habit flow
  - Navigation flow
- [ ] 10.3.2 Test data persistence
  - Database operations
  - State persistence
  - Theme persistence

---

## **PHASE 11: POLISH & OPTIMIZATION**

### Task 11.1: Performance Optimization
**Subtasks:**
- [ ] 11.1.1 Optimize database queries
  - Index optimization
  - Query performance analysis
- [ ] 11.1.2 Optimize UI performance
  - Widget rebuild optimization
  - Memory usage optimization
- [ ] 11.1.3 Add caching strategies
  - Provider caching
  - Image caching (if applicable)

### Task 11.2: Error Handling Enhancement
**Subtasks:**
- [ ] 11.2.1 Comprehensive error coverage
  - Database error handling
  - Form validation errors
  - Network errors (future)
- [ ] 11.2.2 User-friendly error messages
  - Localized error messages
  - Recovery suggestions
- [ ] 11.2.3 Logging enhancement
  - Structured logging
  - Error reporting (debug mode)

### Task 11.3: Documentation & Code Quality
**Subtasks:**
- [ ] 11.3.1 Code documentation
  - Dart doc comments
  - README updates
  - Architecture documentation
- [ ] 11.3.2 Code review and refactoring
  - SOLID principles compliance
  - Code duplication removal
  - Performance improvements

---

## **PHASE 12: FINAL TESTING & DEPLOYMENT PREPARATION**

### Task 12.1: Comprehensive Testing
**Subtasks:**
- [ ] 12.1.1 Manual testing on devices
  - Android device testing
  - Different screen sizes
  - Performance testing
- [ ] 12.1.2 Edge case testing
  - Empty database scenarios
  - Large dataset handling
  - Error scenarios

### Task 12.2: Build Optimization
**Subtasks:**
- [ ] 12.2.1 Release build optimization
  - Code minification
  - Asset optimization
- [ ] 12.2.2 Build configuration
  - Release signing setup
  - Build scripts

---

## **IMPLEMENTATION PRIORITIES**

### Critical Path (Must be completed in order):
1. **Phase 1** → **Phase 2** → **Phase 3**: Core architecture foundation
2. **Phase 4**: Theming (needed for UI development)
3. **Phase 5**: Navigation (needed for screen development)
4. **Phase 6**: Providers (needed for UI state management)
5. **Phase 7** → **Phase 8**: UI implementation
6. **Phase 9**: Additional features
7. **Phase 10** → **Phase 12**: Testing and polish

### Parallel Development Opportunities:
- Phase 4 (Theming) can start alongside Phase 3 (Data Layer)
- Phase 7 (Shared Widgets) can be developed during Phase 6 (Providers)
- Phase 9 (Additional Features) can be developed in parallel with Phase 10 (Testing)

### Estimated Timeline:
- **Phases 1-3**: 2-3 weeks (Foundation)
- **Phases 4-5**: 1 week (Theming & Navigation)
- **Phases 6-8**: 2-3 weeks (Core Features)
- **Phase 9**: 1-2 weeks (Additional Features)
- **Phases 10-12**: 1-2 weeks (Testing & Polish)

**Total Estimated Time: 7-11 weeks**

This plan ensures systematic development following clean architecture principles while maintaining code quality and testability throughout the process.
