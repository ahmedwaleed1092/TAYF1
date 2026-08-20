import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/routing/routs.dart';

/// Shared bottom navigation bar item model
class AppBottomNavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String routeName;

  const AppBottomNavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.routeName,
  });

  static const List<AppBottomNavItem> defaultItems = [
    AppBottomNavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      routeName: Routs.home,
    ),
    AppBottomNavItem(
      label: 'Menu',
      icon: Icons.restaurant_menu_outlined,
      activeIcon: Icons.restaurant_menu,
      routeName: Routs.menu,
    ),
    AppBottomNavItem(
      label: 'Favorites',
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
      routeName: Routs.favorites,
    ),
    AppBottomNavItem(
      label: 'Orders',
      icon: Icons.assignment_outlined,
      activeIcon: Icons.assignment,
      routeName: Routs.orders,
    ),
    AppBottomNavItem(
      label: 'Support',
      icon: Icons.headset_mic_outlined,
      activeIcon: Icons.headset_mic,
      routeName: Routs.support,
    ),
  ];
}

/// Theme for the shared bottom navigation bar
@immutable
class AppBottomNavTheme extends ThemeExtension<AppBottomNavTheme> {
  final Gradient backgroundGradient;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color activeLabelColor;
  final Color inactiveLabelColor;
  final double height;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final double activeIconSize;
  final double inactiveIconSize;
  final double labelFontSize;
  final FontWeight activeLabelFontWeight;
  final FontWeight inactiveLabelFontWeight;
  final List<BoxShadow> backgroundShadows;
  final Duration animationDuration;
  final Curve animationCurve;
  final double dotSpacing;
  final double dotSize;
  final double activeDotWidth;

  const AppBottomNavTheme({
    required this.backgroundGradient,
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.activeLabelColor,
    required this.inactiveLabelColor,
    required this.height,
    required this.borderRadius,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.activeIconSize,
    required this.inactiveIconSize,
    required this.labelFontSize,
    required this.activeLabelFontWeight,
    required this.inactiveLabelFontWeight,
    required this.backgroundShadows,
    required this.animationDuration,
    required this.animationCurve,
    required this.dotSpacing,
    required this.dotSize,
    required this.activeDotWidth,
  });

  /// Light theme variant
  factory AppBottomNavTheme.light() {
    return AppBottomNavTheme(
      backgroundGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFFFFF), Color(0xFFFEFEFE)],
      ),
      activeIconColor: const Color(0xFFFF6B35),
      inactiveIconColor: const Color(0xFF9E9E9E),
      activeLabelColor: const Color(0xFFFF6B35),
      inactiveLabelColor: const Color(0xFF9E9E9E),
      height: 72.0,
      borderRadius: 24.0,
      horizontalPadding: 16.0,
      verticalPadding: 16.0,
      activeIconSize: 26.0,
      inactiveIconSize: 24.0,
      labelFontSize: 11.0,
      activeLabelFontWeight: FontWeight.w700,
      inactiveLabelFontWeight: FontWeight.w500,
      backgroundShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, -4),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, -2),
        ),
      ],
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOutCubic,
      dotSpacing: 8.0,
      dotSize: 6.0,
      activeDotWidth: 20.0,
    );
  }

  /// Dark theme variant
  factory AppBottomNavTheme.dark() {
    return AppBottomNavTheme(
      backgroundGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2C2C2C), Color(0xFF1E1E1E)],
      ),
      activeIconColor: const Color(0xFFFF8A50),
      inactiveIconColor: const Color(0xFF757575),
      activeLabelColor: const Color(0xFFFF8A50),
      inactiveLabelColor: const Color(0xFF757575),
      height: 72.0,
      borderRadius: 24.0,
      horizontalPadding: 16.0,
      verticalPadding: 16.0,
      activeIconSize: 26.0,
      inactiveIconSize: 24.0,
      labelFontSize: 11.0,
      activeLabelFontWeight: FontWeight.w700,
      inactiveLabelFontWeight: FontWeight.w500,
      backgroundShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, -4),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 8,
          offset: const Offset(0, -2),
        ),
      ],
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOutCubic,
      dotSpacing: 8.0,
      dotSize: 6.0,
      activeDotWidth: 20.0,
    );
  }

  @override
  AppBottomNavTheme copyWith({
    Gradient? backgroundGradient,
    Color? activeIconColor,
    Color? inactiveIconColor,
    Color? activeLabelColor,
    Color? inactiveLabelColor,
    double? height,
    double? borderRadius,
    double? horizontalPadding,
    double? verticalPadding,
    double? activeIconSize,
    double? inactiveIconSize,
    double? labelFontSize,
    FontWeight? activeLabelFontWeight,
    FontWeight? inactiveLabelFontWeight,
    List<BoxShadow>? backgroundShadows,
    Duration? animationDuration,
    Curve? animationCurve,
    double? dotSpacing,
    double? dotSize,
    double? activeDotWidth,
  }) {
    return AppBottomNavTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      activeIconColor: activeIconColor ?? this.activeIconColor,
      inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
      activeLabelColor: activeLabelColor ?? this.activeLabelColor,
      inactiveLabelColor: inactiveLabelColor ?? this.inactiveLabelColor,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      verticalPadding: verticalPadding ?? this.verticalPadding,
      activeIconSize: activeIconSize ?? this.activeIconSize,
      inactiveIconSize: inactiveIconSize ?? this.inactiveIconSize,
      labelFontSize: labelFontSize ?? this.labelFontSize,
      activeLabelFontWeight:
          activeLabelFontWeight ?? this.activeLabelFontWeight,
      inactiveLabelFontWeight:
          inactiveLabelFontWeight ?? this.inactiveLabelFontWeight,
      backgroundShadows: backgroundShadows ?? this.backgroundShadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      dotSpacing: dotSpacing ?? this.dotSpacing,
      dotSize: dotSize ?? this.dotSize,
      activeDotWidth: activeDotWidth ?? this.activeDotWidth,
    );
  }

  @override
  AppBottomNavTheme lerp(ThemeExtension<AppBottomNavTheme>? other, double t) {
    if (other is! AppBottomNavTheme) return this;
    return AppBottomNavTheme(
      backgroundGradient: Gradient.lerp(
        backgroundGradient,
        other.backgroundGradient,
        t,
      )!,
      activeIconColor: Color.lerp(activeIconColor, other.activeIconColor, t)!,
      inactiveIconColor: Color.lerp(
        inactiveIconColor,
        other.inactiveIconColor,
        t,
      )!,
      activeLabelColor: Color.lerp(
        activeLabelColor,
        other.activeLabelColor,
        t,
      )!,
      inactiveLabelColor: Color.lerp(
        inactiveLabelColor,
        other.inactiveLabelColor,
        t,
      )!,
      height: lerpDouble(height, other.height, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      horizontalPadding: lerpDouble(
        horizontalPadding,
        other.horizontalPadding,
        t,
      )!,
      verticalPadding: lerpDouble(verticalPadding, other.verticalPadding, t)!,
      activeIconSize: lerpDouble(activeIconSize, other.activeIconSize, t)!,
      inactiveIconSize: lerpDouble(
        inactiveIconSize,
        other.inactiveIconSize,
        t,
      )!,
      labelFontSize: lerpDouble(labelFontSize, other.labelFontSize, t)!,
      activeLabelFontWeight: t < 0.5
          ? activeLabelFontWeight
          : other.activeLabelFontWeight,
      inactiveLabelFontWeight: t < 0.5
          ? inactiveLabelFontWeight
          : other.inactiveLabelFontWeight,
      backgroundShadows: _lerpBoxShadowList(
        backgroundShadows,
        other.backgroundShadows,
        t,
      ),
      animationDuration: _lerpDuration(
        animationDuration,
        other.animationDuration,
        t,
      ),
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
      dotSpacing: lerpDouble(dotSpacing, other.dotSpacing, t)!,
      dotSize: lerpDouble(dotSize, other.dotSize, t)!,
      activeDotWidth: lerpDouble(activeDotWidth, other.activeDotWidth, t)!,
    );
  }

  List<BoxShadow> _lerpBoxShadowList(
    List<BoxShadow>? a,
    List<BoxShadow>? b,
    double t,
  ) {
    if (a == null || b == null) return a ?? b ?? [];
    if (a.length != b.length) return a;
    return List.generate(a.length, (i) => BoxShadow.lerp(a[i], b[i], t)!);
  }

  Duration _lerpDuration(Duration a, Duration b, double t) {
    return Duration(
      microseconds: lerpDouble(a.inMicroseconds, b.inMicroseconds, t)!.round(),
    );
  }

  /// Helper to get the extension from a ThemeData
  static AppBottomNavTheme of(BuildContext context) {
    return Theme.of(context).extension<AppBottomNavTheme>() ??
        AppBottomNavTheme.light();
  }
}

/// Background container widget for the bottom navigation bar
class AppBottomNavBackground extends StatelessWidget {
  final Widget child;
  final AppBottomNavTheme theme;

  const AppBottomNavBackground({
    super.key,
    required this.child,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: theme.horizontalPadding.w,
          vertical: theme.verticalPadding.h,
        ),
        height: theme.height.h,
        decoration: BoxDecoration(
          gradient: theme.backgroundGradient,
          borderRadius: BorderRadius.circular(theme.borderRadius.r),
          boxShadow: theme.backgroundShadows,
        ),
        child: child,
      ),
    );
  }
}

/// Individual navigation item widget
class AppBottomNavItemWidget extends StatelessWidget {
  final AppBottomNavItem item;
  final bool isActive;
  final AppBottomNavTheme theme;
  final VoidCallback onTap;
  final bool showLabel;

  const AppBottomNavItemWidget({
    super.key,
    required this.item,
    required this.isActive,
    required this.theme,
    required this.onTap,
    required this.showLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: theme.animationDuration,
          curve: theme.animationCurve,
          padding: EdgeInsets.symmetric(
            horizontal: isActive ? 16.w : 12.w,
            vertical: 8.h,
          ),
          decoration: _buildItemDecoration(),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBottomNavIcon(item: item, isActive: isActive, theme: theme),
                if (showLabel && isActive) ...[
                  SizedBox(width: 6.w),
                  AppBottomNavLabel(label: item.label, theme: theme),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildItemDecoration() {
    return BoxDecoration(
      color: isActive
          ? theme.activeIconColor.withValues(alpha: 0.15)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(theme.borderRadius.r),
    );
  }
}

/// Animated icon widget for navigation items
class AppBottomNavIcon extends StatelessWidget {
  final AppBottomNavItem item;
  final bool isActive;
  final AppBottomNavTheme theme;

  const AppBottomNavIcon({
    super.key,
    required this.item,
    required this.isActive,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: theme.animationDuration,
      switchInCurve: theme.animationCurve,
      switchOutCurve: theme.animationCurve,
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Icon(
        key: ValueKey(isActive),
        isActive ? item.activeIcon : item.icon,
        color: isActive ? theme.activeIconColor : theme.inactiveIconColor,
        size: (isActive ? theme.activeIconSize : theme.inactiveIconSize).sp,
      ),
    );
  }
}

/// Label widget for active navigation items
class AppBottomNavLabel extends StatelessWidget {
  final String label;
  final AppBottomNavTheme theme;

  const AppBottomNavLabel({
    super.key,
    required this.label,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: theme.activeLabelColor,
          fontSize: theme.labelFontSize.sp,
          fontWeight: theme.activeLabelFontWeight,
        ),
      ),
    );
  }
}

/// Active indicator widget (dot/pill) for navigation items
class AppBottomNavIndicator extends StatelessWidget {
  final bool isActive;
  final AppBottomNavTheme theme;

  const AppBottomNavIndicator({
    super.key,
    required this.isActive,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (!isActive) return const SizedBox.shrink();

    return AnimatedContainer(
      duration: theme.animationDuration,
      curve: theme.animationCurve,
      width: theme.activeDotWidth.w,
      height: theme.dotSize.h,
      margin: EdgeInsets.only(top: theme.dotSpacing.h),
      decoration: BoxDecoration(
        color: theme.activeIconColor,
        borderRadius: BorderRadius.circular(theme.dotSize.r / 2),
      ),
    );
  }
}

/// Main bottom navigation bar widget
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<AppBottomNavItem> items;
  final bool showLabels;

  const AppBottomNavBar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
    this.items = AppBottomNavItem.defaultItems,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppBottomNavTheme.of(context);

    return AppBottomNavBackground(
      theme: theme,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = index == currentIndex;
          return AppBottomNavItemWidget(
            item: item,
            isActive: isActive,
            theme: theme,
            showLabel: showLabels,
            onTap: () => onTap?.call(index),
          );
        }),
      ),
    );
  }
}
