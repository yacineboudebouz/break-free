import 'package:bad_habit_killer/src/core/presentation/extensions/app_error_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/string_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/utils/riverpod_framework.dart';
import 'package:quickalert/quickalert.dart';

extension WidgetRefExt on WidgetRef {
  bool isLoading<T>(ProviderListenable<AsyncValue<T>> provider) {
    return watch(provider.select((AsyncValue<T> value) => value.isLoading));
  }

  void listenAndHandleState<T>(
    ProviderListenable<AsyncValue<T>> provider, {
    bool handleError = true,
    bool handleData = false,
    void Function(T data)? whenData,
  }) {
    return listen(provider, (prev, state) {
      state.whenOrNull(
        data: (data) {
          if (handleData) {
            whenData?.call(data);
          }
        },
        error: (error, stackTrace) {
          if (handleError) {
            final errorMessage = error.errorMessage();
            // TODO: i should move this to seperate class where i can handle
            // all alerts in one place
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "Error".hardcoded,
              text: errorMessage,
            );
          }
        },
      );
    });
  }
}
