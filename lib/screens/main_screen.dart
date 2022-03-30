import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_demo/models/category.dart';
import 'package:http_demo/widgets/product_list_widget.dart';

import '../data/data.api/category_api.dart';
import '../data/data.api/product_api.dart';
import '../models/product.dart';

class MainScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return MainScreenState();
  }

}

class MainScreenState extends State {
  List<Category> categories = <Category>[];
  List<Widget> categoryWidgets = <Widget>[];
  List<Product> products=<Product>[];

  @override
  void initState() {
    getCategoriesFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("eCommerce", style: TextStyle(color: Colors.white),),
       backgroundColor: Colors.deepOrange,
       centerTitle: true,

     ),
     body: Padding(
       padding: EdgeInsets.all(10.0),
       child: Column(
         children: [
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Row(children: categoryWidgets,),
           ),
           ProductListWidget(products)
         ],
       ),
     ),
   );
  }

  void getCategoriesFromApi() {
    CategoryApi.getCategories().then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        this.categories=list.map((category) => Category.fromJson(category)).toList();
        getCategoryWidgets();
      });
    });
  }

  List<Widget> getCategoryWidgets() {
    for (int i = 0; i < categories.length; i++){
      categoryWidgets.add(getCategoryWidget(categories[i]));
    }
    return categoryWidgets;
  }

  Widget getCategoryWidget(Category category) {
    return FlatButton(
      onPressed: () {
        getProductsByCategoryId(category);
      },
      child: Text(category.categoryName.toString(), style: TextStyle(color: Colors.deepOrange),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.deepOrange)
      ),
    );
  }

  void getProductsByCategoryId(Category category) {
    ProductApi.getProductsByCategoryId(category.id!.toInt()).then((response){
      setState(() {
        Iterable list = json.decode(response.body);
        this.products = list.map((product) => Product.fromJson(product)).toList();
      });
    });
  }



}