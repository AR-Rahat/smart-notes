import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/loading_indicator/app_loading_indicator.dart';

class AppAlerts {
  AppAlerts(this.context);

  final BuildContext context;

  void snackBar({
    required String massage,
    int duration = 3,
    bool isSuccess = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.only(
          bottom: 64,
        ),
        content: Text(
          massage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: duration,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            isSuccess ? context.colors.primaryVariant : context.colors.danger,
      ),
    );
  }

  /// Show a Custom Dialog with Circular Progress Indicator and Title
  void showLoadingDialog({String title = ''}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(color: Colors.white.withValues(alpha: 0.1)),
            ),
            Center(
              child: Dialog(
                backgroundColor: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLoadingIndicator(),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: Theme.of(context).primaryTextTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Show a custom popUpBanner
  void showPopupBanner({
    required Widget child,
    bool isBlur = true,
    double top = -12,
    double right = -12,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return Stack(
          children: [
            BackdropFilter(
              filter: isBlur
                  ? ImageFilter.blur(sigmaX: 28, sigmaY: 28)
                  : ImageFilter.blur(),
              child: Container(color: Colors.white.withValues(alpha: 0.1)),
            ),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: child,
                  ),
                  Positioned(
                    top: top,
                    right: right,
                    child: ClipOval(
                      child: ColoredBox(
                        color: Colors.white,
                        child: CloseButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Show a custom popUpBanner
  void showPopupDialog({
    required Widget child,
    bool isBlur = true,
    bool isDismissible = true,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return PopScope(
          canPop: isDismissible,
          child: Stack(
            children: [
              BackdropFilter(
                filter: isBlur
                    ? ImageFilter.blur(sigmaX: 28, sigmaY: 28)
                    : ImageFilter.blur(),
                child: Container(color: Colors.white.withValues(alpha: 0.1)),
              ),
              if (isDismissible)
                GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                  ),
                ),
              Center(
                child: SizedBox(
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void openBottomSheet({
    required Widget child,
    bool hasBlur = true,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.colors.background,
      barrierColor: const Color(0x1A1925A6),
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: PopScope(
          canPop: isDismissible,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: hasBlur ? 14 : 0,
              sigmaY: hasBlur ? 14 : 0,
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: context.customWidth(30),
                    width: MediaQuery.sizeOf(context).width,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colors.foregroundOnPrimary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(context.w20),
                          topRight: Radius.circular(context.w20),
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          height: context.customWidth(5),
                          width: context.customWidth(32),
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.colors.splashColor,
                              borderRadius: BorderRadius.circular(
                                context.w20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ColoredBox(
                      color: context.colors.background,
                      child: child,
                    ),
                  ),
                  SizedBox(
                    height: context.w24,
                    width: double.infinity,
                    child: Container(
                      color: context.colors.background,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Dismiss the loading dialog
  void dismissDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
//
// /// Pop up dialogue
// void showDialogue({
//   String? title,
//   required String description,
//   String positiveTitle = "Yes",
//   String negativeTitle = "No",
//   bool hasBlur = true,
//   AlertType type = AlertType.warning,
//   double borderRadius = 16.0,
//   Function()? onTapPositive,
//   Function()? onTapNegative,
//   Function()? onTapClose,
//   bool hideNegative = false,
//   bool swapColor = false,
//   bool isCallNow = false,
//   bool hideTitle = false,
//   bool hideIcon = false,
//   Widget? child,
//   bool hideCloseButton = false,
// }) {
//   if (!context.mounted) return;
//
//   // Cache the MediaQuery size before showing dialog
//   final size = MediaQuery.of(context).size;
//   final horizontalPadding = size.width * 0.05;
//   final topPadding = size.height * 0.1;
//
//   showDialog(
//     context: context,
//     builder: (BuildContext dialogContext) {
//       return GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         child: BackdropFilter(
//           filter: ImageFilter.blur(
//             sigmaX: hasBlur ? 5 : 0,
//             sigmaY: hasBlur ? 5 : 0,
//           ),
//           child: Center(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: horizontalPadding,
//                 right: horizontalPadding,
//                 top: topPadding,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(dialogContext).cardColor,
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//                 padding: const EdgeInsets.all(12.0),
//                 child: Stack(
//                   alignment: AlignmentDirectional.topEnd,
//                   children: [
//                     child ??
//                         Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Visibility(
//                                       visible: !hideIcon,
//                                       child: AlertIcon(type: type)),
//                                   Visibility(
//                                       visible: !hideIcon,
//                                       child: const SizedBox(width: 16)),
//                                   Flexible(
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Visibility(
//                                           visible: !hideTitle,
//                                           child: Text(
//                                             title ??
//                                                 switch (type) {
//                                                   AlertType.warning =>
//                                                     "WARNING",
//                                                   AlertType.error => "ERROR",
//                                                   AlertType.success =>
//                                                     "SUCCESS",
//                                                 },
//                                             style: Theme.of(dialogContext)
//                                                 .textTheme
//                                                 .titleMedium,
//                                           ),
//                                         ),
//                                         Visibility(
//                                             visible: !hideTitle,
//                                             child: const SizedBox(height: 8)),
//                                         Text(
//                                           description,
//                                           style: Theme.of(dialogContext)
//                                               .textTheme
//                                               .bodyMedium,
//                                           softWrap: true,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   PopUpButton(
//                                     onTap: onTapPositive ??
//                                         () {
//                                           Navigator.of(dialogContext).pop();
//                                         },
//                                     title: positiveTitle,
//                                     backgroundColor: swapColor
//                                         ? null
//                                         : Theme.of(dialogContext)
//                                             .primaryColor,
//                                   ),
//                                   const SizedBox(width: 12),
//                                   Visibility(
//                                     visible: !hideNegative,
//                                     child: PopUpButton(
//                                       onTap: onTapNegative ??
//                                           () {
//                                             Navigator.of(dialogContext).pop();
//                                           },
//                                       title: negativeTitle,
//                                       backgroundColor: swapColor
//                                           ? Theme.of(dialogContext)
//                                               .primaryColor
//                                           : null,
//                                       isCallNow: isCallNow,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                     Visibility(
//                       visible: hideCloseButton == false,
//                       child: GestureDetector(
//                         onTap: onTapClose ??
//                             () {
//                               if (hideCloseButton == false) {
//                                 Navigator.of(dialogContext).pop();
//                               }
//                             },
//                         child: Icon(
//                           Icons.close,
//                           color:
//                               Theme.of(dialogContext).colorScheme.onSurface,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
}

extension AppAlertsExtension on BuildContext {
  AppAlerts get alerts => AppAlerts(this);
}
