import 'package:get/get.dart';
import 'package:ui_ecommerce/Services/RemoteServices.dart';
import 'package:ui_ecommerce/models/Category.dart';
import '../models/Product.dart';
import '../models/Slider.dart';
class Home_controller extends GetxController {
  int index = 0;
  var isLoadingProductes= true.obs;
  var isLoadingSliders= true.obs;
   List<String> productNames = [];
  var isLoadingCategories= true.obs;
  var productsList = <Product>[].obs;
  var slidersList = <SliderBar>[].obs;
  var filterProducts = <Product>[].obs;
  var categoriesList = <CategoryModel>[].obs;

  //fetch Productes
  void fetchProducts() async{
    isLoadingProductes(true);
    try {
      var products = await RemoteServices.fetchProductsRecently();
      if(products != null){
        productsList.value = products;
      }else{
      }
    }finally{
      isLoadingProductes(false);
    }
    update();
  }
  //fetch Sliders
  void fetchSliders() async{
    isLoadingSliders(true);
    try {
      var sliders = await RemoteServices.fetchSliders();

      if(sliders != null){
        isLoadingSliders(true);
        slidersList.value = sliders;
      }
    }finally{
      isLoadingSliders(false);
    }
  }
  //fetch Categories
  void fetchCategories() async{
    isLoadingCategories(true);
    try {
      var categories = await RemoteServices.fetchCategories();
      if(categories != null){
        isLoadingCategories(true);
        categoriesList.value = categories;
        print(isLoadingSliders);
      }
    }finally{
      isLoadingCategories(false);
    }
  }
  void searchProducts(title) async{
    try {
      var filters = await RemoteServices.filterProducts(title);
      if(filters != null){
        filterProducts.value = filters;
        productNames = filterProducts.map((product) => product.title).toList();
        print(productNames);
        update();
      }
    }finally{

    }
    update();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchProducts();
    fetchCategories();
    fetchSliders();
    super.onInit();
  }
  void changeindex(int i){
    index = i;
    update();
  }




}