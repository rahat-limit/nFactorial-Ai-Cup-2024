import 'package:flutter/material.dart';
import 'package:nfactorial_cup/helpers/app_colors.dart';
import 'package:nfactorial_cup/helpers/app_fonts.dart';
import 'package:nfactorial_cup/pages/main/entity/model/yandex_place_model.dart';
import 'package:nfactorial_cup/pages/plans/presentors/plans_cubit.dart';

class PlaceCard extends StatelessWidget {
  final Feature feature;
  final PlaceType type;
  const PlaceCard({super.key, required this.feature, required this.type});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color secondaryBgColor;
    Color textColor;
    switch (type) {
      case PlaceType.accommodation:
        bg = AppColors.accommodationCardColors;
        secondaryBgColor = AppColors.accommodationCardSecondaryColors;
        textColor = AppColors.accommodationTextColor;
      case PlaceType.breakfast:
        bg = AppColors.breakfastCardColors;
        secondaryBgColor = AppColors.breakfastCardSecondaryColors;
        textColor = AppColors.breakfastTextColor;
      case PlaceType.places:
        bg = AppColors.placesCardColors;
        secondaryBgColor = AppColors.placesSecondaryCardColors;
        textColor = AppColors.placesTextCardColors;
      case PlaceType.placesAfterDinner:
        bg = AppColors.placesCardColors;
        secondaryBgColor = AppColors.placesSecondaryCardColors;
        textColor = AppColors.placesTextCardColors;
      case PlaceType.placesAfterLunch:
        bg = AppColors.placesCardColors;
        secondaryBgColor = AppColors.placesSecondaryCardColors;
        textColor = AppColors.placesTextCardColors;
      case PlaceType.lunch:
        bg = AppColors.lunchCardColors;
        secondaryBgColor = AppColors.lunchSecondaryCardColors;
        textColor = AppColors.lunchTextCardColors;
      case PlaceType.dinner:
        bg = AppColors.dinnerCardColors;
        secondaryBgColor = AppColors.dinnerSecondaryCardColors;
        textColor = AppColors.dinnerTextCardColors;
      default:
        bg = AppColors.accommodationCardColors;
        secondaryBgColor = AppColors.accommodationCardSecondaryColors;
        textColor = AppColors.accommodationTextColor;
    }
    return Container(
        width: MediaQuery.of(context).size.width / 1.4,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.only(top: 20, left: 20),
        height: 180,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(38),
        ),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(feature.properties?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.w800s24
                        .copyWith(color: textColor, fontSize: 28)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(feature.properties?.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.w700s20.copyWith(
                        fontWeight: FontWeight.w500,
                        color: textColor,
                        fontSize: 19)),
              )
            ]),
            Positioned(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryBgColor),
                    onPressed: () {},
                    child: Text('View',
                        style: AppFonts.w600s14.copyWith(color: bg))),
                right: 10,
                bottom: 10)
          ],
        ));
  }
}
