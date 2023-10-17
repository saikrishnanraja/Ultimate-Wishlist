import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final urlController = TextEditingController();
  List productData = [
    [
      "Samsung S10 E",
      "₹ 52,000",
      "https://www.amazon.com/Samsung-Galaxy-128GB-Prism-Black/dp/B082T4F34B?th=1",
      "samsungs10e.jpg",
    ],
    [
      "Nike Air Force 1 '07",
      "₹ 7,495",
      "https://www.nike.com/in/t/air-force-1-07-shoes-WrLlWX/CW2288-111",
      "airforce.jpg",
    ],
    [
      "Apple AirPods Pro",
      "₹ 299",
      "https://www.soundguys.com/apple-airpods-pro-review-27106/",
      "",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Universal Wishlist",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  )),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: productData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    //color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 150,
                    child: GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse(productData[index][2]));
                      },
                      onLongPress: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: AlertDialog(
                            title: const Text('Delete Item'),
                            content: Text(productData[index][0]),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    productData.removeAt(index);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          productData[index][3] != ""
                              ? Image.asset("assets/" + productData[index][3],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.fitHeight)
                              : Image.asset("assets/noimg.png",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.fitHeight),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productData[index][0],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                Text(
                                  productData[index][1],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AlertDialog(
                title: const Text('Add Url'),
                content: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter your URL',
                  ),
                  controller: urlController,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
