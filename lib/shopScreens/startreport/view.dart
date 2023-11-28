import 'package:cars_shop/shopScreens/addReport/View.dart';
import 'package:cars_shop/shopScreens/startreport/bloc/start_report_bloc.dart';
import 'package:cars_shop/widgets/customBotton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import '../../../widgets/customText.dart';
import '../../core/constance.dart';
import '../../core/helper_methods.dart';

class MainReport extends StatefulWidget {
  const MainReport({super.key});

  @override
  State<MainReport> createState() => _MainReportState();
}

class _MainReportState extends State<MainReport> {
  final bloc = KiwiContainer().resolve<StartReportBloc>()..add(GetUsersEvent());
  final blocUsers = KiwiContainer().resolve<StartReportBloc>()
    ..add(GetUsersEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: 'Add Record',
        ),
        backgroundColor: secondaryColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: 'User Name  :  ',
                        ),
                        BlocBuilder(
                          bloc: blocUsers,
                          builder: (context, state) {
                            if (state is GetUsersSuccessState) {
                              return DropdownButton(
                                borderRadius: BorderRadius.circular(15),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                hint: Text(blocUsers.userName == null
                                    ? 'Select User'
                                    : blocUsers.userName!),
                                items:
                                    List.generate(state.users.length, (index) {
                                  return DropdownMenuItem(
                                    // onTap: (){},
                                    value: state.users[index].userId!,
                                    // onTap: (){},
                                    child: CustomText(
                                      text: state.users[index].username!,
                                    ),
                                  );
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    bloc.selectedUserId = value;
                                    for (int i = 0;
                                        i < state.users.length;
                                        i++) {
                                      if (state.users[i].userId == value) {
                                        blocUsers.userName =
                                            state.users[i].username!;
                                        break;
                                      }
                                    }
                                  });
                                },
                              );
                            } else {
                              return DropdownButton(
                                borderRadius: BorderRadius.circular(15),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                hint: Text(blocUsers.userName == null
                                    ? 'Select User'
                                    : blocUsers.userName!),
                                items: List.generate(1, (index) {
                                  return DropdownMenuItem(
                                    child: CustomText(
                                      text: '',
                                    ),
                                  );
                                }),
                                onChanged: (value) {},
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: secondaryColor,
                      ),
                      width: 100,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BlocListener(
                            bloc: bloc,
                            listener: (context, state) {
                              if(state is UploadImageSuccessState){
                                bloc.imagePath=state.imagePath;
                              }else if  (state is UploadImageFailureState){
                                toast(msg: state.message);
                              }
                              if(state is StartNewReportSuccessState){
                                navigateTo(context, page: AddReportScreen(billId:state.billId));
                              }
                            },
                            child: InkWell(
                                onTap: () async {
                                  await bloc.imagePicker.imagePickerDialog(
                                      context: context,
                                      onSubmit: (file, name) async {
                                        bloc.imageFile = file;
                                        bloc.imageName = name;
                                      });
                                },
                                child: CustomText(
                                  text: 'Upload Bill',
                                  fontSize: 10,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  focusColor: secondaryColor,
                  onTap: () async {
                    DateTime? datetime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050));
                    if (datetime != null) {
                      setState(() {
                        bloc.dateOfBill = DateFormat("yyyy-MM-dd").format(datetime);
                      });
                    }
                  },
                  child: Container(
                    child: Row(
                      children: [
                        CustomText(text: 'Date of Bill  :       '),
                        Text(
                          bloc.dateOfBill == null ? 'pick a date' : bloc.dateOfBill!,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 5,
                  thickness: 2,
                  // indent: 20,
                  // endIndent: 0,
                  color: secondaryColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBotton(
                    icon: Icons.playlist_add_rounded,
                    text: 'Add Bill Parts',
                    onPressed: () {
                      bloc.add(StartNewReportEvent(userId: bloc.selectedUserId!, pic: bloc.imagePath!, dateOfBill: bloc.dateOfBill!));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
