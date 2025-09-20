import 'package:bad_habit_killer/src/core/presentation/styles/sizes.dart';
import 'package:bad_habit_killer/src/features/help/domain/advice_model.dart';
import 'package:flutter/material.dart';

class AdviceWidget extends StatefulWidget {
  const AdviceWidget({super.key, required this.advice});

  final AdviceModel advice;

  @override
  State<AdviceWidget> createState() => _AdviceWidgetState();
}

class _AdviceWidgetState extends State<AdviceWidget> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          horizontal: Sizes.marginH12,
          vertical: Sizes.marginV16,
        ),
        padding: EdgeInsets.all(Sizes.spacing24),

        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 1200),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardColor,
              blurRadius: 20,
              offset: Offset(5, 10),
            ),
          ],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(isExpanded ? 20 : 0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.advice.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: Colors.white,
                  size: 27,
                ),
              ],
            ),
            isExpanded ? SizedBox() : SizedBox(height: 20),
            AnimatedCrossFade(
              firstChild: SizedBox.shrink(),
              secondChild: Text(
                widget.advice.description,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 16),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 1200),
              reverseDuration: Duration.zero,
              sizeCurve: Curves.fastLinearToSlowEaseIn,
            ),
          ],
        ),
      ),
    );
  }
}
