import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade200,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                        ),
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        
                        Hero(
                          tag: product.id ?? 0, // unique tag for hero animation
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              product.thumbnail ?? "",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(height: 2,),

                        Text(product.title ?? "",
                        style: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: 2,),

                        Text(product.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          ),
                        ),

                        SizedBox(height: 2,),

                        Text(
                          "${product.price ?? ""}",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )

                      ],
                    ),

                    );
  }
}