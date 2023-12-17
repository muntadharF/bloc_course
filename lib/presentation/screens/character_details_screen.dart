import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          buildSliverList(),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(character.name, style: AppTextStyles.nickNameTextStyle),
        background: Hero(
          tag: character.id,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }
  
  Widget buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                characterInfo('Episodes: ', character.episode.join(' / ')),
                buildDivider(295),
                characterInfo('Episodes: ', character.episode.join(' / ')),
                buildDivider(295),
                characterInfo('Episodes: ', character.episode.join(' / ')),
                buildDivider(295),
                characterInfo('Episodes: ', character.episode.join(' / ')),
                buildDivider(295),
                characterInfo('Episodes: ', character.episode.join(' / ')),
                buildDivider(295),
                characterInfo('Episodes: ', character.episode.join(' / ')),
                buildDivider(295),
                const SizedBox(height: 400),
              ],
            ),
          ),

        ],
      ),
    );
  }
  
  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(text: title, style: AppTextStyles.titleInfoTextStyle),
          TextSpan(text: value, style: AppTextStyles.valueInfoTextStyle),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: AppColors.yellow,
      height: 32,
      thickness: 2.0,
      endIndent: endIndent,
    );
  }
}
