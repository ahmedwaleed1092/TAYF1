/// Zoom/Stacked Profile Drawer Menu
///
/// A zoom/stacked side menu that opens from the profile icon with 3 stacked layers:
/// 1. Background layer: Light yellow/orange
/// 2. Middle layer: Light pink/peach
/// 3. Top layer: Deep orange menu card with profile info, menu items, logout, and floating home button

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Main entry point widget that wraps the app content with the zoom drawer menu
class ProfileDrawerMenu extends StatefulWidget {
  /// The main content widget (typically your Scaffold or CustomScrollView)
  final Widget child;

  /// The widget to use as the profile avatar trigger (typically in AppBar)
  final Widget? profileTrigger;

  /// Whether to show the floating profile trigger overlay at top-right
  /// Defaults to true. Set to false if you have your own profile icon in the header.
  final bool showFloatingTrigger;

  /// Callback when the menu opens/closes
  final ValueChanged<bool>? onMenuStateChanged;

  /// Profile information to display
  final ProfileInfo profileInfo;

  /// Menu items to display
  final List<ProfileMenuItem> menuItems;

  /// Logout item (displayed at bottom)
  final ProfileMenuItem? logoutItem;

  /// Duration of the open/close animation
  final Duration animationDuration;

  /// Animation curve
  final Curve animationCurve;

  /// Background layer color (bottom layer)
  final Color backgroundLayerColor;

  /// Middle layer color
  final Color middleLayerColor;

  /// Menu card color (top layer)
  final Color menuCardColor;

  /// Text color for menu items
  final Color textColor;

  /// Icon color for menu items
  final Color iconColor;

  /// Divider color
  final Color dividerColor;

  /// Floating home button background color
  final Color fabBackgroundColor;

  /// Floating home button icon color
  final Color fabIconColor;

  const ProfileDrawerMenu({
    super.key,
    required this.child,
    this.profileTrigger,
    this.showFloatingTrigger = true,
    required this.profileInfo,
    this.menuItems = const [],
    this.logoutItem,
    this.onMenuStateChanged,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.easeInOutCubic,
    this.backgroundLayerColor = const Color(0xFFFFA726), // Light yellow/orange
    this.middleLayerColor = const Color(0xFFFFCDB2), // Light pink/peach
    this.menuCardColor = const Color(0xFFF4511E), // Deep orange
    this.textColor = Colors.white,
    this.iconColor = const Color(0xFFFF9800), // Orange for icons on white circles
    this.dividerColor = Colors.white24,
    this.fabBackgroundColor = const Color(0xFFE64A19), // Darker orange
    this.fabIconColor = Colors.white,
  });

  @override
  State<ProfileDrawerMenu> createState() => _ProfileDrawerMenuState();
}

class _ProfileDrawerMenuState extends State<ProfileDrawerMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _middleLayerScaleAnimation;
  late Animation<double> _backgroundLayerScaleAnimation;

  bool _isMenuOpen = false;

  /// Public method to toggle menu from outside (e.g., from HomeHeader profile icon)
  void toggleMenu() {
    _toggleMenu();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      widget.onMenuStateChanged?.call(_isMenuOpen);
    });
  }

  void _closeMenu() {
    if (_isMenuOpen) {
      _toggleMenu();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _middleLayerScaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _backgroundLayerScaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double slideX = _slideAnimation.value * (MediaQuery.of(context).size.width * 0.75);
        final double scale = _scaleAnimation.value;
        final double rotation = _rotationAnimation.value;
        final double middleLayerScale = _middleLayerScaleAnimation.value;
        final double backgroundLayerScale = _backgroundLayerScaleAnimation.value;

        return Stack(
          children: [
            // Layer 1: Background layer (yellow/orange) - scales down slightly
            Transform.scale(
              scale: backgroundLayerScale,
              origin: Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2),
              child: Container(
                color: widget.backgroundLayerColor,
              ),
            ),

            // Layer 2: Middle layer (pink/peach) - scales down more
            Transform.scale(
              scale: middleLayerScale,
              origin: Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2),
              child: Container(
                color: widget.middleLayerColor,
              ),
            ),

            // Layer 3: Main content (the app content) - slides right, scales down, rotates slightly
            Transform.translate(
              offset: Offset(slideX, 0),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..scale(scale)
                  ..rotateZ(rotation),
                child: AbsorbPointer(
                  absorbing: _isMenuOpen,
                  child: widget.child,
                ),
              ),
            ),

            // Layer 4: Menu Card (orange) - slides from left with the content
            if (_animationController.value > 0)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final double menuSlideX = _animationController.value * (MediaQuery.of(context).size.width * 0.75);
                    return Transform.translate(
                      offset: Offset(menuSlideX - (MediaQuery.of(context).size.width * 0.75), 0),
                      child: _buildMenuCard(context),
                    );
                  },
                ),
              ),

            // Profile trigger overlay (on top of everything when closed, or integrated in header)
            if (!_isMenuOpen && widget.showFloatingTrigger && widget.profileTrigger != null)
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h, right: 16.w),
                        child: widget.profileTrigger!,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final menuWidth = screenWidth * 0.75;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: menuWidth,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: widget.menuCardColor,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(10, 0),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(-5, 0),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button area (tap outside to close)
              GestureDetector(
                onTap: _closeMenu,
                child: Container(
                  height: 40.h,
                  color: Colors.transparent,
                ),
              ),

              // Profile Section
              _buildProfileSection(),

              SizedBox(height: 24.h),

              // Menu Items
              _buildMenuItems(),

              const Spacer(),

              // Logout Item
              if (widget.logoutItem != null) _buildLogoutItem(),

              // Floating Home Button (FAB on bottom edge)
              _buildFloatingHomeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + Name + Email
          Row(
            children: [
              // Circular Avatar
              CircleAvatar(
                radius: 36.r,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                backgroundImage: widget.profileInfo.avatarUrl != null
                    ? NetworkImage(widget.profileInfo.avatarUrl!)
                    : null,
                child: widget.profileInfo.avatarUrl == null
                    ? Icon(
                        Icons.person,
                        size: 36.sp,
                        color: widget.textColor,
                      )
                    : null,
              ),
              SizedBox(width: 16.w),
              // Name and Email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.profileInfo.name,
                      style: GoogleFonts.poppins(
                        color: widget.textColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.profileInfo.email,
                      style: GoogleFonts.poppins(
                        color: widget.textColor.withValues(alpha: 0.7),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    final items = widget.menuItems.isNotEmpty
        ? widget.menuItems
        : ProfileMenuItem.defaultItems;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;

          return _buildMenuItem(item, showDivider: !isLast);
        }),
      ),
    );
  }

  Widget _buildMenuItem(ProfileMenuItem item, {required bool showDivider}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _closeMenu();
            item.onTap?.call();
          },
          child: Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                // Icon in white circle
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      item.icon,
                      color: widget.iconColor,
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Label
                Expanded(
                  child: Text(
                    item.label,
                    style: GoogleFonts.poppins(
                      color: widget.textColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Divider
        if (showDivider)
          Container(
            height: 1.h,
            margin: EdgeInsets.only(left: 48.w),
            color: widget.dividerColor,
          ),
      ],
    );
  }

  Widget _buildLogoutItem() {
    final item = widget.logoutItem!;
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          Container(
            height: 1.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            color: widget.dividerColor,
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              _closeMenu();
              item.onTap?.call();
            },
            child: Container(
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: widget.textColor,
                    size: 22.sp,
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    item.label,
                    style: GoogleFonts.poppins(
                      color: widget.textColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingHomeButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 32.h),
        child: GestureDetector(
          onTap: () {
            _closeMenu();
            // Navigate to home - this can be customized via callback
          },
          child: Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: widget.fabBackgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.fabBackgroundColor.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.home_rounded,
                color: widget.fabIconColor,
                size: 28.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Profile information model
class ProfileInfo {
  final String name;
  final String email;
  final String? avatarUrl;

  const ProfileInfo({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  /// Default profile info for demo
  static const ProfileInfo demo = ProfileInfo(
    name: 'John Smith',
    email: 'john.smith@email.com',
    avatarUrl: null,
  );
}

/// Menu item model for the profile drawer
class ProfileMenuItem {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    required this.label,
    required this.icon,
    this.onTap,
  });

  /// Default menu items as specified in requirements
  static const List<ProfileMenuItem> defaultItems = [
    ProfileMenuItem(
      label: 'My Orders',
      icon: Icons.shopping_bag_outlined,
    ),
    ProfileMenuItem(
      label: 'My Profile',
      icon: Icons.person_outline,
    ),
    ProfileMenuItem(
      label: 'Delivery Address',
      icon: Icons.location_on_outlined,
    ),
    ProfileMenuItem(
      label: 'Payment Methods',
      icon: Icons.credit_card_outlined,
    ),
    ProfileMenuItem(
      label: 'Contact Us',
      icon: Icons.phone_outlined,
    ),
    ProfileMenuItem(
      label: 'Help & FAQs',
      icon: Icons.chat_bubble_outline,
    ),
    ProfileMenuItem(
      label: 'Settings',
      icon: Icons.settings_outlined,
    ),
  ];

  /// Default logout item
  static const ProfileMenuItem defaultLogout = ProfileMenuItem(
    label: 'Log Out',
    icon: Icons.logout,
  );
}

/// Convenience wrapper to easily integrate with existing HomeHeader
class ProfileDrawerMenuWrapper extends StatefulWidget {
  final Widget child;
  final ProfileInfo profileInfo;
  final List<ProfileMenuItem> menuItems;
  final ProfileMenuItem? logoutItem;

  /// Called when the menu opens/closes
  final ValueChanged<bool>? onMenuStateChanged;

  /// Optional callback that can be passed to HomeHeader's onProfileTap
  /// Use this to connect the profile icon in HomeHeader to the drawer menu
  final VoidCallback? onProfileTap;

  /// Whether to show the floating profile trigger overlay at top-right
  /// Defaults to true. Set to false if you have your own profile icon in the header.
  final bool showFloatingTrigger;

  final Duration animationDuration;
  final Curve animationCurve;
  final Color backgroundLayerColor;
  final Color middleLayerColor;
  final Color menuCardColor;
  final Color textColor;
  final Color iconColor;
  final Color dividerColor;
  final Color fabBackgroundColor;
  final Color fabIconColor;

  const ProfileDrawerMenuWrapper({
    super.key,
    required this.child,
    required this.profileInfo,
    this.menuItems = const [],
    this.logoutItem,
    this.onMenuStateChanged,
    this.onProfileTap,
    this.showFloatingTrigger = true,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.easeInOutCubic,
    this.backgroundLayerColor = const Color(0xFFFFA726),
    this.middleLayerColor = const Color(0xFFFFCDB2),
    this.menuCardColor = const Color(0xFFF4511E),
    this.textColor = Colors.white,
    this.iconColor = const Color(0xFFFF9800),
    this.dividerColor = Colors.white24,
    this.fabBackgroundColor = const Color(0xFFE64A19),
    this.fabIconColor = Colors.white,
  });

  @override
  State<ProfileDrawerMenuWrapper> createState() => _ProfileDrawerMenuWrapperState();
}

class _ProfileDrawerMenuWrapperState extends State<ProfileDrawerMenuWrapper> {
  final GlobalKey<_ProfileDrawerMenuState> _menuKey = GlobalKey();

  late final VoidCallback _onProfileTap;

  @override
  void initState() {
    super.initState();
    // Combine the internal toggle with any external callback
    _onProfileTap = () {
      _toggleMenu();
      widget.onProfileTap?.call();
    };
  }

  // Custom profile trigger that communicates with the menu
  Widget _buildProfileTrigger() {
    return _ProfileTrigger(
      onTap: _onProfileTap,
    );
  }

  void _toggleMenu() {
    _menuKey.currentState?.toggleMenu();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileDrawerMenu(
      key: _menuKey,
      child: widget.child,
      profileTrigger: _buildProfileTrigger(),
      profileInfo: widget.profileInfo,
      menuItems: widget.menuItems,
      logoutItem: widget.logoutItem ?? ProfileMenuItem.defaultLogout,
      onMenuStateChanged: widget.onMenuStateChanged,
      showFloatingTrigger: widget.showFloatingTrigger,
      animationDuration: widget.animationDuration,
      animationCurve: widget.animationCurve,
      backgroundLayerColor: widget.backgroundLayerColor,
      middleLayerColor: widget.middleLayerColor,
      menuCardColor: widget.menuCardColor,
      textColor: widget.textColor,
      iconColor: widget.iconColor,
      dividerColor: widget.dividerColor,
      fabBackgroundColor: widget.fabBackgroundColor,
      fabIconColor: widget.fabIconColor,
    );
  }
}

/// Internal profile trigger widget that integrates with the menu
class _ProfileTrigger extends StatelessWidget {
  final VoidCallback onTap;

  const _ProfileTrigger({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xCCFFFFFF),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.person_outline,
            color: const Color(0xFFFF9800),
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}