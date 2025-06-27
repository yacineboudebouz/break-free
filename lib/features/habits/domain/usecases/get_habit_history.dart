import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/relapse.dart';
import '../repositories/habit_repository.dart';
import 'base_usecase.dart';

/// Use case for getting the history of a specific habit
///
/// This use case retrieves all relapses and events for a habit,
/// optionally with pagination support.
class GetHabitHistory implements UseCase<List<Relapse>, GetHabitHistoryParams> {
  final HabitRepository repository;

  const GetHabitHistory(this.repository);

  @override
  Future<Either<Failure, List<Relapse>>> call(
    GetHabitHistoryParams params,
  ) async {
    try {
      AppLogger.info('Getting history for habit: ${params.habitId}');

      if (params.habitId.trim().isEmpty) {
        AppLogger.warning('Habit ID is empty');
        return Left(ValidationFailure(message: 'Habit ID cannot be empty'));
      }

      if (params.limit != null && params.limit! <= 0) {
        AppLogger.warning('Invalid limit value: ${params.limit}');
        return Left(ValidationFailure(message: 'Limit must be greater than 0'));
      }

      if (params.offset != null && params.offset! < 0) {
        AppLogger.warning('Invalid offset value: ${params.offset}');
        return Left(ValidationFailure(message: 'Offset must be non-negative'));
      }

      // Get the history through repository
      final result = await repository.getHabitHistory(
        params.habitId,
        limit: params.limit,
        offset: params.offset,
      );

      return result.fold(
        (failure) {
          AppLogger.error('Failed to get habit history: ${failure.message}');
          return Left(failure);
        },
        (history) {
          AppLogger.info(
            'Successfully retrieved ${history.length} history entries for habit: ${params.habitId}',
          );
          return Right(history);
        },
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Unexpected error while getting habit history',
        e,
        stackTrace,
      );
      return Left(
        UnexpectedFailure(
          message: 'Failed to get habit history: ${e.toString()}',
        ),
      );
    }
  }
}

/// Parameters for the GetHabitHistory use case
class GetHabitHistoryParams extends Equatable {
  final String habitId;
  final int? limit;
  final int? offset;

  const GetHabitHistoryParams({required this.habitId, this.limit, this.offset});

  @override
  List<Object?> get props => [habitId, limit, offset];
}
