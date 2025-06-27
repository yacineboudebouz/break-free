import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';
import 'base_usecase.dart';

/// Use case for retrieving habits with optional filtering
///
/// This use case handles fetching habits from the repository with
/// optional filtering by type or category.
class GetHabits implements UseCase<List<Habit>, GetHabitsParams> {
  final HabitRepository repository;

  const GetHabits(this.repository);

  @override
  Future<Either<Failure, List<Habit>>> call(GetHabitsParams params) async {
    try {
      AppLogger.info(
        'Getting habits with filters: type=${params.type}, category=${params.category}',
      );

      late Either<Failure, List<Habit>> result;

      if (params.type != null && params.category != null) {
        // If both type and category are specified, get by type first then filter by category
        result = await repository.getHabitsByType(params.type!);
        return result.fold((failure) => Left(failure), (habits) {
          final filteredHabits = habits
              .where((habit) => habit.category == params.category)
              .toList();
          return Right(filteredHabits);
        });
      } else if (params.type != null) {
        // Filter by type only
        result = await repository.getHabitsByType(params.type!);
      } else if (params.category != null) {
        // Filter by category only
        result = await repository.getHabitsByCategory(params.category!);
      } else {
        // Get all habits
        result = await repository.getHabits();
      }

      return result.fold(
        (failure) {
          AppLogger.error('Failed to get habits: ${failure.message}');
          return Left(failure);
        },
        (habits) {
          AppLogger.info('Successfully retrieved ${habits.length} habits');
          return Right(habits);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error while getting habits', e, stackTrace);
      return Left(
        UnexpectedFailure(message: 'Failed to get habits: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for the GetHabits use case
class GetHabitsParams extends Equatable {
  final HabitType? type;
  final HabitCategory? category;

  const GetHabitsParams({this.type, this.category});

  @override
  List<Object?> get props => [type, category];
}
