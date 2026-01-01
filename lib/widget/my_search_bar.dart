import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/view_model/list_bloc.dart';
import 'package:general_list/view_model/list_event.dart';


class MySearchBar<T> extends StatefulWidget{
  const MySearchBar({
    super.key
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState<T>();
}


class _MySearchBarState<T> extends State<MySearchBar> {
  final textEditingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: textEditingController,
            onChanged : (newValue){
              context.read<ListBloc<T>>().add(
                SearchTermChangedEvent<T>(searchTerm: newValue)
              );
            },
            hintText: "Buscar",
          ),
        ),
      ],
    );
  }
}