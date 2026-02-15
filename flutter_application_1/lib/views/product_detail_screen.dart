import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products product;
  final Set<int> cartIds; // Set to store unique product IDs in the cart


  const ProductDetailScreen(
    {super.key,
    required this.product, 
    required this.cartIds});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back",style: TextStyle(color: Colors.black),),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),

      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.product.id!, // unique tag for hero animation
              child: Image.network(widget.product.thumbnail ?? "", height: 350,
              width: double.infinity,
              fit: BoxFit.cover,),
            ),
          
            SizedBox(height: 2,),
          
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title ?? "", 
                  style:TextStyle(fontSize: 28, fontWeight: FontWeight.bold
                ),
                ),
          
                SizedBox(height: 5,),
          
                Text(
                  widget.product.description ?? "",
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic,
                  color: Colors.grey[700]
                  ), 
                  maxLines: 3, 
                  overflow: TextOverflow.ellipsis,
                ),
          
                SizedBox(height: 10,),
          
                Text(
                  "Description",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                ),
          
                SizedBox(height: 2,),
          
                Text(widget.product.description ?? "",
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
          
                SizedBox(height: 10,),
          
                Text(
                  "${widget.product.price ?? ""} \$",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,
                  color: Colors.green[700]
                  ),
                ),
          
                SizedBox(height: 14,),
          
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      widget.cartIds.add(widget.product.id!); // Add product ID to the cart set
                    });
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added to cart!"),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green.shade600,
                      margin: EdgeInsets.only(
                        bottom: 70, 
                        left: 20, 
                        right: 20     
                      ),
                      ),
                    ); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 45),  
                  ),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white),
                    ),
                ),
              ],
            ),)
                ],
                ),
        )),    
      );
  }
} 