import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/view_model/list_bloc.dart';
import 'package:general_list/view_model/list_state.dart';


class MyListView<T> extends StatelessWidget{
  const MyListView({
    super.key,
    required this.itemBuilder
  });

  final Widget Function(BuildContext context, T object) itemBuilder; 


  @override
  Widget build(BuildContext context){
    return BlocBuilder<ListBloc<T>, ListState<T>>(
      builder: (context, state){

        return ListView.builder(
          itemBuilder: (context, index){
            return itemBuilder(context, state.items[index]);
          },
          itemCount: state.items.length,
        );
        
      }
    );
  }
}