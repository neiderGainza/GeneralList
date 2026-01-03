import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_list/view_model/list_bloc.dart';
import 'package:general_list/view_model/list_state.dart';

class Header<T> extends StatelessWidget{
  const Header({
    super.key,
    required this.headerBuilder
  });

  final Widget Function(List<T> items) headerBuilder;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ListBloc<T>, ListState<T>>(
      builder: (context, state){
        return headerBuilder(state.items);
      }
    );

  }
}