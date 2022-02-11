import 'package:equatable/equatable.dart';

//Creating Deal Events
abstract class DealEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//Bulk
class FetchEvent1 extends DealEvent {}

//Block
class FetchEvent2 extends DealEvent {}
