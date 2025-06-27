import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';
import 'base_usecase.dart';

/// Use case for adding a new habit
///
/// This use case handles the business logic for creating a new habit,
/// including validation and proper initialization of default values.
class AddHabit implements UseCase<Habit, AddHabitParams> {
  final HabitRepository repository;

  const AddHabit(this.repository);

  @override
  Future<Either<Failure, Habit>> call(AddHabitParams params) async {
    try {
      AppLogger.info('Adding new habit: ${params.habit.name}');
      // Validate the habit
      final validationErrors = params.habit.validate();
      if (validationErrors.isNotEmpty) {
        AppLogger.warning('Habit validation failed: $validationErrors');
        return Left(ValidationFailure(message: validationErrors.join(', ')));
      }

      // Ensure the habit has proper initial values
      final now = DateTime.now();
      final habitToAdd = params.habit.copyWith(
        createdAt: now,
        updatedAt: now,
        startDate: params.habit.startDate,
        currentStreak: 0,
        bestStreak: 0,
        totalRelapses: 0,
        totalSuccessDays: 0,
        isActive: true,
      );

      // Add the habit through repository
      final result = await repository.addHabit(habitToAdd);

      return result.fold(
        (failure) {
          AppLogger.error('Failed to add habit: ${failure.message}');
          return Left(failure);
        },
        (habit) {
          AppLogger.info(
            'Successfully added habit: ${habit.name} with ID: ${habit.id}',
          );
          return Right(habit);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error while adding habit', e, stackTrace);
      return Left(
        UnexpectedFailure(message: 'Failed to add habit: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for the AddHabit use case
class AddHabitParams extends Equatable {
  final Habit habit;

  const AddHabitParams({required this.habit});

  @override
  List<Object?> get props => [habit];
}
