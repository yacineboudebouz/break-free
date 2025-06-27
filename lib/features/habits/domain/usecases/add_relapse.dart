import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/habit.dart';
import '../entities/relapse.dart';
import '../repositories/habit_repository.dart';
import 'base_usecase.dart';

/// Use case for adding a relapse/failure event to a habit
///
/// This use case handles the business logic for recording a relapse,
/// including updating habit statistics and streak information.
class AddRelapse implements UseCase<Habit, AddRelapseParams> {
  final HabitRepository repository;

  const AddRelapse(this.repository);

  @override
  Future<Either<Failure, Habit>> call(AddRelapseParams params) async {
    try {
      AppLogger.info('Adding relapse for habit: ${params.relapse.habitId}');

      // Validate the relapse
      final validationErrors = params.relapse.validate();
      if (validationErrors.isNotEmpty) {
        AppLogger.warning('Relapse validation failed: $validationErrors');
        return Left(ValidationFailure(message: validationErrors.join(', ')));
      } // Ensure the relapse has proper timestamps
      final now = DateTime.now();
      final relapseToAdd = params.relapse.copyWith(updatedAt: now);

      // Add the relapse through repository
      final result = await repository.addRelapse(relapseToAdd);

      return result.fold(
        (failure) {
          AppLogger.error('Failed to add relapse: ${failure.message}');
          return Left(failure);
        },
        (habit) {
          AppLogger.info(
            'Successfully added relapse for habit: ${habit.name} (ID: ${habit.id})',
          );
          return Right(habit);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error while adding relapse', e, stackTrace);
      return Left(
        UnexpectedFailure(message: 'Failed to add relapse: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for the AddRelapse use case
class AddRelapseParams extends Equatable {
  final Relapse relapse;

  const AddRelapseParams({required this.relapse});

  @override
  List<Object?> get props => [relapse];
}
