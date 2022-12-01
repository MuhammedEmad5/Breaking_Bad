import 'package:breaking_bad/data/model/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/constant/colors.dart';

class CharacterInfoItems extends StatelessWidget {
  CharacterInfoItems({Key? key,required this.character,required this.buildQuoteWidget}) : super(key: key);

final CharactersModel character;
Widget buildQuoteWidget;

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
                text: title,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                )),
            TextSpan(
              text: value,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
              ),
            ),
          ],
        ));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: AppColors.yellow,
      height: 30.h,
      thickness: 2.h,
      endIndent: endIndent,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        characterInfo('Jop : ', character.jobs!.join(' / ')),
        buildDivider(280.w),
        characterInfo('Appeared in : ', character.category!),
        buildDivider(220.w),
        characterInfo('Season  : ',
            character.appearanceInSeasons!.join(' / ')),
        buildDivider(260.w),
        characterInfo('Status : ', character.status!),
        buildDivider(265.w),
        character.betterCallSaulAppearance!.isNotEmpty
            ? characterInfo('"Better call saul seasons: ',
            character.betterCallSaulAppearance!.join(' / '))
            : Container(),
        character.betterCallSaulAppearance!.isNotEmpty
            ? buildDivider(135.w)
            : Container(),
        characterInfo('Actor/Actress : ', character.name!),
        buildDivider(210.w),
        SizedBox(
          height: 25.h,
        ),
        buildQuoteWidget,
        SizedBox(
          height: 360.h,
        ),
      ],
    );
  }
}
