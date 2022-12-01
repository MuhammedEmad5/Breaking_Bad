import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/business_logic/characters_cubit/cubit.dart';
import 'package:breaking_bad/business_logic/characters_cubit/states.dart';
import 'package:breaking_bad/data/model/characters_model.dart';
import 'package:breaking_bad/shared/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/character_info_items.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final CharactersModel character;

  const CharactersDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildAppBar() {
    return SliverAppBar(
      expandedHeight: 470.h,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.darkBlue,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname!,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        background: Hero(
          tag: character.characterId!,
          child: Image(
            image: NetworkImage(
              character.image!,
            ),
            fit: BoxFit.cover,
            errorBuilder: (context, object, stack) {
              return const Image(
                image: AssetImage('assets/images/no_image.png'),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildQuoteWidget() {
    return BlocBuilder<CharactersCubit, CharactersStates>(
      builder: (BuildContext context, state) {
        var cubit = CharactersCubit.get(context);
        return cubit.quotes.isNotEmpty
            ? buildQuoteAnimatedText(
                cubit.quotes[randomIndex(0, cubit.quotes.length)].quote!)
            : Container();
      },
    );
  }

  int randomIndex(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  Widget buildQuoteAnimatedText(String characterQuote) {
    return Center(
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          FlickerAnimatedText(
            characterQuote,
            textStyle: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: AppColors.yellow, blurRadius: 5.r)]),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: CustomScrollView(
        slivers: [
          buildAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                    margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                    padding: EdgeInsets.all(8.w),
                    child: CharacterInfoItems(
                      character: character,
                      buildQuoteWidget: buildQuoteWidget(),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
