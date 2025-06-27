// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredHabitsHash() => r'69374d150e7c119bcf28130e8701412537f9b9cd';

/// Convenience providers for accessing specific parts of habits state
///
/// Copied from [filteredHabits].
@ProviderFor(filteredHabits)
final filteredHabitsProvider = AutoDisposeProvider<List<Habit>>.internal(
  filteredHabits,
  name: r'filteredHabitsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredHabitsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredHabitsRef = AutoDisposeProviderRef<List<Habit>>;
String _$goodHabitsHash() => r'cb83552146ad7a7b49875801932a6a75da2718a4';

/// See also [goodHabits].
@ProviderFor(goodHabits)
final goodHabitsProvider = AutoDisposeProvider<List<Habit>>.internal(
  goodHabits,
  name: r'goodHabitsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$goodHabitsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoodHabitsRef = AutoDisposeProviderRef<List<Habit>>;
String _$badHabitsHash() => r'82482c8ab0175533bd96d648a0d5a53b7eb400a2';

/// See also [badHabits].
@ProviderFor(badHabits)
final badHabitsProvider = AutoDisposeProvider<List<Habit>>.internal(
  badHabits,
  name: r'badHabitsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$badHabitsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BadHabitsRef = AutoDisposeProviderRef<List<Habit>>;
String _$isHabitsLoadingHash() => r'c992bba67b4aacce7d717a8b68d41655af0f86cc';

/// See also [isHabitsLoading].
@ProviderFor(isHabitsLoading)
final isHabitsLoadingProvider = AutoDisposeProvider<bool>.internal(
  isHabitsLoading,
  name: r'isHabitsLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isHabitsLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsHabitsLoadingRef = AutoDisposeProviderRef<bool>;
String _$habitsErrorHash() => r'c2964732ccfffe9eb8417d9699cd0a40707d4872';

/// See also [habitsError].
@ProviderFor(habitsError)
final habitsErrorProvider = AutoDisposeProvider<String?>.internal(
  habitsError,
  name: r'habitsErrorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$habitsErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HabitsErrorRef = AutoDisposeProviderRef<String?>;
String _$habitsSearchQueryHash() => r'98c173e505575ef05a9fcdefd0f27afac19d1685';

/// See also [habitsSearchQuery].
@ProviderFor(habitsSearchQuery)
final habitsSearchQueryProvider = AutoDisposeProvider<String>.internal(
  habitsSearchQuery,
  name: r'habitsSearchQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$habitsSearchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HabitsSearchQueryRef = AutoDisposeProviderRef<String>;
String _$habitsFilterHash() => r'1df5e115c368f22a24d91cf5c3d61f80da29b38b';

/// See also [habitsFilter].
@ProviderFor(habitsFilter)
final habitsFilterProvider = AutoDisposeProvider<HabitFilter>.internal(
  habitsFilter,
  name: r'habitsFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$habitsFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HabitsFilterRef = AutoDisposeProviderRef<HabitFilter>;
String _$habitsNotifierHash() => r'3471ed1a473e74d64b5faa7f54be6f87e41d3d95';

/// Notifier for managing habits list state
///
/// Copied from [HabitsNotifier].
@ProviderFor(HabitsNotifier)
final habitsNotifierProvider =
    AutoDisposeNotifierProvider<HabitsNotifier, HabitsState>.internal(
      HabitsNotifier.new,
      name: r'habitsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$habitsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HabitsNotifier = AutoDisposeNotifier<HabitsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
