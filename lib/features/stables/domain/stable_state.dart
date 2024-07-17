part of 'stable_cubit.dart';

@immutable
abstract class StableState {}

class StableInitial extends StableState {}

class GetAllStablesSuccessfully extends StableState {
  final List<Stable> stables;
  final int offset;
  final int count;

  GetAllStablesSuccessfully({required this.stables,required this.offset,required this.count});
}

class GetAllStablesLoading extends StableState {}

class GetAllStablesError extends StableState {
  final String? message;

  GetAllStablesError({this.message});
}

class ChoseStableSuccessful extends StableState{
  final String? message;
  ChoseStableSuccessful({required this.message});
}
class ChoseStableLoading extends StableState{}
class ChoseStableError extends StableState{
  final String? message;
  ChoseStableError({this.message});
}
