import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';
import 'base_usecase.dart';

/// Use case for searching habits by name or description
///
/// This use case handles searching through habits based on
/// text queries, searching both name and description fields.
class SearchHabits implements UseCase<List<Habit>, SearchHabitsParams> {
  final HabitRepository repository;

  const SearchHabits(this.repository);

  @override
  Future<Either<Failure, List<Habit>>> call(SearchHabitsParams params) async {
    try {
      AppLogger.info('Searching habits with query: "${params.query}"');

      if (params.query.trim().isEmpty) {
        AppLogger.warning('Search query is empty');
        return Left(ValidationFailure(message: 'Search query cannot be empty'));
      }

      if (params.query.trim().length < 2) {
        AppLogger.warning('Search query too short: "${params.query}"');
        return Left(
          ValidationFailure(
            message: 'Search query must be at least 2 characters long',
          ),
        );
      }

      // Search habits through repository
      final result = await repository.searchHabits(params.query.trim());

      return result.fold(
        (failure) {
          AppLogger.error('Failed to search habits: ${failure.message}');
          return Left(failure);
        },
        (habits) {
          AppLogger.info(
            'Successfully found ${habits.length} habits matching query: "${params.query}"',
          );
          return Right(habits);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error('Unexpected error while searching habits', e, stackTrace);
      return Left(
        UnexpectedFailure(message: 'Failed to search habits: ${e.toString()}'),
      );
    }
  }
}

/// Parameters for the SearchHabits use case
class SearchHabitsParams extends Equatable {
  final String query;

  const SearchHabitsParams({required this.query});

  @override
  List<Object?> get props => [query];
}
