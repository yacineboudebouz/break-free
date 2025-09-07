part of 'settings_view.dart';

void _changeTheme(WidgetRef ref, BuildContext context) async {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => Container(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Select Theme".hardcoded).fadeIn(),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Light".hardcoded),
                onTap: () {
                  ref
                      .read(appThemeNotifierProvider.notifier)
                      .changeTheme(AppThemeMode.light);
                  context.pop();
                },
              ).fadeIn(delay: Duration(milliseconds: 200)),
              ListTile(
                title: Text("Dark".hardcoded),
                onTap: () {
                  ref
                      .read(appThemeNotifierProvider.notifier)
                      .changeTheme(AppThemeMode.dark);
                  context.pop();
                },
              ).fadeIn(delay: Duration(milliseconds: 400)),
            ],
          ),
        ),
      );
    },
  );
}
