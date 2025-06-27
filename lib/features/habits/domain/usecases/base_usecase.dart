import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';

/// Base class for all use cases
///
/// Use cases represent business logic operations and follow the single
/// responsibility principle. Each use case should handle one specific
/// business operation.
abstract class UseCase<Type, Params> {
  /// Execute the use case with the given parameters
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case that doesn't require any parameters
abstract class UseCaseNoParams<Type> {
  /// Execute the use case without parameters
  Future<Either<Failure, Type>> call();
}

/// Represents no parameters for use cases that don't need any
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
