import 'package:flutter/material.dart';
import 'default_styles.dart' show defaultHeaderTextStyle;

class CalendarHeader extends StatelessWidget {
  /// Passing in values for [leftButtonIcon] or [rightButtonIcon] will override [headerIconColor]
  CalendarHeader(
      {required this.headerTitle,
      this.headerMargin,
      required this.showHeader,
      this.headerTextStyle,
      this.showHeaderButtons = true,
      this.headerIconColor,
      this.leftButtonIcon,
      this.rightButtonIcon,
      required this.onLeftButtonPressed,
      this.disableLeftButtonIf,
      required this.onRightButtonPressed,
      this.disableRightButtonIf,
      this.onHeaderTitlePressed})
      : isTitleTouchable = onHeaderTitlePressed != null;

  final String headerTitle;
  final EdgeInsetsGeometry? headerMargin;
  final bool showHeader;
  final TextStyle? headerTextStyle;
  final bool showHeaderButtons;
  final Color? headerIconColor;
  final Widget? leftButtonIcon;
  final Widget? rightButtonIcon;
  final VoidCallback onLeftButtonPressed;
  final bool Function()? disableLeftButtonIf;
  final VoidCallback onRightButtonPressed;
  final bool Function()? disableRightButtonIf;
  final bool isTitleTouchable;
  final VoidCallback? onHeaderTitlePressed;

  TextStyle get getTextStyle => headerTextStyle ?? defaultHeaderTextStyle;

  Widget _leftButton() => IconButton(
        onPressed:
            (disableLeftButtonIf ?? () => true)() ? onLeftButtonPressed : null,
        icon:
            leftButtonIcon ?? Icon(Icons.chevron_left, color: headerIconColor),
      );

  Widget _rightButton() => IconButton(
        onPressed: (disableRightButtonIf ?? () => true)()
            ? onRightButtonPressed
            : null,
        icon: rightButtonIcon ??
            Icon(Icons.chevron_right, color: headerIconColor),
      );

  Widget _headerTouchable() => FlatButton(
        onPressed: onHeaderTitlePressed,
        child: Text(
          headerTitle,
          semanticsLabel: headerTitle,
          style: getTextStyle,
        ),
      );

  @override
  Widget build(BuildContext context) => showHeader
      ? Container(
          margin: headerMargin,
          child: DefaultTextStyle(
              style: getTextStyle,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    showHeaderButtons ? _leftButton() : Container(),
                    isTitleTouchable
                        ? _headerTouchable()
                        : Text(headerTitle, style: getTextStyle),
                    showHeaderButtons ? _rightButton() : Container(),
                  ])),
        )
      : Container();
}
