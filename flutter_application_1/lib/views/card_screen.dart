import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/models/product_model.dart';

class CardScreen extends StatefulWidget {

  final List<Products> products;
  final Set<int> cartIds; 

  const CardScreen(
    {super.key,
  required this.products,
  required this.cartIds,
  });

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
                          .where((product) => widget.cartIds.contains(product.id))
                          .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cart",
        style: TextStyle(color: Colors.black)),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: 
        Column(
          children: [
            cartProducts.isEmpty ?
            
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey[300],),
                  SizedBox(height: 4,),
                  Text("Your cart is empty",
                  style: TextStyle(color: Colors.grey[500]),)
                ],
              ),
            ) 
            : Expanded(
              child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final item =cartProducts[index];
              
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(item.thumbnail ?? "", height: 70,
                            width: 70,
                            fit: BoxFit.cover,)
                            ),
                    
                          SizedBox(width: 16,),
                          Expanded(
                            child: 
                              Column(
                                children: [
                                  Text(item.title ?? "",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                    
                                    Text(item.description!),
                                    Text("${item.price?.toStringAsFixed(2) ?? "0.00"} \$", style: TextStyle( fontWeight: FontWeight.bold),),
                    
                                ],
                              ),
                              
                          ),
                    
                          IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.cartIds.remove(item.id);
                                  });
              
                                }, 
                                icon: Icon(Icons.remove_circle_outline),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                
              ),
              child: Text("Checkout", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
