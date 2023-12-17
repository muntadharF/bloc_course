import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../routes/app_pages.dart';
import 'package:flutter/material.dart';

import '../../data/models/character.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(4),
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          AppPages.characterDetailsScreen,
          arguments: character,
        ),
        child: GridTile(
          footer: Hero(
            tag: character.id,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: double.infinity,
              color: AppColors.black54,
              child: Text(
                character.name,
                style: AppTextStyles.characterNameTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: AppColors.grey,
            child: character.image.isNotEmpty
                // fade in image it works: if image not upload: show "placeholder image" and when image is upload show "image"
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading-dots.gif',
                    image: character.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/Image_not_available.png'),
          ),
        ),
      ),
    );
  }
}
