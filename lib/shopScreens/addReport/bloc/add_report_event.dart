part of 'add_report_bloc.dart';

@immutable
abstract class AddReportEvent {}
class AddPartEvent extends AddReportEvent{
  final String partName,dateOfPurchase,price,insurance,billId;
  AddPartEvent({required this.partName, required this.dateOfPurchase, required this.price, required this.insurance, required this.billId});
}
class DeleteBillEvent extends AddReportEvent{
  final String billId;
  DeleteBillEvent({required this.billId});
}