import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preference_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utilities/common.dart';
import 'package:restaurant_app/widgets/lang_select.dart';
import '../utilities/style.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceProvider>(
      builder: (context, daily, _) => Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Container(
          margin: EdgeInsets.only(
            bottom: 2,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.schedule_outlined,
                    color: greyColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      AppLocalizations.of(context)!.schedulingDailyReminder,
                      style: blackText.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  Spacer(),
                  Consumer<SchedulingProvider>(
                    builder: (context, scheduling, _) => Switch.adaptive(
                      activeColor: primaryColor,
                      inactiveThumbColor: greyColor,
                      inactiveTrackColor: greyColor.withOpacity(.5),
                      value: daily.isDailyResturant,
                      onChanged: (value) {
                        scheduling.scheduledRestaurant(value);
                        daily.enableDailyRestaurant(value);
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                height: 10,
              ),
              LanguageSelect(),
              Divider(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
