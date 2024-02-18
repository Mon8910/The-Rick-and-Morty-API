import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../busniess_logic/cubit/charcters_cubit.dart';
import '../../data/model/character_model.dart';
import '../widgets/charaters_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
   List<CharacterModel> allCharacters=[];
   List<CharacterModel> searchedForCharacters=[];
  bool isserached = false;
  final searchTextControl = TextEditingController();
  

  
  Widget buildSerachField() {
    return TextField(
      controller: searchTextControl,
      cursorColor: Colors.red,
      decoration: const InputDecoration(
        hintText: 'Find a Character ..',
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        border: InputBorder.none,
      ),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      onChanged: (searchCharacter) {
        addSearchedItem(searchCharacter);
      },
    );
  }
@override
  void dispose() {
    searchTextControl.dispose();
    super.dispose();
  }

  void addSearchedItem(String searchCharacter) {
    searchedForCharacters = allCharacters
        .where((characters) =>
            characters.name.toLowerCase().startsWith(searchCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isserached) {
      return [
        IconButton(
            onPressed: () {
              clearsearch();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
            ))
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        )
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopsearching));
    setState(() {
      isserached = true;
    });
  }

  void stopsearching() {
    clearsearch();
    setState(() {
      isserached = false;
    });
  }

  void clearsearch() {
    setState(() {
      searchTextControl.clear();
    });
  }

  @override
  void initState() {
    allCharacters = BlocProvider.of<CharctersCubit>(context).fetchChatracter();
    super.initState();
  }

  Widget buildBlockWidgets() {
    return BlocBuilder<CharctersCubit, CharctersState>(
        builder: (context, state) {
      if (state is Characterloaded) {
        allCharacters = (state).characters;
        return buildLoadedData();
      } else {
        return buildloadingData();
      }
    });
  }

  Widget buildloadingData() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoadedData() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey,
        child: Column(
          children: [buildCharactersGridView()],
        ),
      ),
    );
  }

  Widget buildCharactersGridView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        itemCount:searchTextControl.text.isEmpty?  allCharacters.length: searchedForCharacters.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return CharactersItem(
            characterModel:searchTextControl.text.isEmpty? allCharacters[index] : searchedForCharacters[index],
          );
        });
  }

  Widget buildAppBartitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: Colors.grey),
    );
  }
  Widget offlineWidget(){
    return Center(child: Container(
      color: Colors.white,
      child: Column(
        children: [
         const SizedBox(height: 20,),
        const  Text("can't connect,please check your internet",style:  TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            
          ),),
          SizedBox(height: 10,),
          Image.asset('assets/images/noconnection.png',fit: BoxFit.cover,)

        ],
      ),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: isserached ? buildSerachField() : buildAppBartitle(),
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(connectivityBuilder: (
         (context, value, child) {
          final bool connected=value != ConnectivityResult.none;
          if(connected){
            return buildBlockWidgets();
          }else{
            return offlineWidget();
          }
          
          
          
        }
        
        
      ),child: buildloadingData(),)
      // body: buildBlockWidgets(),
    );
  }
}
