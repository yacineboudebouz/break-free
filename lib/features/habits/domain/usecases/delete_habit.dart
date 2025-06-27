import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../repositories/habit_repository.dart';
import 'base_usecase.dart';

/// Use case for deleting a habit
///
/// This use case handles the business logic for deleting a habit
/// and all its associated data (relapses, history, etc.).
class DeleteHabit implements UseCase<Unit, DeleteHabitParams> {
  final HabitRepository repository;

  const DeleteHabit(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteHabitParams params) async {
    try {
      AppLogger.info('Deleting habit with ID: ${params.habitId}');

      if (params.habitId.trim().isEmpty) {
        AppLogger.warning('Habit ID is empty');
        return Left(ValidationFailure(message: 'Habit ID cannot be empty'));
      }

      // Delete the habit through repository
      final result = await repository.deleteHabit(params.habitId);

      return result.fold(
        (failure) {
          AppLogger.error('Failed to delete habit: ${failure.message}');
          return Left(failure);
        },
        (unit) {
          AppLogger.info(
            'Successfully deleted habit with ID: ${params.habitId}',
          );
          return Right(unit);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error while deleting habit', e, stackTrace);
      return Left(
        UnexpectedFailure(message: 'Failed to delete habit: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for the DeleteHabit use case
class DeleteHabitParams extends Equatable {
  final String habitId;

  const DeleteHabitParams({required this.habitId});

  @override
  List<Object?> get props => [habitId];
}
