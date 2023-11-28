part of 'reports_bloc.dart';

@immutable
abstract class ReportsEvent {}
class GetReportsEvent extends ReportsEvent{
  final String userId;
  GetReportsEvent({required this.userId});
}
