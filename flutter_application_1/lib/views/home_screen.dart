import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/product_card.dart';
import '../services/api_service.dart';
import '../models/product_model.dart';
import 'product_detail_screen.dart';
import 'card_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  ApiService apiService = ApiService();
  bool isLoading = false;
  String errorMessage = "";
  List<Products> allproducts = [];

  Set<int> cartIds = {}; // Set to store unique product IDs in the cart

  Future<void> fetchProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      ProductsModel data = await apiService.fetchProducts();

      setState(() {
        allproducts = data.products ?? [];
      });
    } catch (e) {
      setState(() {
        errorMessage = ("Failed to fetch products. Please try again later");
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override void initState() {
    fetchProducts();
    super.initState();
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discover",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CardScreen(
                      products: allproducts,
                      cartIds: cartIds,
                    
                    )),
                    );
                  },
                  iconSize: 35,
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.black)),
              ],
            ),

            SizedBox(height: 8,),

            Text("Find your perfect cosmetics",
            style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            SizedBox(height: 14),

            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f5f7),
                borderRadius: BorderRadius.circular(12),
              ),

              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search for anything",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 16,),

            Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                color: Color(0xfff5f5f7),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage("assets/images/banner.jpg"),
                  fit: BoxFit.fitWidth,
                )
              ),

            ),

            SizedBox(height: 16,),

            if (isLoading)
              Center(child: CircularProgressIndicator())

            else if (errorMessage != "")
              Center(child: Text(errorMessage))

            else
              Expanded(
                child: GridView.builder(
                  itemCount: allproducts.length, //  ürün sayısı kadar item oluştur
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context,index){

                  final product = allproducts[index];
                
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen
                      (
                        product: product,
                      cartIds: cartIds)
                      ),
                      );
            
                    },
                    child: ProductCard(product:   product));
                },  
                ),
              ),

          ],
        ),
      )
        ),
    );
  }
}