import 'package:bloc/bloc.dart';
import '../model/deal_model.dart';
import '../repository/repository1.dart';
import '../repository/repository2.dart';
import 'event_bloc.dart';
import 'state_bloc.dart';

//creating bloc events
class DealBloc extends Bloc<DealEvent, DealState> {
  //DealRepository1 for Bulk  Deal
  DealRepository1 dealRepository1;
  //DealRepository2 for block Deal
  DealRepository2 dealRepository2;

  DealBloc({required this.dealRepository1, required this.dealRepository2})
      : super(DealLoadingState());

  DealState get initialState => DealLoadingState();

  @override
  Stream<DealState> mapEventToState(DealEvent event) async* {
    if (event is FetchEvent1) {
      yield DealLoadingState();
      try {
        Deal DealModel = await dealRepository1.getDealData();
        print("Bloc Success");
        yield DealSuccessState(DealModel: DealModel);
      } catch (e) {
        print(await dealRepository1.getDealData());
        yield DealFailState(message: "Error");
      }
    }
    if (event is FetchEvent2) {
      yield DealLoadingState();
      try {
        Deal DealModel = await dealRepository2.getDealData2();
        print("Bloc Success");
        yield DealSuccessState(DealModel: DealModel);
      } catch (e) {
        print(await dealRepository2.getDealData2());
        yield DealFailState(message: "Error");
      }
    }
  }
}
