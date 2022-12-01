import 'package:breaking_bad/business_logic/characters_cubit/cubit.dart';
import 'package:breaking_bad/business_logic/characters_cubit/states.dart';
import 'package:breaking_bad/shared/constant/colors.dart';
import 'package:breaking_bad/shared/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../widgets/character_home_screen_item.dart';

class CharactersScreen extends StatelessWidget {
  CharactersScreen({Key? key,this.connected}) : super(key: key);
   bool? connected;

  Widget buildBlocWidget(context) {
    return BlocBuilder<CharactersCubit, CharactersStates>(
        builder: (context, state) {
      if (CharactersCubit.get(context).allCharacters.isNotEmpty) {
        CharactersCubit.get(context).allCharacters =
            CharactersCubit.get(context).allCharacters;
        return successStateWidget(context);
      } else {
        return showCircularProgressIndicator();
      }
    });
  }

  Widget showCircularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColors.yellow,
      ),
    );
  }

  Widget successStateWidget(context) {
    return Container(
      color: AppColors.darkBlue,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemBuilder: (context, index) => CharacterHomeScreenItem(
            character: CharactersCubit.get(context)
                    .searchCharacterController
                    .text
                    .isEmpty
                ? CharactersCubit.get(context).allCharacters[index]
                : CharactersCubit.get(context).searchedCharactersResult[index],
          ),
          itemCount: CharactersCubit.get(context)
                  .searchCharacterController
                  .text
                  .isEmpty
              ? CharactersCubit.get(context).allCharacters.length
              : CharactersCubit.get(context).searchedCharactersResult.length,
        ),
      ),
    );
  }

  Widget buildAppBarTitle() {
    return const Text(
      AppStrings.characters,
    );
  }

  Widget buildSearchField(context) {
    return TextFormField(
      controller: CharactersCubit.get(context).searchCharacterController,
      cursorColor: AppColors.darkBlue,
      cursorHeight: 18,
      decoration: InputDecoration(
        enabled: connected!?true:false,
        border: InputBorder.none,
        hintText: 'search Character...',
        hintStyle:
            TextStyle(fontSize: 14, color: AppColors.darkBlue.withOpacity(0.6)),
      ),
      style: const TextStyle(fontSize: 14, color: AppColors.darkBlue),
      onChanged: (searchedWord) {
        CharactersCubit.get(context)
            .searchCharacterByWord(searchedWord, context);
      },
    );
  }

  List<Widget> buildActionAppBarItem(context) {
    if (CharactersCubit.get(context).isSearchingNow) {
      return [
        IconButton(
            onPressed: () {
              CharactersCubit.get(context).closeSearch();
            },
            icon: const Icon(
              Icons.clear,
              color: AppColors.darkBlue,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              CharactersCubit.get(context).startSearch();
            },
            icon: const Icon(
              Icons.search,
              color: AppColors.darkBlue,
            )),
      ];
    }
  }

  AppBar appBar(cubit, context) {
    return AppBar(
      title:
          cubit.isSearchingNow ? buildSearchField(context) : buildAppBarTitle(),
      leading: cubit.isSearchingNow
          ? IconButton(
              onPressed: () {
                cubit.closeSearch();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.darkBlue,
              ),
            )
          : Container(),
      leadingWidth: cubit.isSearchingNow ? 50 : 1,
      actions: buildActionAppBarItem(context),
    );
  }
  
  Widget noInternetWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150.0,horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(child: Image(image: AssetImage(AppStrings.noInternetImage),fit: BoxFit.cover,)),
          SizedBox(height: 20,),
          Text(AppStrings.youAreOffline,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(AppStrings.offlineHint,style: TextStyle(fontSize: 16,color: AppColors.darkBlue),),
          //SizedBox(height: 80,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, CharactersStates>(
      builder: (BuildContext context, state) {
        var cubit = CharactersCubit.get(context);
        return Scaffold(
          appBar: appBar(cubit, context),
          body: OfflineBuilder(connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            connected = connectivity != ConnectivityResult.none;
            if (connected!) {
              cubit.allCharacters.isEmpty? cubit.getAllCharacters():null;
              return buildBlocWidget(context);
            } else {
             // cubit.getAllCharacters();
              return noInternetWidget();
            }
          },
            child: showCircularProgressIndicator() ,
          ),
        );
      },
    );
  }
}
