import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_ecommerce/controllers/Billing_controller.dart';
import 'package:ui_ecommerce/main.dart';
import 'package:ui_ecommerce/models/Bill.dart';
class Billing extends StatelessWidget {
   Billing({super.key});
   final Billing_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation:0.0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: Get.height * 0.3,
        leading: logo(),
      ),
      body: Column(
        children: [
          spaceH(Get.height * 0.015),
          Row(
            children: [
              searchTextInput(),
              filtersIcon(),
            ],
          ),
          spaceH(Get.height * 0.015),
         Expanded(child:  BillList())
        ],
      )
    );
  }
   BillList() {
     return GetBuilder<Billing_controller>(builder: (builder) => ListView.builder(
       physics: PageScrollPhysics(),
       padding: EdgeInsets.only(right: Get.height * 0.009,left: Get.height * 0.009 , top: Get.height * 0.01),
       // to disable GridView's scrolling
       shrinkWrap: true, // You won't see infinite size error
       itemCount: builder.billsList.length,
       itemBuilder: (BuildContext context, int index) {
         final BillOne = builder.billsList[index];
         return BillItem(BillOne.price, BillOne.delivery, BillOne.city, BillOne.address, BillOne.date, BillOne.status,BillOne.phone , BillOne.id);
       },
     )
     );
   }
   BillItem(int price, int delivery, String city, String address, DateTime date, int status, String phone, int index) {
    var total = price + delivery;
    var status_code ;
    if(status == 0){
      status_code = "73";
    }else if(status == 1){
      status_code = "74";
    }else if(status == 2){
      status_code = "75";
    }
    String formattedDate = DateFormat('yyyy/MM/dd').format(date);
     return GestureDetector(
       onTap: () {
         Get.toNamed('/products', arguments: [{'id': index}]);
       },
       child: Container(
         height: Get.height * 0.19,
         padding: EdgeInsets.all(Get.height * 0.017),
         margin: EdgeInsets.only(top: Get.height * 0.01),
         width: Get.height * 0.2,
         decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(color: Colors.black12),
             borderRadius: BorderRadius.all(Radius.circular(15))
         ),
         child: Stack(
           children: [
             PositionedDirectional(
               top: Get.height * 0.01,
               end:  Get.height * 0.005,
               child: FaIcon(FontAwesomeIcons.moneyBill , color: Colors.green,),),
             PositionedDirectional(
               bottom: Get.height * 0.03,
               end:  Get.height * 0.005,
               child: SizedBox(
                 child: Text('${formattedDate}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ),),
             PositionedDirectional(
               bottom: Get.height * 0.001,
               end:  Get.height * 0.005,
               child: SizedBox(
                 child: Text(' #${index} ${'71'.tr}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),),
             PositionedDirectional(
               bottom: Get.height * 0.001,
               start:  Get.height * 0.005,
               child: SizedBox(
                 child: Row(
                   children: [
                     Text('${'72'.tr}' , textAlign: TextAlign.start,
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                         color: Colors.deepPurple
                       ),
                     ),
                     spaceW(Get.height * 0.01),
                     Icon(Icons.remove_red_eye_outlined , color: Colors.deepPurple,)
                   ],
                 ),
               ),),
             PositionedDirectional(
               bottom: Get.height * 0.033,
               start:  Get.height * 0.005,
               child: Row(
                 children: [
                   Text((status_code.toString().tr) , textAlign: TextAlign.start,
                     style: TextStyle(
                       color:  (status == 0)? Colors.black : (status == 1)? Colors.deepPurple : Colors.green,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   spaceW(10),
                   (status == 0)? FaIcon(FontAwesomeIcons.hourglass , size: 15, color: Colors.black,) : (status == 1)? FaIcon(FontAwesomeIcons.truck , size: 15, color: Colors.deepPurple,)  : FaIcon(FontAwesomeIcons.check,size: 15 , color: Colors.green,) ,
                 ],
               ),),

             PositionedDirectional(
               top: Get.height * 0.01,
               start:  Get.height * 0.005,
               child: SizedBox(
                 width: Get.height * 0.2,
                 child: Text('${'47'.tr} : ${formatter.format(price)}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ),),
             PositionedDirectional(
               top: Get.height * 0.04,
               start:  Get.height * 0.005,
               child: SizedBox(
                 width: Get.height * 0.2,
                 child: Text('${'48'.tr} : ${formatter.format(delivery)}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ),),
             PositionedDirectional(
               top: Get.height * 0.07,
               start:  Get.height * 0.005,
               child: SizedBox(
                 width: Get.height * 0.2,
                 child: Text('${'49'.tr} : ${formatter.format(total)}' , textAlign: TextAlign.start,
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),),

           ],
         ),
       ),
     );
   }

   Padding filtersIcon (){
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.009 , end: Get.height * 0.009),
       child: const Icon(Icons.tune),
     );
   }
   Padding searchTextInput() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02 , end: Get.height * 0.002),
       child: SizedBox(
           width: Get.width * 0.83,
           child: TextField(
             decoration:  InputDecoration(
               fillColor: Color(0xfff1ebf1),
               filled: true,
               prefixIcon: const Icon(Icons.search),
               hintText: '70'.tr,
               enabledBorder: const OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
                 borderSide:  BorderSide(
                   color: Color(0xfff1ebf1),
                 ),
               ),
               focusedBorder: const OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
                 borderSide: BorderSide(color:Color(0xfff1ebf1),),
               ),
             ),
           )),
     );
   }
   Padding logo() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01),
       child: Row(
         children: [
           GestureDetector(
             onTap: (){
               Get.back();
             },
             child: Icon(Icons.arrow_back_ios),
           ),
           Image.asset('assets/images/logo.png' , fit: BoxFit.fill,width: Get.height * 0.06,height: Get.height * 0.03,),
           Text('0'.tr , style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: Get.height * 0.018
           ),)
         ],
       ),
     );
   }
   Padding actions() {
     return Padding(padding: EdgeInsetsDirectional.only(start: Get.height * 0.02, top: Get.height * 0.01 , end: Get.height * 0.02),
       child: Row(
         children: [
           spaceW(Get.height * 0.01),
           const Icon(Icons.favorite_border_outlined),
           spaceW(Get.height * 0.01),
           const Icon(Icons.shopping_cart_outlined),
           spaceW(Get.height * 0.01),

         ],
       ),
     );
   }
   SizedBox spaceH(double size) {
     return SizedBox(
       height: size,
     );
   }
   SizedBox spaceW(double size) {
     return SizedBox(
       width: size,
     );
   }
}