import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/app_translations/app_languages.dart';
import 'package:movies_app/common/app_translations/app_translator.dart';
import 'package:movies_app/depen_injec/get_it.dart';
import 'package:responsive_size/responsive_size.dart';

import 'package:movies_app/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:movies_app/presentation/journeys/drawer/drawer_tile_widget.dart';
import 'package:movies_app/presentation/journeys/drawer/drawer_tile_expansion_widget.dart';
import 'package:movies_app/presentation/widgets/logo.dart';
import 'package:movies_app/common/constants/size_constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.s300.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.s8.h,
                bottom: Sizes.s18.h,
                left: Sizes.s8.w,
                right: Sizes.s8.w,
              ),
              child: AppLogo(height: Sizes.s20.h),
            ),
            DrawerTileWidget(
              title: getIt.get<AppTranslator>(param1: context).favoriteMovies,
              onPressed: () {},
            ),
            BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return DrawerTileExpansionWidget(
                  initialSelectedIndex: getIt<AppLanguages>()
                      .indexByCode(state.locale.languageCode),
                  title: getIt.get<AppTranslator>(param1: context).languages,
                  nestedTiles: getIt<AppLanguages>().languages.map((lang) {
                    return DrawerNestedTile(
                      title: lang.name,
                      onPressed: () => _changeLanguage(context, lang.code),
                    );
                  }).toList(),
                );
              },
            ),
            DrawerTileWidget(
              title: getIt.get<AppTranslator>(param1: context).feedback,
              onPressed: () {},
            ),
            DrawerTileWidget(
              title: getIt.get<AppTranslator>(param1: context).about,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    BlocProvider.of<LanguageBloc>(context)
        .add(LanguageChangeEvent(languageCode));
  }
}
