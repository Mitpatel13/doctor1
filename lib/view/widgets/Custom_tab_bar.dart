import 'package:flutter/material.dart';

import '../Utils/colors.dart';
import 'big_text.dart';

class CustomTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;
  final List<String> items;

  const CustomTabBar({
    super.key,
    required this.items,
    required this.icons,
    required this.selectedIndex,
    required this.onTap,
    this.isBottomIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        // border: isBottomIndicator
        //     ? Border(
        //         bottom: BorderSide(
        //           color: AppColors.mainColor,
        //           width: 2.5,
        //         ),
        //       )
        //     : Border(
        //         top: BorderSide(
        //           color: AppColors.mainColor,
        //           width: 2.5,
        //         ),
        //       ),
        border: isBottomIndicator
            ? Border(
                bottom: BorderSide(
                  color: AppColors.mainColor,
                  width: 2.5,
                ),
              )
            : Border(
                top: BorderSide(
                  color: AppColors.mainColor,
                  width: 2.5,
                ),
              ),
      ),
      tabs: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                Tab(
                  icon: Column(
                    children: [
                      Icon(
                        e,
                        color: i == selectedIndex
                            ? AppColors.mainColor
                            : Colors.black45,
                        size: 26.0,
                      ),
                      BigText(
                        text: items[i],
                        weight: FontWeight.w500,
                        size: 10,
                        color: i == selectedIndex
                            ? AppColors.mainColor
                            : Colors.black45,
                      )
                    ],
                  ),
                ),
              ))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
