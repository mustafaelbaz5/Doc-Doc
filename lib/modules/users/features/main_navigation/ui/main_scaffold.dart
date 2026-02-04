import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/utils/app_assets.dart';
import 'package:doc_doc/core/utils/spacing.dart';
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
    final activeColor = AppColors.primary300;

    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.homeIconSvg,
          width: responsiveWidth(24),
          height: responsiveHeight(24),
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.homeIconSvg,
          width: responsiveWidth(24),
          height: responsiveHeight(24),
          colorFilter: ColorFilter.mode(
            context.customColors.textSecondary,
            BlendMode.srcIn,
          ),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.calendarIconSvg,
          width: responsiveWidth(24),
          height: responsiveHeight(24),
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.calendarIconSvg,
          width: responsiveWidth(24),
          height: responsiveHeight(24),
          colorFilter: ColorFilter.mode(
            context.customColors.textSecondary,
            BlendMode.srcIn,
          ),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.search,
          size: responsiveRadius(28),
          color: AppColors.grey0,
        ),
        activeColorPrimary: activeColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          AppAssets.messageIconSvg,
          width: responsiveWidth(24),
          height: responsiveHeight(24),
          colorFilter: ColorFilter.mode(activeColor, BlendMode.srcIn),
        ),
        inactiveIcon: SvgPicture.asset(
          AppAssets.messageIconSvg,
          width: responsiveWidth(24),
          height: responsiveHeight(24),
          colorFilter: ColorFilter.mode(
            context.customColors.textSecondary,
            BlendMode.srcIn,
          ),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person,
          color: activeColor,
          size: responsiveRadius(24),
        ),
        inactiveIcon: Icon(
          Icons.person,
          color: context.customColors.textSecondary,
          size: responsiveRadius(24),
        ),
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
      navBarHeight: responsiveHeight(58),
      padding: const EdgeInsets.only(top: 2, bottom: 8),
      decoration: NavBarDecoration(
        colorBehindNavBar: context.customColors.background,
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
