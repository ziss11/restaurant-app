import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/helper/notifications_helper.dart';
import 'package:restaurant_app/pages/detail_page.dart';
import 'package:restaurant_app/pages/favorite_page.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/pages/setting_page.dart';
import 'package:restaurant_app/provider/page_provider.dart';
import 'package:restaurant_app/utilities/common.dart';
import 'package:restaurant_app/widgets/custom_navbar.dart';

import '../utilities/style.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NotificationsHelper _notificationsHelper = NotificationsHelper();
  void initState() {
    super.initState();
    _notificationsHelper.configureSelectedNotificationSubject(
        DetailPage.routeName, context);
  }

  Widget buildContent(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return FavoritePage();
      case 2:
        return SettingPage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, state, _) => Scaffold(
        floatingActionButton: CustomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 55,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      state.currentIndex == 0
                          ? AppLocalizations.of(context)!.myRestaurant
                          : state.currentIndex == 1
                              ? AppLocalizations.of(context)!.favorite
                              : AppLocalizations.of(context)!.settings,
                      style: blackText.copyWith(
                        fontWeight: semiBold,
                        fontSize: 22,
                      ),
                    ),
                    titlePadding: EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                    ),
                  ),
                ),
              ];
            },
            body: buildContent(state.currentIndex),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }
}
