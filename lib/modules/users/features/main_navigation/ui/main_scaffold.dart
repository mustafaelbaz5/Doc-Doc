import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/app_assets.dart';
import 'package:doc_doc/modules/users/features/home/ui/home_screen.dart';
import 'package:doc_doc/modules/users/features/inbox/ui/messages_screen.dart';
import 'package:doc_doc/modules/users/features/profile/ui/profile_screen.dart';
import 'package:doc_doc/modules/users/features/search/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../appointment/ui/appointment_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const AppointmentScreen(),
      const SearchScreen(),
      const MessagesScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(final BuildContext context) {
    final activeColor = context.customColors.accentBlue;

    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.homeIconSvg,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.homeIconSvg,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),

        activeColorPrimary: activeColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.calendarIconSvg,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.calendarIconSvg,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),

        textStyle: AppTextStyles.font12Regular,
        activeColorPrimary: activeColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search, size: 28, color: Colors.white),
        activeColorPrimary: activeColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.messageIconSvg,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.messageIconSvg,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        ),

        activeColorPrimary: activeColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person, color: activeColor, size: 24),
        inactiveIcon: const Icon(Icons.person, color: Colors.grey, size: 24),

        activeColorPrimary: activeColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(final BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarItems(context),
      navBarStyle: NavBarStyle.style16,
      backgroundColor: context.customColors.background,
      navBarHeight: 70, // Reduce height
      padding: const EdgeInsets.only(top: 12, bottom: 4), // Reduce padding
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: context.customColors.border.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      confineToSafeArea: true,
    );
  }
}
