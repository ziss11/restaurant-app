import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/localizations_provider.dart';
import 'package:restaurant_app/utilities/common.dart';
import 'package:restaurant_app/utilities/localization.dart';
import 'package:restaurant_app/utilities/style.dart';

class LanguageSelect extends StatelessWidget {
  const LanguageSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.language,
          color: greyColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          AppLocalizations.of(context)!.language,
          style: blackText.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const Spacer(),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            items: AppLocalizations.supportedLocales
                .map(
                  (locale) => DropdownMenuItem(
                    value: locale,
                    child: Center(
                      child: Text(
                        Localization.getLangName(locale.languageCode),
                        style: blackText.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                    onTap: () => Provider.of<LocalizationsProvider>(context,
                            listen: false)
                        .setLocale(locale),
                  ),
                )
                .toList(),
            onChanged: (_) {},
          ),
        ),
      ],
    );
  }
}
