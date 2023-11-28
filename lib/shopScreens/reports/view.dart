import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import '../../core/cache_helper.dart';
import '../../model/billModelTest.dart';
import '../../widgets/customText.dart';
import '../../widgets/cusomBillCard.dart';
import 'bloc/reports_bloc.dart';


class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final bloc = KiwiContainer().resolve<ReportsBloc>()
    ..add(GetReportsEvent(userId: CacheHelper.getId()));
  List<Bill> bills = [];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  CustomText(
                    text: 'My Reports',
                    fontSize: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if(state is GetReportsSuccessState){
                        return Container(
                          height: 600,
                          child: ListView.builder(
                            itemCount: state.bills.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomBillCard(index: index, bill: state.bills[index]);
                            },
                          ),
                        );
                      }else if(state is GetReportsFailureState){
                        return Center(child: Text(state.message),);
                      }else{
                        return const Center(child: CircularProgressIndicator(),);
                      }

                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
