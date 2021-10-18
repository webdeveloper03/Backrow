library bottom_navy_bar;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'color.dart';

/// A beautiful and animated bottom navigation that paints a rounded shape
/// around its [items] to provide a wonderful look.
///
/// Update [selectedIndex] to change the selected item.
/// [selectedIndex] is  and must not be null.
class CustomBottomNavigationBar extends StatelessWidget {

  CustomBottomNavigationBar({
    Key key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 34,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.items,
    this.onItemSelected,
    this.curve = Curves.linear,
  }) : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  /// The selected item is index. Changing this property will change and animate
  /// the item being selected. Defaults to zero.
  final int selectedIndex;

  /// The icon size of all items. Defaults to 24.
  final double iconSize;

  /// The background color of the navigation bar. It defaults to
  /// [Theme.bottomAppBarColor] if not provided.
  final Color backgroundColor;

  /// Whether this navigation bar should show a elevation. Defaults to true.
  final bool showElevation;

  /// Use this to change the item's animation duration. Defaults to 270ms.
  final Duration animationDuration;

  /// Defines the appearance of the buttons that are displayed in the bottom
  /// navigation bar. This should have at least two items and five at most.
  final List<CustomBottomNavyBarItem> items;

  /// A callback that will be called when a item is pressed.
  final ValueChanged<int> onItemSelected;

  /// Defines the alignment of the items.
  /// Defaults to [MainAxisAlignment.spaceBetween].
  final MainAxisAlignment mainAxisAlignment;

  /// The [items] corner radius, if not set, it defaults to 50.
  final double itemCornerRadius;

  /// Defines the bottom navigation bar height. Defaults to 56.
  final double containerHeight;

  /// Used to configure the animation curve. Defaults to [Curves.linear].
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.all(10),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            gradient:LinearGradient(colors: [
              ColorConstant.customBtnGradient1,
              ColorConstant.customBtnGradient2,
            ], begin: Alignment.topCenter,end: Alignment.bottomCenter),
          boxShadow: [
            if (showElevation)
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
              ),
          ],
        ),
        child: Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: Colors.transparent,
                  itemCornerRadius: 14,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final CustomBottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key key,
     this.item,
     this.isSelected,
     this.backgroundColor,
     this.animationDuration,
     this.itemCornerRadius,
     this.iconSize,
    this.curve = Curves.linear,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(item.title.toString());
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? (item.title.toString().toLowerCase().contains("site"))?150:130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color:
          isSelected ? Colors.amber : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
          gradient: LinearGradient(colors: [
            Colors.amberAccent.withOpacity(0.9),
            Colors.amber
          ], begin: Alignment.topCenter,end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? (item.title.toString().toLowerCase().contains("site"))?150:130 : 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 32,
                  child: isSelected?item.activeIcon:item.inActiveIcon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: item.activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The [BottomNavyBar.items] definition.
class CustomBottomNavyBarItem {

  CustomBottomNavyBarItem({
     this.activeIcon,
     this.inActiveIcon,
     this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });

  /// Defines this item's icon which is placed in the right side of the [title].
  final Widget activeIcon;
  final Widget inActiveIcon;

  /// Defines this item's title which placed in the left side of the [icon].
  final Widget title;

  /// The [icon] and [title] color defined when this item is selected. Defaults
  /// to [Colors.blue].
  final Color activeColor;

  /// The [icon] and [title] color defined when this item is not selected.
  final Color inactiveColor;

  /// The alignment for the [title].
  ///
  /// This will take effect only if [title] it a [Text] widget.
  final TextAlign textAlign;

}
