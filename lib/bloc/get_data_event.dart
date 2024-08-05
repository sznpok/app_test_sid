part of 'get_data_bloc.dart';

@immutable
sealed class GetDataEvent {}

final class FetchDataEvent extends GetDataEvent {}
