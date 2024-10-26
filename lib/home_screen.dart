
import 'package:cart_api/cart_details.dart';
import 'package:cart_api/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  CartModelApi? dataFromAPI;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      String url = "https://dummyjson.com/carts";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = cartModelApiFromJson(res.body);
        _isLoading = false;
        setState(() {});
      } else {
        debugPrint("Failed with status: ${res.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Text(
          "REST API Example",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : dataFromAPI == null
              ? const Center(
                  child: Text("Failed to load data"),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: dataFromAPI!.carts.length,
                  itemBuilder: (context, index) {
                    final cart = dataFromAPI!.carts[index];
                    final firstProduct = cart.products.isNotEmpty ? cart.products[0] : null;
                    return firstProduct == null
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => CartDetailsPage(cart: cart),
                                ),
                              );
                            },
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.pink[100],
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 243, 242, 242),
                                    blurRadius: 0,
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(firstProduct.thumbnail, width: 100, height: 100),
                                  const SizedBox(height: 10),
                                  Text(firstProduct.title),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text("\$${firstProduct.price}"),
                                      const SizedBox(width: 25),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                ),
    );
  }
}
