A GeneralList package.

## Features
-- Search 
-- Order
-- Filter
-- Custom Filter Widgets

## Getting started
This project depends on flutter_bloc and is mean to be use with drift ( it uses an stream from the repository to update the list)

## Usage

SearchOrderFilterPaginatedList<int>(
 
    itemBuilder: (context, value) => Card(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value.toString()),
        )),
    
    getItems   : () async* {
        yield [for(int i = 0 ; i < 10; i++) i];
    },

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    
    orderChoices: [
        (order: (int a, int b) => a.compareTo(b)     , label: "Mayor a menor"), 
    ],

    filterWidgets: [
        SingleSelectionFilterWidget<int>(
            title: "Paridad",
            choices: [
            (filter: (int a) async => (a%2 == 0) ,label: "Par"),
            (filter: (int a) async => (a%2 == 1) ,label: "Impar"),
            ]
        ),
    ],
)

## Additional information
Still working on this project, it will be better documentated in the future