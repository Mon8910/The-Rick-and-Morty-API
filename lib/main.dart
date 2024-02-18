import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp( RickyMorty(appRouter: AppRouter(),));
}

class RickyMorty extends StatelessWidget{
  const RickyMorty({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }


}