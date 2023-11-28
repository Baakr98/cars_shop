import 'package:flutter/material.dart';

import '../core/constance.dart';
import '../model/billModelTest.dart';
import '../widgets/customText.dart';


class ShopBillScreen extends StatelessWidget {
  final Bill bill;
  const ShopBillScreen({super.key,required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:secondaryColor,centerTitle:true,title: CustomText(text: 'Bill Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: primaryColor),
                width: 350,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'shopName',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Date of Bill: ${bill.dateOfBill} ',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                height: 5700,
                child: ListView.builder(
                  itemCount: bill.parts.length,
                  itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 20,),

                        Row(
                          children: [
                            CustomText(
                              text: 'part name : ${bill.parts[index].partName}',
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: 'Price: ${bill.parts[index].price}',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: 'Date of Purchase: ${bill.parts[index].dateOfPurchase}',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Insurance: ${bill.parts[index].insurance}',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'The Bill Document: ',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: 300,
                            height: 150,
                            child: Image.network(
                              bill.pic!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
