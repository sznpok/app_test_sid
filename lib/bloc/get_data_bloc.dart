import 'dart:developer';

import 'package:app_test_sid/bloc/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model.dart';

part 'get_data_event.dart';
part 'get_data_state.dart';

class GetDataBloc extends Bloc<GetDataEvent, GetDataState> {
  GetDataBloc() : super(GetDataInitial()) {
    on<FetchDataEvent>((event, emit) async {
      emit(GetDataLoadingState());
      AdRepository adRepository = AdRepository();
      try {
        final result = await adRepository.fetchAds();
        if (result.status == true) {
          emit(GetDataSuccessState(adResponse: result));
        } else {
          log("message");
          emit(GetDataErrorState(error: "Could not fetch data"));
        }
      } catch (e) {
        log(e.toString());
        emit(GetDataErrorState(error: "Could not fetch data ${e.toString()}"));
      }
    });
  }
}
