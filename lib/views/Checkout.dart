import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Checkout_controller.dart';
import 'package:ui_ecommerce/views/Payment.dart';

import 'ConfirmationPage.dart';
import 'Delivery.dart';
class Checkout extends StatelessWidget {
   Checkout({super.key});
   Checkout_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: Get.height * 0.09,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: Get.height * 0.03 , top: Get.height * 0.02),
          child: GestureDetector(
            child: Text('53'.tr , style: TextStyle(
              fontSize: Get.height * 0.017,
              fontWeight: FontWeight.w500
            ),),
            onTap: () => Get.back(),
          ),
        ),
        centerTitle: true,
        title: Text('54'.tr , style: TextStyle(
          fontWeight: FontWeight.w800
        ),),
      ),
      body: GetBuilder<Checkout_controller>(builder: (builder){
        return Stepper(
          elevation: 0.1,
          type: StepperType.horizontal,
          currentStep: builder.currentStep,
          onStepContinue: builder.ContinueStap,
          onStepCancel: builder.CancelStap,
          steps: [
            Step(
              title: Text('44'.tr),
              content: Delivery(), // Define DeliveryForm widget
              isActive: builder.currentStep >= 0,
            ),
            Step(
              title: Text('45'.tr),
              content: Payment(), // Define PaymentForm widget
              isActive: builder.currentStep >= 1,
            ),
            Step(
              title: Text('46'.tr),
              content: ConfirmationPage(), // Define ConfirmationPage widget
              isActive: builder.currentStep >= 2,
            ),
          ],
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            if(controller.currentStep != 2){
              return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.01),
              child:  Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: controls.onStepContinue,
                    child:  Container(
                      height: Get.height * 0.04,
                      width: Get.height * 0.1,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.deepPurple,
                          border: Border.all(color: Colors.deepPurple , width: 0.1)
                      ),
                      child: Center(
                        child: Text('51'.tr, style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.height * 0.015,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.height * 0.015,
                  ),
                  (controller.currentStep == 1)? GestureDetector(
                    onTap: controls.onStepCancel,
                    child:  Container(
                      height: Get.height * 0.04,
                      width: Get.height * 0.1,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white12,
                          border: Border.all(color: Colors.grey , width: 0.1)
                      ),
                      child: Center(
                        child: Text('52'.tr, style: TextStyle(
                            color: Colors.grey,
                            fontSize: Get.height * 0.015,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ) : SizedBox()
                ],
              ),
              );
            }else{
              return SizedBox();
            }

          },
        );
      },
      ),
    );
  }
}


