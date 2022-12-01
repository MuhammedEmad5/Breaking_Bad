import 'package:breaking_bad/shared/constant/colors.dart';
import 'package:breaking_bad/shared/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/characters_model.dart';

class CharacterHomeScreenItem extends StatelessWidget {
  const CharacterHomeScreenItem({Key? key, required this.character})
      : super(key: key);

  final CharactersModel character;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
            context, AppRoutes.charactersDetailsScreen,
            arguments: character);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.white, width: 4.w),
            color: Colors.white),
        child: Hero(
          tag: character.characterId!,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              character.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image!,
                      imageErrorBuilder: (context, object, stack) {
                        return const Image(
                          image: AssetImage('assets/images/no_image.png'),
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : const SizedBox(),
              Container(
                color: AppColors.darkBlue.withOpacity(0.5),
                width: double.infinity,
                height: 30.h,
                child: Text(
                  character.name!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
