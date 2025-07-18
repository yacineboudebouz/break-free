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
    this.floatingActionButton,
    this.drawer,
    this.scaffoldKey,
  });

  final Widget? bottomNavigationBar;
  final double? paddingH;
  final double? paddingV;
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingH ?? 0,
          vertical: paddingV ?? 0,
        ),
        child: body,
      ),
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
