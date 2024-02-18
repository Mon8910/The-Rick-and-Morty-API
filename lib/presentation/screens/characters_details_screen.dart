import 'package:flutter/material.dart';

import '../../data/model/character_model.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final CharacterModel character;
  const CharactersDetailsScreen({super.key, required this.character});
  Widget buildSliversAppBar() {
    //hna 3shan a3ml appbar welsora tt7rk
    return SliverAppBar(
        expandedHeight: 600, // hya tol el sora
        pinned: true,
        stretch: true,
        backgroundColor: Colors.grey,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            character.name,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          background: Hero(
            tag: character.id,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget characterinfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          TextSpan(children: [
            TextSpan(
                text: value,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ]),
        ]));
  }

  Widget buildDivider(double length) {
    return Divider(
      height: 30,
      endIndent: length,
      color: Colors.yellow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliversAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(10),
                color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterinfo('name:  ',character.name),
                    buildDivider(280),
                    characterinfo('staatus:  ', character.status),
                    buildDivider(280),
                    characterinfo('species: ', character.species),
                    buildDivider(280),
                    characterinfo('gender:  ', character.gender),
                    buildDivider(280),
                    const SizedBox(height: 100,)
                  

                   
                  ],
                  
                ),
                
              ),
            const  SizedBox(height: 400,)
            ]),
          ),
        ],
      ),
    );
  }
}
