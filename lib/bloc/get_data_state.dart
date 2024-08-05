part of 'get_data_bloc.dart';

@immutable
sealed class GetDataState {}

final class GetDataInitial extends GetDataState {}

final class GetDataLoadingState extends GetDataState {}

final class GetDataErrorState extends GetDataState {
  final String? error;

  GetDataErrorState({this.error});
}

final class GetDataSuccessState extends GetDataState {
  final AdResponse? adResponse;

  GetDataSuccessState({this.adResponse});
}
