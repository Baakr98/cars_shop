import 'package:cars_shop/core/helper_methods.dart';
import 'package:cars_shop/shopScreens/addReport/bloc/add_report_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import '../../../widgets/customBotton.dart';
import '../../../widgets/customfield.dart';
import '../../core/constance.dart';
import '../../widgets/customText.dart';

class AddReportScreen extends StatefulWidget {
  AddReportScreen({super.key, required this.billId});

  final String billId;

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final bloc = KiwiContainer().resolve<AddReportBloc>();

  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: CustomText(
          text: 'Add New Report',
          fontSize: 20,
        ),
      ),
      bottomSheet: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          // TODO: implement listener
          if(state is AddPartFailureState){
            toast(msg: state.message);
          }
          if(state is DeleteBillSuccessState){
            Navigator.pop(context);
          }else if(state is DeleteBillFailureState){
            toast(msg: state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 15, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBotton(
                  iconColor: green,
                  icon: Icons.add_circle_outline,
                  text: 'Add Report',
                  width: 180,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(
                width: 20,
              ),
              CustomBotton(
                  iconColor: red,
                  icon: Icons.cancel_rounded,
                  text: 'Cancel',
                  width: 180,
                  onPressed: () {
                    bloc.add(DeleteBillEvent(billId: widget.billId));
                  }),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Form(
                  key: bloc.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //todo:move

                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'Part Name        :   ',
                          ),
                          Container(
                            width: 200,
                            child: CutomField(
                              controller: bloc.partName,
                              hint: 'Enter Part Name',
                              onSaved: (value) {},
                              validator: (value) {
                                if (value == null || value == '') {
                                  return "please input the part Name";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          DateTime? datetime = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2050));
                          if (datetime != null) {
                            setState(() {
                              bloc.dateOfPurchase =
                                  DateFormat("yyyy-MM-dd").format(datetime);
                            });
                          }
                        },
                        child: Container(
                          child: Row(
                            children: [
                              CustomText(
                                text: 'purchase Date :  ',
                              ),
                              Text(
                                bloc.dateOfPurchase == null
                                    ? 'pick a date'
                                    : bloc.dateOfPurchase!,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'Insurance        :   ',
                          ),
                          Container(
                            width: 200,
                            child: CutomField(
                              controller: bloc.insurance,
                              hint: 'Enter Insurance',
                              onSaved: (value) {},
                              validator: (value) {
                                if (value == null || value == '') {
                                  return "please input the Insurance";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'Price                :   ',
                          ),
                          Container(
                            width: 200,
                            child: CutomField(
                              controller: bloc.price,
                              hint: 'Enter Price',
                              onSaved: (value) {},
                              validator: (value) {
                                if (value == null || value == '') {
                                  return "please input the Price";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomBotton(
                          icon: Icons.playlist_add_rounded,
                          text: 'Add Part',
                          onPressed: () {
                            if (bloc.dateOfPurchase != null) {
                              if (bloc.formKey.currentState!.validate()) {
                                bloc.add(AddPartEvent(
                                    partName: bloc.partName.text,
                                    dateOfPurchase: bloc.dateOfPurchase!,
                                    price: bloc.price.text,
                                    insurance: bloc.insurance.text,
                                    billId: widget.billId));
                              }
                            }
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
