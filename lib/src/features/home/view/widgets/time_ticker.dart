import 'dart:async';

import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';

class TimeTicker extends HookConsumerWidget {
  const TimeTicker({super.key, required this.color, required this.dateTime});
  final Color color;
  final DateTime dateTime;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final days = difference.inDays.toString().padLeft(2, '0');
    final hours = (difference.inHours % 24).toString().padLeft(2, '0');
    final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');
    final progressTime = useState<TimerState>(
      TimerState(days: days, hours: hours, minutes: minutes, seconds: seconds),
    );

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final now = DateTime.now();
        final difference = now.difference(dateTime);
        final days = difference.inDays.toString();
        final hours = (difference.inHours % 24).toString().padLeft(2, '0');
        final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
        final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

        progressTime.value = TimerState(
          days: days.toString().padLeft(2, '0'),
          hours: hours.toString().padLeft(2, '0'),
          minutes: minutes.toString().padLeft(2, '0'),
          seconds: seconds.toString().padLeft(2, '0'),
        );
      });
      return timer.cancel;
    });
    return Container(
      padding: const EdgeInsets.all(8.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${progressTime.value.days}d'),
          const SizedBox(width: 8.0),
          Text('${progressTime.value.hours}h'),
          const SizedBox(width: 8.0),
          Text('${progressTime.value.minutes}m'),
          const SizedBox(width: 8.0),
          Text('${progressTime.value.seconds}s'),
        ],
      ),
    );
  }
}

class TimerState {
  final String days;
  final String hours;
  final String minutes;
  final String seconds;

  TimerState({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}
