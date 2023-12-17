import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../data/models/character.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    /* I write this line to call cubit (or bloc) because the cubit is lazy
    and i have to call him when I need him in the UI, why i called him ?
    because i wanna to display list, so this line in initState fetch data
    */
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        leading: _isSearching
            ? const BackButton(color: AppColors.grey)
            : const SizedBox(),
      ),
      body: 
      // buildBlocWidget()
      OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult value,
          Widget child,
        ) {
          final bool connected = value != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicater(),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgt();
        } else {
          return showLoadingIndicater();
        }
      },
    );
  }

  Widget showLoadingIndicater() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.yellow),
    );
  }

  Widget buildLoadedListWidgt() {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.grey,
        child: Column(children: [buildCharactersList()]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      itemBuilder: (context, index) => CharacterItem(
        character: _searchTextController.text.isEmpty
            ? allCharacters[index]
            : searchedForCharacters[index],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: AppColors.grey,
      decoration: const InputDecoration(
        // TODO: move strings to strings
        hintText: 'Find a character ...',
        hintStyle: AppTextStyles.hintFieldTextStyle,
        border: InputBorder.none,
      ),
      style: AppTextStyles.hintFieldTextStyle,
      onChanged: (searchedCharacter) {
        addSearchedForItemsSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters.where((character) {
      return character.name.toLowerCase().contains(searchedCharacter);
    }).toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.grey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSeach,
          icon: const Icon(
            Icons.search,
            color: AppColors.grey,
          ),
        ),
      ];
    }
  }
  
  void _startSeach() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearch),
    );
    
    setState(() => _isSearching = true);
  }

  void _stopSearch() {
    _clearSearch();

    setState(() => _isSearching = false);
  }
  
  void _clearSearch() {
    setState(() => _searchTextController.clear());
  }
  
  Widget _buildAppBarTitle() {
    // TODO: move string to AppStrings
    return const Text('Characters', style: AppTextStyles.appBarTextStyle);
  }
  
  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Can not connect .. check your internet',
              style: AppTextStyles.titleInfoTextStyle,
            ),
            Image.asset(
              'assets/images/offline-illustration.jpg',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
