import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductListRowWidget extends StatelessWidget{
  Product product;

  ProductListRowWidget(this.product);

  @override
  Widget build(BuildContext context) {
   return buildProductItemCard(context);
  }

  Widget buildProductItemCard(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          children: [
            Container(
              child: Image.network("https://media.istockphoto.com/photos/fresh-fruits-and-vegetables-picture-id589415708?k=20&m=589415708&s=170667a&w=0&h=JMr_v623pZ2eZjle31rh7GdJCPURnWoagDQ-M_BCDmU="),
              height: 130.0,
              width: MediaQuery.of(context).size.width/2,
            ),
            Text(product.productName.toString()),
            Text(product.unitPrice.toString()+" ₺",style: TextStyle(fontSize: 20.0, color: Colors.deepOrange),),
            
          ],
        ),
      ),
    );
  }
  
}