import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rive/rive.dart';

import 'User_menu.dart';

class IniSplash extends StatefulWidget{
  @override
  State<IniSplash> createState() => _IniSplashState();
}

class _IniSplashState extends State<IniSplash> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: IniSplashV(),),
      ),
    );
  }

}

class IniSplashV extends StatefulWidget{
  @override
  State<IniSplashV> createState() => _IniSplashStateV();
}

class _IniSplashStateV extends State<IniSplashV> {
  Color wt = Colors.white;
  Widget sp = Container(
    decoration: BoxDecoration(

    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Animate(
          effects: [FadeEffect(),FlipEffect(perspective:3.0 ), RotateEffect()],
          child: Image(
            image: AssetImage('images/makassar.png'),
            fit: BoxFit.scaleDown,
            height: 150,
          ),
        ),
        Container( height: 20,),
        Animate(
          effects: [FadeEffect(), ScaleEffect()],
          child: Text('Balitbangda Makassar App', style: TextStyle(
            // color: CupertinoColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
        ),
        Container( height: 20,),
        Animate(
          effects: [FadeEffect(), ShakeEffect()],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon( Icons.new_releases ),
              Icon( Icons.screen_search_desktop_outlined ),
              Icon( Icons.lightbulb_circle ),
              Icon( Icons.content_paste_search ),
              Icon( Icons.person_pin),
            ],
          ),
        )
      ],
    ),
  );

  Widget rv = RiveAnimation.network(
  'https://cdn.rive.app/animations/vehicles.riv',
  );
  @override
  Widget build(BuildContext context) {

    return sp;
  }
  getMain(){
    Timer(Duration(seconds: 1), () {
      setState(() {
        sp = Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(220, 18, 82, 200),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Animate(
                effects: [FadeEffect(),FlipEffect(perspective:3.0 ), RotateEffect()],
                child: Image(
                  image: AssetImage('images/makassar.png'),
                  fit: BoxFit.scaleDown,
                  height: 150,
                ),
              ),
              Container( height: 20,),
              Animate(
                effects: [FadeEffect(), ScaleEffect()],
                child: Text('Balitbangda Makassar App', style: TextStyle(
                  color: CupertinoColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              ),
              Container( height: 20,),
              Animate(
                effects: [FadeEffect(), ShakeEffect()],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon( Icons.new_releases,color: CupertinoColors.white,),
                    Icon( Icons.screen_search_desktop_outlined,color: CupertinoColors.white ),
                    Icon( Icons.lightbulb_circle,color: CupertinoColors.white ),
                    Icon( Icons.content_paste_search ,color: CupertinoColors.white),
                    Icon( Icons.person_pin,color: CupertinoColors.white),
                  ],
                ),
              )
            ],
          ),
        );
      });
    });

   //AudioPlayer().play(AssetSource("duarr.mp3"));
    var _timer = Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return UserMenu();
      }));
    });

  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMain();
    });
  }
}

