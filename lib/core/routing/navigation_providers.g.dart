// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$navigationServiceHash() => r'985ed9231050bf48b6c8b193a20fc804c5b8859c';

/// Navigation service for handling app navigation
///
/// Copied from [navigationService].
@ProviderFor(navigationService)
final navigationServiceProvider =
    AutoDisposeProvider<NavigationService>.internal(
      navigationService,
      name: r'navigationServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$navigationServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NavigationServiceRef = AutoDisposeProviderRef<NavigationService>;
String _$currentRouteHash() => r'146a53b810092c755fc1e7966f25c73be339f132';

/// Provider for current route information
///
/// Copied from [currentRoute].
@ProviderFor(currentRoute)
final currentRouteProvider = AutoDisposeProvider<String>.internal(
  currentRoute,
  name: r'currentRouteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentRouteHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentRouteRef = AutoDisposeProviderRef<String>;
String _$canPopHash() => r'0f4bc36d31bfa65e7c3e081924531c3b0039f9b0';

/// Provider to check if we can navigate back
///
/// Copied from [canPop].
@ProviderFor(canPop)
final canPopProvider = AutoDisposeProvider<bool>.internal(
  canPop,
  name: r'canPopProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$canPopHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CanPopRef = AutoDisposeProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
