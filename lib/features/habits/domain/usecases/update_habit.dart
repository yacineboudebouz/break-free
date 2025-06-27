import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';
import 'base_usecase.dart';

/// Use case for updating an existing habit
///
/// This use case handles the business logic for updating a habit,
/// including validation and proper update timestamp handling.
class UpdateHabit implements UseCase<Habit, UpdateHabitParams> {
  final HabitRepository repository;

  const UpdateHabit(this.repository);

  @override
  Future<Either<Failure, Habit>> call(UpdateHabitParams params) async {
    try {
      AppLogger.info(
        'Updating habit: ${params.habit.name} (ID: ${params.habit.id})',
      );

      // Validate the habit
      final validationErrors = params.habit.validate();
      if (validationErrors.isNotEmpty) {
        AppLogger.warning('Habit validation failed: $validationErrors');
        return Left(ValidationFailure(message: validationErrors.join(', ')));
      }

      // Ensure the habit has updated timestamp
      final habitToUpdate = params.habit.copyWith(updatedAt: DateTime.now());

      // Update the habit through repository
      final result = await repository.updateHabit(habitToUpdate);

      return result.fold(
        (failure) {
          AppLogger.error('Failed to update habit: ${failure.message}');
          return Left(failure);
        },
        (habit) {
          AppLogger.info(
            'Successfully updated habit: ${habit.name} (ID: ${habit.id})',
          );
          return Right(habit);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error while updating habit', e, stackTrace);
      return Left(
        UnexpectedFailure(message: 'Failed to update habit: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for the UpdateHabit use case
class UpdateHabitParams extends Equatable {
  final Habit habit;

  const UpdateHabitParams({required this.habit});

  @override
  List<Object?> get props => [habit];
}
