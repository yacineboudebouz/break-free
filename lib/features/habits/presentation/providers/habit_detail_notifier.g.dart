// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$habitDetailStatsHash() => r'3650dd40820a01278ce26f5a505f7d0689f8e62c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for habit detail statistics
///
/// Copied from [habitDetailStats].
@ProviderFor(habitDetailStats)
const habitDetailStatsProvider = HabitDetailStatsFamily();

/// Provider for habit detail statistics
///
/// Copied from [habitDetailStats].
class HabitDetailStatsFamily extends Family<HabitDetailStats> {
  /// Provider for habit detail statistics
  ///
  /// Copied from [habitDetailStats].
  const HabitDetailStatsFamily();

  /// Provider for habit detail statistics
  ///
  /// Copied from [habitDetailStats].
  HabitDetailStatsProvider call(String habitId) {
    return HabitDetailStatsProvider(habitId);
  }

  @override
  HabitDetailStatsProvider getProviderOverride(
    covariant HabitDetailStatsProvider provider,
  ) {
    return call(provider.habitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitDetailStatsProvider';
}

/// Provider for habit detail statistics
///
/// Copied from [habitDetailStats].
class HabitDetailStatsProvider extends AutoDisposeProvider<HabitDetailStats> {
  /// Provider for habit detail statistics
  ///
  /// Copied from [habitDetailStats].
  HabitDetailStatsProvider(String habitId)
    : this._internal(
        (ref) => habitDetailStats(ref as HabitDetailStatsRef, habitId),
        from: habitDetailStatsProvider,
        name: r'habitDetailStatsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$habitDetailStatsHash,
        dependencies: HabitDetailStatsFamily._dependencies,
        allTransitiveDependencies:
            HabitDetailStatsFamily._allTransitiveDependencies,
        habitId: habitId,
      );

  HabitDetailStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(
    HabitDetailStats Function(HabitDetailStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HabitDetailStatsProvider._internal(
        (ref) => create(ref as HabitDetailStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<HabitDetailStats> createElement() {
    return _HabitDetailStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitDetailStatsProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitDetailStatsRef on AutoDisposeProviderRef<HabitDetailStats> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitDetailStatsProviderElement
    extends AutoDisposeProviderElement<HabitDetailStats>
    with HabitDetailStatsRef {
  _HabitDetailStatsProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitDetailStatsProvider).habitId;
}

String _$habitDetailIsLoadingHash() =>
    r'bdd89decafe7cdae2d9a84623d555524ded0c867';

/// Convenience providers for accessing specific aspects of habit detail
///
/// Copied from [habitDetailIsLoading].
@ProviderFor(habitDetailIsLoading)
const habitDetailIsLoadingProvider = HabitDetailIsLoadingFamily();

/// Convenience providers for accessing specific aspects of habit detail
///
/// Copied from [habitDetailIsLoading].
class HabitDetailIsLoadingFamily extends Family<bool> {
  /// Convenience providers for accessing specific aspects of habit detail
  ///
  /// Copied from [habitDetailIsLoading].
  const HabitDetailIsLoadingFamily();

  /// Convenience providers for accessing specific aspects of habit detail
  ///
  /// Copied from [habitDetailIsLoading].
  HabitDetailIsLoadingProvider call(String habitId) {
    return HabitDetailIsLoadingProvider(habitId);
  }

  @override
  HabitDetailIsLoadingProvider getProviderOverride(
    covariant HabitDetailIsLoadingProvider provider,
  ) {
    return call(provider.habitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitDetailIsLoadingProvider';
}

/// Convenience providers for accessing specific aspects of habit detail
///
/// Copied from [habitDetailIsLoading].
class HabitDetailIsLoadingProvider extends AutoDisposeProvider<bool> {
  /// Convenience providers for accessing specific aspects of habit detail
  ///
  /// Copied from [habitDetailIsLoading].
  HabitDetailIsLoadingProvider(String habitId)
    : this._internal(
        (ref) => habitDetailIsLoading(ref as HabitDetailIsLoadingRef, habitId),
        from: habitDetailIsLoadingProvider,
        name: r'habitDetailIsLoadingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$habitDetailIsLoadingHash,
        dependencies: HabitDetailIsLoadingFamily._dependencies,
        allTransitiveDependencies:
            HabitDetailIsLoadingFamily._allTransitiveDependencies,
        habitId: habitId,
      );

  HabitDetailIsLoadingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(
    bool Function(HabitDetailIsLoadingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HabitDetailIsLoadingProvider._internal(
        (ref) => create(ref as HabitDetailIsLoadingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _HabitDetailIsLoadingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitDetailIsLoadingProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitDetailIsLoadingRef on AutoDisposeProviderRef<bool> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitDetailIsLoadingProviderElement
    extends AutoDisposeProviderElement<bool>
    with HabitDetailIsLoadingRef {
  _HabitDetailIsLoadingProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitDetailIsLoadingProvider).habitId;
}

String _$habitDetailErrorHash() => r'b058c36581465350ace65bc19edfc4b3df938267';

/// See also [habitDetailError].
@ProviderFor(habitDetailError)
const habitDetailErrorProvider = HabitDetailErrorFamily();

/// See also [habitDetailError].
class HabitDetailErrorFamily extends Family<String?> {
  /// See also [habitDetailError].
  const HabitDetailErrorFamily();

  /// See also [habitDetailError].
  HabitDetailErrorProvider call(String habitId) {
    return HabitDetailErrorProvider(habitId);
  }

  @override
  HabitDetailErrorProvider getProviderOverride(
    covariant HabitDetailErrorProvider provider,
  ) {
    return call(provider.habitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitDetailErrorProvider';
}

/// See also [habitDetailError].
class HabitDetailErrorProvider extends AutoDisposeProvider<String?> {
  /// See also [habitDetailError].
  HabitDetailErrorProvider(String habitId)
    : this._internal(
        (ref) => habitDetailError(ref as HabitDetailErrorRef, habitId),
        from: habitDetailErrorProvider,
        name: r'habitDetailErrorProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$habitDetailErrorHash,
        dependencies: HabitDetailErrorFamily._dependencies,
        allTransitiveDependencies:
            HabitDetailErrorFamily._allTransitiveDependencies,
        habitId: habitId,
      );

  HabitDetailErrorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(String? Function(HabitDetailErrorRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: HabitDetailErrorProvider._internal(
        (ref) => create(ref as HabitDetailErrorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String?> createElement() {
    return _HabitDetailErrorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitDetailErrorProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitDetailErrorRef on AutoDisposeProviderRef<String?> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitDetailErrorProviderElement
    extends AutoDisposeProviderElement<String?>
    with HabitDetailErrorRef {
  _HabitDetailErrorProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitDetailErrorProvider).habitId;
}

String _$habitDetailActionErrorHash() =>
    r'2f134d561abfa9463fe07bc4cf60b5e7e08796aa';

/// See also [habitDetailActionError].
@ProviderFor(habitDetailActionError)
const habitDetailActionErrorProvider = HabitDetailActionErrorFamily();

/// See also [habitDetailActionError].
class HabitDetailActionErrorFamily extends Family<String?> {
  /// See also [habitDetailActionError].
  const HabitDetailActionErrorFamily();

  /// See also [habitDetailActionError].
  HabitDetailActionErrorProvider call(String habitId) {
    return HabitDetailActionErrorProvider(habitId);
  }

  @override
  HabitDetailActionErrorProvider getProviderOverride(
    covariant HabitDetailActionErrorProvider provider,
  ) {
    return call(provider.habitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitDetailActionErrorProvider';
}

/// See also [habitDetailActionError].
class HabitDetailActionErrorProvider extends AutoDisposeProvider<String?> {
  /// See also [habitDetailActionError].
  HabitDetailActionErrorProvider(String habitId)
    : this._internal(
        (ref) =>
            habitDetailActionError(ref as HabitDetailActionErrorRef, habitId),
        from: habitDetailActionErrorProvider,
        name: r'habitDetailActionErrorProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$habitDetailActionErrorHash,
        dependencies: HabitDetailActionErrorFamily._dependencies,
        allTransitiveDependencies:
            HabitDetailActionErrorFamily._allTransitiveDependencies,
        habitId: habitId,
      );

  HabitDetailActionErrorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(
    String? Function(HabitDetailActionErrorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HabitDetailActionErrorProvider._internal(
        (ref) => create(ref as HabitDetailActionErrorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String?> createElement() {
    return _HabitDetailActionErrorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitDetailActionErrorProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitDetailActionErrorRef on AutoDisposeProviderRef<String?> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitDetailActionErrorProviderElement
    extends AutoDisposeProviderElement<String?>
    with HabitDetailActionErrorRef {
  _HabitDetailActionErrorProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitDetailActionErrorProvider).habitId;
}

String _$habitDetailHash() => r'be575a5add3690b868d4ed12ea783cb0e02bc11b';

/// See also [habitDetail].
@ProviderFor(habitDetail)
const habitDetailProvider = HabitDetailFamily();

/// See also [habitDetail].
class HabitDetailFamily extends Family<Habit?> {
  /// See also [habitDetail].
  const HabitDetailFamily();

  /// See also [habitDetail].
  HabitDetailProvider call(String habitId) {
    return HabitDetailProvider(habitId);
  }

  @override
  HabitDetailProvider getProviderOverride(
    covariant HabitDetailProvider provider,
  ) {
    return call(provider.habitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitDetailProvider';
}

/// See also [habitDetail].
class HabitDetailProvider extends AutoDisposeProvider<Habit?> {
  /// See also [habitDetail].
  HabitDetailProvider(String habitId)
    : this._internal(
        (ref) => habitDetail(ref as HabitDetailRef, habitId),
        from: habitDetailProvider,
        name: r'habitDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$habitDetailHash,
        dependencies: HabitDetailFamily._dependencies,
        allTransitiveDependencies: HabitDetailFamily._allTransitiveDependencies,
        habitId: habitId,
      );

  HabitDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(Habit? Function(HabitDetailRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: HabitDetailProvider._internal(
        (ref) => create(ref as HabitDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Habit?> createElement() {
    return _HabitDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitDetailProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitDetailRef on AutoDisposeProviderRef<Habit?> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitDetailProviderElement extends AutoDisposeProviderElement<Habit?>
    with HabitDetailRef {
  _HabitDetailProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitDetailProvider).habitId;
}

String _$habitDetailHistoryHash() =>
    r'713376782a6084f9d52d0bb5e29a65d0f349c54e';

/// See also [habitDetailHistory].
@ProviderFor(habitDetailHistory)
const habitDetailHistoryProvider = HabitDetailHistoryFamily();

/// See also [habitDetailHistory].
class HabitDetailHistoryFamily extends Family<List<Relapse>> {
  /// See also [habitDetailHistory].
  const HabitDetailHistoryFamily();

  /// See also [habitDetailHistory].
  HabitDetailHistoryProvider call(String habitId) {
    return HabitDetailHistoryProvider(habitId);
  }

  @override
  HabitDetailHistoryProvider getProviderOverride(
    covariant HabitDetailHistoryProvider provider,
  ) {
    return call(provider.habitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitDetailHistoryProvider';
}

/// See also [habitDetailHistory].
class HabitDetailHistoryProvider extends AutoDisposeProvider<List<Relapse>> {
  /// See also [habitDetailHistory].
  HabitDetailHistoryProvider(String habitId)
    : this._internal(
        (ref) => habitDetailHistory(ref as HabitDetailHistoryRef, habitId),
        from: habitDetailHistoryProvider,
        name: r'habitDetailHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$habitDetailHistoryHash,
        dependencies: HabitDetailHistoryFamily._dependencies,
        allTransitiveDependencies:
            HabitDetailHistoryFamily._allTransitiveDependencies,
        habitId: habitId,
      );

  HabitDetailHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(
    List<Relapse> Function(HabitDetailHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HabitDetailHistoryProvider._internal(
        (ref) => create(ref as HabitDetailHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Relapse>> createElement() {
    return _HabitDetailHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitDetailHistoryProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitDetailHistoryRef on AutoDisposeProviderRef<List<Relapse>> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitDetailHistoryProviderElement
    extends AutoDisposeProviderElement<List<Relapse>>
    with HabitDetailHistoryRef {
  _HabitDetailHistoryProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitDetailHistoryProvider).habitId;
}

String _$habitDetailCanLoadMoreHash() =>
    r'c2a46624896d9a03f3b52410b4184381205fbb18';

/// See also [habitDetailCanLoadMore].
@ProviderFor(habitDetailCanLoadMore)
const habitDetailCanLoadMoreProvider = HabitDetailCanLoadMoreFamily();

/// See also [habitDetailCanLoadMore].
class HabitDetailCanLoadMoreFamily extends Family<bool> {
  /// See also [habitDetailCanLoadMore].
  const HabitDetailCanLoadMoreFamily();

  /// See also [habitDetailCanLoadMore].
  HabitDetailCanLoadMoreProvider call(String habitId) {
    return HabitDetailCanLoadMoreProvider(habitId);
  }

  @override
  HabitDetailCanLoadMoreProvider getProviderOverride(
    covariant HabitDetailCanLoadMoreProvider provider,
  ) {
    return call(provider.habitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitDetailCanLoadMoreProvider';
}

/// See also [habitDetailCanLoadMore].
class HabitDetailCanLoadMoreProvider extends AutoDisposeProvider<bool> {
  /// See also [habitDetailCanLoadMore].
  HabitDetailCanLoadMoreProvider(String habitId)
    : this._internal(
        (ref) =>
            habitDetailCanLoadMore(ref as HabitDetailCanLoadMoreRef, habitId),
        from: habitDetailCanLoadMoreProvider,
        name: r'habitDetailCanLoadMoreProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$habitDetailCanLoadMoreHash,
        dependencies: HabitDetailCanLoadMoreFamily._dependencies,
        allTransitiveDependencies:
            HabitDetailCanLoadMoreFamily._allTransitiveDependencies,
        habitId: habitId,
      );

  HabitDetailCanLoadMoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  Override overrideWith(
    bool Function(HabitDetailCanLoadMoreRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HabitDetailCanLoadMoreProvider._internal(
        (ref) => create(ref as HabitDetailCanLoadMoreRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _HabitDetailCanLoadMoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitDetailCanLoadMoreProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitDetailCanLoadMoreRef on AutoDisposeProviderRef<bool> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitDetailCanLoadMoreProviderElement
    extends AutoDisposeProviderElement<bool>
    with HabitDetailCanLoadMoreRef {
  _HabitDetailCanLoadMoreProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitDetailCanLoadMoreProvider).habitId;
}

String _$habitDetailNotifierHash() =>
    r'99172cc23189c7a9882b07faff3242c934e705e9';

abstract class _$HabitDetailNotifier
    extends BuildlessAutoDisposeNotifier<HabitDetailState> {
  late final String habitId;

  HabitDetailState build(String habitId);
}

/// Notifier for managing individual habit detail state
///
/// Copied from [HabitDetailNotifier].
@ProviderFor(HabitDetailNotifier)
const habitDetailNotifierProvider = HabitDetailNotifierFamily();

/// Notifier for managing individual habit detail state
///
/// Copied from [HabitDetailNotifier].
class HabitDetailNotifierFamily extends Family<HabitDetailState> {
  /// Notifier for managing individual habit detail state
  ///
  /// Copied from [HabitDetailNotifier].
  const HabitDetailNotifierFamily();

  /// Notifier for managing individual habit detail state
  ///
  /// Copied from [HabitDetailNotifier].
  HabitDetailNotifierProvider call(String habitId) {
    return HabitDetailNotifierProvider(habitId);
  }

  @override
  HabitDetailNotifierProvider getProviderOverride(
    covariant HabitDetailNotifierProvider provider,
  ) {
    return call(provider.habitId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'habitDetailNotifierProvider';
}

/// Notifier for managing individual habit detail state
///
/// Copied from [HabitDetailNotifier].
class HabitDetailNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<HabitDetailNotifier, HabitDetailState> {
  /// Notifier for managing individual habit detail state
  ///
  /// Copied from [HabitDetailNotifier].
  HabitDetailNotifierProvider(String habitId)
    : this._internal(
        () => HabitDetailNotifier()..habitId = habitId,
        from: habitDetailNotifierProvider,
        name: r'habitDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$habitDetailNotifierHash,
        dependencies: HabitDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            HabitDetailNotifierFamily._allTransitiveDependencies,
        habitId: habitId,
      );

  HabitDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.habitId,
  }) : super.internal();

  final String habitId;

  @override
  HabitDetailState runNotifierBuild(covariant HabitDetailNotifier notifier) {
    return notifier.build(habitId);
  }

  @override
  Override overrideWith(HabitDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: HabitDetailNotifierProvider._internal(
        () => create()..habitId = habitId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        habitId: habitId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<HabitDetailNotifier, HabitDetailState>
  createElement() {
    return _HabitDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitDetailNotifierProvider && other.habitId == habitId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, habitId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HabitDetailNotifierRef
    on AutoDisposeNotifierProviderRef<HabitDetailState> {
  /// The parameter `habitId` of this provider.
  String get habitId;
}

class _HabitDetailNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          HabitDetailNotifier,
          HabitDetailState
        >
    with HabitDetailNotifierRef {
  _HabitDetailNotifierProviderElement(super.provider);

  @override
  String get habitId => (origin as HabitDetailNotifierProvider).habitId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
