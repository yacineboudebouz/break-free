import 'package:bad_habit_killer/src/core/config/routing/app_router.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/context_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/extensions/go_router_ext.dart';
import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/core/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  static final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      scaffoldKey: drawerKey,
      drawer: Drawer(child: SizedBox.expand(child: Column())),
      body: Column(
        spacing: Sizes.spacing8,
        children: [
          Container(
            height: context.height * 0.12,
            padding: const EdgeInsets.all(Sizes.spacing16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: Sizes.paddingV24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.settings, size: Sizes.icon28),
                    onPressed: () {
                      drawerKey.currentState?.openDrawer();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search habits',

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.radius32),
                          borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search, size: Sizes.icon24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add habit action
          context.goNamed(AppRouter.addHabit.name);
        },
        child: Icon(Icons.add, size: Sizes.icon24),
      ),
    );
  }
}
