import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/deal_model.dart';

abstract class DealState extends Equatable {
  @override
  List<Object> get props => [];
}

class DealLoadingState extends DealState {}

//Deal success State
class DealSuccessState extends DealState {
  final Deal DealModel;

  DealSuccessState({required this.DealModel});

  @override
  // TODO: implement props
  List<Object> get props => [DealModel];
}

//Deal Fails State
class DealFailState extends DealState {
  final String message;

  DealFailState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
