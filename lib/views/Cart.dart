import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/controllers/Cart_controller.dart';
import '../main.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final Cart_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: GetBuilder<Cart_controller>(builder: (builder){
        if(BoxCart.isNotEmpty){
          return Container(
            height:  Get.height * 0.09,
            color: Colors.white,
            padding: EdgeInsets.all(Get.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               GetBuilder<Cart_controller>(builder: (builder){
                 return  GestureDetector(
                   onTap: (){
                     if(BoxCart.isNotEmpty){
                       Get.toNamed('checkout' , arguments: [{'total' : builder.total}]);
                     }
                   },
                   child: Container(
                     height: Get.height * 0.06,
                     width: Get.height * 0.15,
                     margin: EdgeInsets.all(2),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(15)),
                         color: Colors.deepPurple,
                         border: Border.all(color: Colors.deepPurple , width: 0.1)
                     ),
                     child: Center(
                       child: Text('31'.tr, style: TextStyle(
                           color: Colors.white,
                           fontSize: Get.height * 0.015,
                           fontWeight: FontWeight.bold
                       ),),
                     ),
                   ),
                 );
               }),
                GetBuilder<Cart_controller>(builder: (builder){
                  return Container(
                    height: Get.height * 0.06,
                    width: Get.height * 0.15,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white , width: 0.1)
                    ),
                    child: Center(
                      child: Text(formatter.format(builder.total) + ' '+'18'.tr, style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: Get.height * 0.017,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  );
                })
              ],
            ),
          );
        }else{
          return SizedBox();
        }
      },),
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: Get.height,
        child: GetBuilder<Cart_controller>(builder: (builder){
          if(BoxCart.isNotEmpty){
            return Cartslist();
          }else{
            return Center(child: Text('20'.tr),);
          }
        },),
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
  BestProductItem(String title , int price , String url , int id , int count , int category  , int index){
    return Container(
      height: Get.height * 0.17,
      padding: EdgeInsets.all(Get.height * 0.017),
      margin: EdgeInsets.only(top: Get.height * 0.01),
      width: Get.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Stack(
        children: <Widget>[
          PositionedDirectional(
           top: Get.height * 0.01,
           end:  Get.height * 0.01,
           child:  GetBuilder<Cart_controller>(builder: (builder){
             return GestureDetector(
               child:Icon(Icons.delete_outline_rounded),
               onTap: (){
                 builder.deleteData(index);
               },

             );
           },),),
          PositionedDirectional(
            top: Get.height * 0.003,
            start: Get.height * 0.0001,
            bottom: Get.height * 0.002,
            child: Container(
                height: Get.height * 0.12,
                width: Get.height * 0.14,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )),
              child: CachedNetworkImage(
                imageUrl: url,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
          ),
          PositionedDirectional(
            top: Get.height * 0.01,
            start:  Get.height * 0.15,
            child: SizedBox(
              width: Get.height * 0.2,
              child: Text(title , textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),),
          PositionedDirectional(
            bottom: Get.height * 0.02,
            start:   Get.height * 0.15,
            child:  Text(formatter.format(price) + ' '+'18'.tr , textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
             fontWeight: FontWeight.w800,
              color: Colors.deepPurple,
              fontSize: Get.height * 0.014
           ),
         ),),
          PositionedDirectional(
            bottom: Get.height * 0.01,
            end:  Get.height * 0.015,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: GetBuilder<Cart_controller>(builder: (builder){
                        return Row(
                          mainAxisSize: MainAxisSize.min, // لجعل الصف يأخذ أقل مساحة ممكنة
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                width: Get.height * 0.04,
                                height: Get.height * 0.035,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 1,
                                    )),
                                child: Center(
                                  child: Icon(Icons.remove , color: Colors.black,),),
                              ),
                              onTap: () async{
                                builder.updateCounterMin(title, price, count, index, url, category);
                              },
                            ),
                            spaceW(Get.height * 0.01),
                            Text(
                              '${count}',
                              style: TextStyle(fontSize: Get.height * 0.02 , color: Colors.deepPurple),
                            ),
                            spaceW(Get.height * 0.01),
                            GestureDetector(
                              child: Container(
                                width: Get.height * 0.04,
                                height: Get.height * 0.035,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.deepPurpleAccent,
                                      width: 1,
                                    )),
                                child: Center(
                                  child: Icon(Icons.add , color: Colors.white,),),
                              ),
                              onTap: () async{
                                 builder.updateCounterPlus(title, price, count, index, url, category);

                                },
                            )
                          ],
                        );
                      },),
                    ),
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }
  Cartslist() {
    return GetBuilder<Cart_controller>(builder: (builder) => ListView.builder(
        padding: EdgeInsets.only(right: Get.height * 0.009,left: Get.height * 0.009 , top: Get.height * 0.01),
        // to disable GridView's scrolling
        shrinkWrap: true, // You won't see infinite size error
        itemCount: BoxCart.length,
        itemBuilder: (BuildContext context, int index) {
          final product = BoxCart.getAt(index);
          return BestProductItem(product.title, product.price, product.image, product.item, product.count, product.category,index);
          },
      )
    );
  }
}
