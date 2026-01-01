import 'package:flutter/material.dart';
import 'package:general_list/general_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(body: MyList(),),
    );
  }
}


class MyList extends StatelessWidget{
  const MyList({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return   GeneralList<int>(
      itemBuilder: (context, item){
        return Card(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Text(item.toString()),
          ),
        );
      }, 
      getItems: () async* {
        yield [for(int i = 0; i < 10; i++) i];
      },
      // searchFunction: null,
    );
  }
}

