import 'package:flutter/material.dart';

import '../../data/model/character_model.dart';

class CharactersItem extends StatelessWidget {
  final CharacterModel characterModel;
  const CharactersItem({super.key, required this.characterModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed('./characterDetailsScreen', arguments: characterModel);
        },
        child: GridTile(
          // ignore: sort_child_properties_last
          child: Hero(
            tag: characterModel.id,
            child: Container(
                color: Colors.grey,
                child: characterModel.image.isNotEmpty
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/images/animated.gif',
                        image: characterModel.image,
                        fit: BoxFit.cover,
                      )
                    : Image.asset('assets/images/tab2.png')),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              characterModel.name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
