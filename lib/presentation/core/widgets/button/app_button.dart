import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/loading_indicator/app_loading_indicator.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';

enum _AppButtonType {
  primary,
  secondary,
  outlined,
  text,
  danger,
  iconText,
}

enum AppButtonWidth {
  fullWidth,
  adaptive,
  custom,
}

class AppButton extends StatelessWidget {
  const AppButton._({
    Key? key,
    required this.buttonType,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isSmall = false,
    this.isDisabled = false,
    this.gradient,
    this.textColor,
    this.width,
    this.widthType = AppButtonWidth.fullWidth,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign,
    this.borderRadius,
  }) : super(key: key);

  factory AppButton.primary({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isSmall = false,
    bool isDisabled = false,
    Gradient? gradient,
    Color? textColor,
    double? width,
    Widget? suffix,
    TextAlign? align,
    double? borderRadius,
    AppButtonWidth widthType = AppButtonWidth.fullWidth,
  }) {
    return AppButton._(
      buttonType: _AppButtonType.primary,
      label: label,
      isLoading: isLoading,
      isSmall: isSmall,
      isDisabled: isDisabled,
      onPressed: onPressed,
      gradient: gradient,
      textColor: textColor,
      width: width,
      widthType: widthType,
      suffixIcon: suffix,
      textAlign: align,
      borderRadius: borderRadius,
    );
  }

  factory AppButton.secondary({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isSmall = false,
    bool isDisabled = false,
    Gradient? gradient,
    Color? textColor,
    double? width,
    AppButtonWidth widthType = AppButtonWidth.fullWidth,
  }) {
    return AppButton._(
      buttonType: _AppButtonType.secondary,
      label: label,
      isLoading: isLoading,
      isSmall: isSmall,
      isDisabled: isDisabled,
      onPressed: onPressed,
      gradient: gradient,
      textColor: textColor,
      width: width,
      widthType: widthType,
    );
  }

  factory AppButton.outlined({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isSmall = false,
    bool isDisabled = false,
    Gradient? gradient,
    Color? textColor,
    double? width,
    Widget? prefixIcon,
    double? borderRadius,
    AppButtonWidth widthType = AppButtonWidth.fullWidth,
  }) {
    return AppButton._(
      buttonType: _AppButtonType.outlined,
      label: label,
      isLoading: isLoading,
      isSmall: isSmall,
      isDisabled: isDisabled,
      onPressed: onPressed,
      gradient: gradient,
      textColor: textColor,
      width: width,
      widthType: widthType,
      prefixIcon: prefixIcon,
      borderRadius: borderRadius,
    );
  }

  factory AppButton.text({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isSmall = false,
    bool isDisabled = false,
    Gradient? gradient,
    Color? textColor,
    double? width,
    AppButtonWidth widthType = AppButtonWidth.fullWidth,
  }) {
    return AppButton._(
      buttonType: _AppButtonType.text,
      label: label,
      isLoading: isLoading,
      isSmall: isSmall,
      isDisabled: isDisabled,
      onPressed: onPressed,
      gradient: gradient,
      textColor: textColor,
      width: width,
      widthType: widthType,
    );
  }

  factory AppButton.danger({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isSmall = false,
    bool isDisabled = false,
    Gradient? gradient,
    Color? textColor,
    double? width,
    AppButtonWidth widthType = AppButtonWidth.fullWidth,
  }) {
    return AppButton._(
      buttonType: _AppButtonType.danger,
      label: label,
      isLoading: isLoading,
      isSmall: isSmall,
      isDisabled: isDisabled,
      onPressed: onPressed,
      gradient: gradient,
      textColor: textColor,
      width: width,
      widthType: widthType,
    );
  }

  factory AppButton.iconButton({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isSmall = false,
    bool isDisabled = false,
    Gradient? gradient,
    Color? textColor,
    double? width,
    AppButtonWidth widthType = AppButtonWidth.fullWidth,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return AppButton._(
      buttonType: _AppButtonType.iconText,
      label: label,
      isLoading: isLoading,
      isSmall: isSmall,
      isDisabled: isDisabled,
      onPressed: onPressed,
      gradient: gradient,
      textColor: textColor,
      width: width,
      widthType: widthType,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  final _AppButtonType buttonType;
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSmall;
  final bool isDisabled;
  final Gradient? gradient;
  final Color? textColor;
  final double? width;
  final AppButtonWidth widthType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final double? borderRadius;

  double? _getButtonWidth(BuildContext context) {
    switch (widthType) {
      case AppButtonWidth.adaptive:
        return null;
      case AppButtonWidth.custom:
        return width;
      case AppButtonWidth.fullWidth:
        return double.infinity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final padding = isSmall
        ? AppUiConstants.defaultSmallButtonContentPadding
        : AppUiConstants.defaultButtonContentPadding;

    final finalBorderRadius =
        borderRadius ?? AppUiConstants.defaultBorderRadius ?? 0.0;
    final shape = WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(finalBorderRadius),
      ),
    );
    final disableOnPressed = isLoading || isDisabled;

    final Color effectiveTextColor = () {
      if (textColor != null) {
        return disableOnPressed
            ? textColor!.withValues(alpha: 0.44)
            : textColor!;
      }

      switch (buttonType) {
        case _AppButtonType.primary:
          return disableOnPressed
              ? colors.foregroundOnPrimary.withOpacity(0.44)
              : colors.foregroundOnPrimary;
        case _AppButtonType.secondary:
          return disableOnPressed
              ? colors.foregroundOnSecondary.withOpacity(0.44)
              : colors.foregroundOnSecondary;
        case _AppButtonType.danger:
          return disableOnPressed
              ? colors.foregroundOnDanger.withOpacity(0.44)
              : colors.foregroundOnDanger;
        default:
          return disableOnPressed
              ? colors.foregroundOnBackground.withOpacity(0.44)
              : colors.foregroundOnBackground;
      }
    }();

    final TextStyle _textStyle = (isSmall
            ? AppUiConstants.defaultSmallButtonTextStyle
            : AppUiConstants.defaultButtonTextStyle)
        .copyWith(color: effectiveTextColor);

    Widget buildButton(Widget button) {
      if (gradient != null &&
          buttonType != _AppButtonType.text &&
          buttonType != _AppButtonType.outlined) {
        return Container(
          decoration: BoxDecoration(
            gradient:
                isDisabled ? _createDisabledGradient(gradient!) : gradient,
            borderRadius: BorderRadius.circular(finalBorderRadius),
          ),
          child: button,
        );
      }
      return button;
    }

    final button = switch (buttonType) {
      _AppButtonType.primary => TextButton(
          style: TextButton.styleFrom(
            padding: padding,
            textStyle: _textStyle,
            backgroundColor: gradient != null
                ? Colors.transparent
                : (isDisabled
                    ? colors.primary.withOpacity(0.44)
                    : colors.primary),
            foregroundColor: effectiveTextColor,
          ).copyWith(shape: shape),
          onPressed: disableOnPressed ? null : onPressed,
          child: isLoading
              ? AppLoadingIndicator.small(indicatorColor: effectiveTextColor)
              : _AppButtonLabel(
                  label,
                  color: effectiveTextColor,
                  align: textAlign,
                  suffixIcon: suffixIcon,
                ),
        ),
      _AppButtonType.secondary => TextButton(
          style: TextButton.styleFrom(
            padding: padding,
            textStyle: _textStyle,
            backgroundColor: gradient != null
                ? Colors.transparent
                : (isDisabled
                    ? colors.secondary.withOpacity(0.44)
                    : colors.secondary),
            foregroundColor: effectiveTextColor,
          ).copyWith(shape: shape),
          onPressed: disableOnPressed ? null : onPressed,
          child: isLoading
              ? AppLoadingIndicator.small(indicatorColor: effectiveTextColor)
              : _AppButtonLabel(label, color: effectiveTextColor),
        ),
      _AppButtonType.outlined => gradient != null
          ? _GradientOutlinedButton(
              gradient: gradient!,
              isDisabled: isDisabled,
              onPressed: disableOnPressed ? null : onPressed,
              padding: padding,
              textStyle: _textStyle,
              shape: shape,
              borderRadius: finalBorderRadius,
              width: _getButtonWidth(context),
              child: isLoading
                  ? AppLoadingIndicator.small(
                      indicatorColor: effectiveTextColor)
                  : _AppButtonLabel(
                      label,
                      color: effectiveTextColor,
                      prefixIcon: prefixIcon,
                    ),
            )
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: padding,
                textStyle: _textStyle,
              ).copyWith(shape: shape),
              onPressed: disableOnPressed ? null : onPressed,
              child: isLoading
                  ? AppLoadingIndicator.small(
                      indicatorColor: effectiveTextColor)
                  : _AppButtonLabel(
                      label,
                      color: effectiveTextColor,
                      prefixIcon: prefixIcon,
                    ),
            ),
      _AppButtonType.text => TextButton(
          style: TextButton.styleFrom(
            padding: padding,
            textStyle: _textStyle,
            foregroundColor: effectiveTextColor,
          ).copyWith(shape: shape),
          onPressed: disableOnPressed ? null : onPressed,
          child: isLoading
              ? AppLoadingIndicator.small(indicatorColor: effectiveTextColor)
              : _AppButtonLabel(label, color: effectiveTextColor),
        ),
      _AppButtonType.danger => TextButton(
          style: TextButton.styleFrom(
            padding: padding,
            textStyle: _textStyle,
            backgroundColor: gradient != null
                ? Colors.transparent
                : (isDisabled
                    ? colors.danger.withOpacity(0.44)
                    : colors.danger),
            foregroundColor: effectiveTextColor,
          ).copyWith(shape: shape),
          onPressed: disableOnPressed ? null : onPressed,
          child: isLoading
              ? AppLoadingIndicator.small(indicatorColor: effectiveTextColor)
              : _AppButtonLabel(label, color: effectiveTextColor),
        ),
      // TODO: Handle this case.
      _AppButtonType.iconText => TextButton(
          style: TextButton.styleFrom(
            padding: padding,
            textStyle: _textStyle,
            foregroundColor: effectiveTextColor,
          ).copyWith(shape: shape),
          onPressed: disableOnPressed ? null : onPressed,
          child: isLoading
              ? AppLoadingIndicator.small(indicatorColor: effectiveTextColor)
              : _AppButtonLabel(
                  label,
                  color: effectiveTextColor,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                ),
        ),
    };

    return SizedBox(
      width: _getButtonWidth(context),
      child: buildButton(button),
    );
  }

  Gradient _createDisabledGradient(Gradient gradient) {
    if (gradient is LinearGradient) {
      return LinearGradient(
        colors: gradient.colors.map((c) => c.withOpacity(0.44)).toList(),
        stops: gradient.stops,
        begin: gradient.begin,
        end: gradient.end,
      );
    } else if (gradient is RadialGradient) {
      return RadialGradient(
        colors: gradient.colors.map((c) => c.withOpacity(0.44)).toList(),
        stops: gradient.stops,
        center: gradient.center,
        radius: gradient.radius,
      );
    }
    return gradient;
  }
}

class _GradientOutlinedButton extends StatelessWidget {
  const _GradientOutlinedButton({
    required this.gradient,
    required this.isDisabled,
    required this.onPressed,
    required this.padding,
    required this.textStyle,
    required this.shape,
    required this.borderRadius,
    required this.child,
    this.width,
  });

  final Gradient gradient;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final WidgetStateProperty<OutlinedBorder?>? shape;
  final double borderRadius;
  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final safeRadius = (borderRadius - 2).clamp(0.0, double.infinity);

    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(safeRadius),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: padding,
            textStyle: textStyle,
            backgroundColor: Colors.transparent,
            foregroundColor: textStyle?.color,
          ).copyWith(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(safeRadius),
              ),
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}

class _AppButtonLabel extends StatelessWidget {
  const _AppButtonLabel(
    this.label, {
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.align,
  });

  final Color? color;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? align;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefixIcon != null) prefixIcon!,
        if (prefixIcon != null) const SizedBox(width: 2),
        Flexible(
          child: MaterialAppText.titleSmall(
            label,
            color: color,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: align ?? TextAlign.center,
          ),
        ),
        if (suffixIcon != null) const SizedBox(width: 2),
        if (suffixIcon != null) suffixIcon!,
      ],
    );
  }
}
