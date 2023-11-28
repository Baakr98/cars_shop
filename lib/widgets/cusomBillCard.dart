
import 'package:cars_shop/core/helper_methods.dart';
import 'package:flutter/material.dart';
import '../../widgets/customText.dart';
import '../core/constance.dart';
import '../model/billModelTest.dart';
import '../shopScreens/ShopBillScreen.dart';

class CustomBillCard extends StatelessWidget {
  const CustomBillCard({super.key, required this.index,required this.bill});
  final int index;
  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        // padding: EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 238, 238, 238),
        ),
        width: 370,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    // padding: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: secondaryColor,
                    ),
                    width: 70,
                    height: 70,
                    child: const Icon(
                      Icons.event_note_outlined,
                      color: white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Report $index: ${bill.parts[0].partName}',
                        fontSize: 20,
                      ),
                      CustomText(
                        text: bill.dateOfBill!,
                        fontSize: 16,
                        color: const Color.fromARGB(255, 95, 95, 95),
                      )
                    ],
                  )
                ],
              ),
              IconButton(
                  onPressed:(){
                    //todo:asd
                    navigateTo(context, page: ShopBillScreen(bill: bill));
                  },
                  icon:const Icon(Icons.more_vert_rounded,
                    size: 30,
                    color: Color.fromARGB(255, 143, 143, 143),)
              )
            ],
          ),
        ));
  }
}
