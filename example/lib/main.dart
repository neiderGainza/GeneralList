import 'package:flutter/material.dart';
import 'package:general_list/general_list.dart';

bool primeTest(int n){
  if(n < 2) return false;
  if(n == 2) return true;
  if(n%2 == 0) return false;
  for(int i = 3; i * i <= n; i+=2){
    if(n % i == 0) return false;
  }

  return true;
}


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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
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
          // color: Colors.red,
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child:   Text(item.toString()),
          ),
        );
      }, 
      getItems: () async* {
        yield [for(int i = 0; i < 100000; i++) i];
      },

      orderChoices: [
        (order: (int a , int b) => a.compareTo(b), label: "Mayor a Menor"),
        (order: (int a , int b) => a%2 - b%2 + a.compareTo(b), label: "Pares Primero")
      ],

      filterWidgets: [
        MultipleSelectionFilterWidget(
          choices: [
            (filter: (int a) async => a%2 == 0    , label: "Pares"),
            (filter: (int a) async => a%2 == 1    , label: "Impares"),
            (filter: (int a) async => primeTest(a), label: "Primos")
          ], 
          title: "Hola"
        )
      ],
      noItemsFoundWidget: Align(
        alignment: AlignmentGeometry.topCenter,
        child: Text('No hay elementos'),
      ),
      headerBuilder: (items){
        return Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: ListTile(
              title: Text("Cantidad de elementos: "),
              trailing: Text(items.length.toString()),
            ), 
          ),
        );
      },
      // searchFunction: null,
    );
  }
}

