import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/view_model/list_bloc.dart';
import 'package:general_list/view_model/list_state.dart';


class MyGridView<T> extends StatelessWidget{
  const MyGridView({
    super.key,
    required this.itemBuilder,
    required this.gridDelegate
  });

  final Widget Function(BuildContext context, T object) itemBuilder; 
  final SliverGridDelegate gridDelegate;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc<T>, ListState<T>>(
      builder: (context, state){

        return GridView.builder(
          gridDelegate: gridDelegate,

          itemBuilder: (context, index){
            return itemBuilder(context, state.items[index]);
          },
          itemCount: state.items.length,
        );
      }
    );
  }
}