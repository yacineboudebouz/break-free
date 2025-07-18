import 'package:flutter/material.dart';

/// this scaffold is used to wrap the app with a common scaffold
/// and to aviod code duplication
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.bottomNavigationBar,
    this.paddingH,
    this.paddingV,
    this.body,
    this.appBar,
  });

  final Widget? bottomNavigationBar;
  final double? paddingH;
  final double? paddingV;
  final Widget? body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingH ?? 0,
          vertical: paddingV ?? 0,
        ),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
