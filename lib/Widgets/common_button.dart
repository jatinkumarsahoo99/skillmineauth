import 'package:flutter/material.dart';
import 'package:skillmineauth/Widgets/tap_effect.dart';

import '../AuthUi/text_styles.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String? buttonText;
  final Widget? buttonTextWidget;
  final Color? textColor, backgroundColor;
  final bool? isClickable;
  final double radius;
  final double? height;
  final bool isIcon;
  final IconData? icon;
  const CommonButton({
    Key? key,
    this.onTap,
    this.buttonText,
    this.buttonTextWidget,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.padding,
    this.isClickable = true,
    this.radius = 24,
    this.height = 48,
    this.icon = Icons.arrow_forward,
    this.isIcon = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(),
      child: TapEffect(
        isClickable: isClickable!,
        onClick: onTap ?? () {},
        child: SizedBox(
          height: height??48,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            color: backgroundColor ?? Theme.of(context).primaryColor,
            shadowColor: Colors.black12.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.2,
            ),
            child: (isIcon)?Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buttonTextWidget ??
                    Text(
                      buttonText ?? "",
                      style: TextStyles(context).getRegularStyle().copyWith(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                Icon(icon,color: Colors.white,size: 15,)
              ],
            ): Center(
              child: buttonTextWidget ??
                  Text(
                    buttonText ?? "",
                    style: TextStyles(context).getRegularStyle().copyWith(
                          color: textColor,
                          fontSize: 16,
                      fontWeight: FontWeight.bold
                        ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
