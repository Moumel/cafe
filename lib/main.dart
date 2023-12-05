import 'package:flutter/material.dart';

void main() {
  runApp(MyCoffeeApp());
}

class MyCoffeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shop',
      home: CoffeeCategoryScreen(),
    );
  }
}

class CoffeeItem {
  final String name;
  final double price;
  final String imageUrl;

  CoffeeItem({required this.name, required this.price, required this.imageUrl});
}

class CoffeeCategoryScreen extends StatefulWidget {
  @override
  _CoffeeCategoryScreenState createState() => _CoffeeCategoryScreenState();
}

class _CoffeeCategoryScreenState extends State<CoffeeCategoryScreen> {
  final List<String> categories = ["Hot Coffee", "Cold Coffee", "Sweets"];
  int _currentIndex = 0;
  Map<String, int> cart = {}; // Declare cart here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(child: Text('SET YOUR MIND FREE', style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/cafeimages/background.jpg'),
          )

        ),
        child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    // Navigate to another page based on the selected category
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoffeeListScreen(
                          category: categories[index],
                          cart: cart, // Pass cart to CoffeeListScreen
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    fixedSize: Size(100.0, 50.0),
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(17.0),
                    ),
                  ),
                  child: Text(categories[index]),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee, color: Colors.white,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white,),
            label: 'Cart',
          ),
        ],
        fixedColor: Colors.white,
        onTap: (index) {
          // Handle bottom navigation item taps
          if (index == 0) {
            // Navigate to the home screen (CoffeeCategoryScreen)
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 1) {
            // Navigate to the cart screen (You can replace this with your cart screen)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(cart: cart),
              ),
            );
          }
        },
      ),
    );
  }
}

class CoffeeListScreen extends StatefulWidget {
  final String category;
  final Map<String, int> cart;

  CoffeeListScreen({required this.category, required this.cart});

  @override
  _CoffeeListScreenState createState() => _CoffeeListScreenState();
}

class _CoffeeListScreenState extends State<CoffeeListScreen> {
  late List<CoffeeItem> items;

  @override
  void initState() {
    super.initState();
    // Dummy data for each category
    if (widget.category == "Hot Coffee") {
      items = [
        CoffeeItem(name: "Espresso", price: 2.99, imageUrl: "lib/cafeimages/espresso.png"),
        CoffeeItem(name: "Cappuccino", price: 3.99, imageUrl: "lib/cafeimages/cappuccino.png"),
        CoffeeItem(name: "Latte", price: 4.49, imageUrl: "lib/cafeimages/coffee-cup.png"),
      ];
    } else if (widget.category == "Cold Coffee") {
      items = [
        CoffeeItem(name: "Iced Coffee", price: 3.49, imageUrl: "lib/cafeimages/iced.png"),
        CoffeeItem(name: "Frappe", price: 4.99, imageUrl: "lib/cafeimages/frappe.png"),
        CoffeeItem(name: "Cold Brew", price: 4.29, imageUrl: "lib/cafeimages/cold-drink.png"),
      ];
    } else {
      items = [
        CoffeeItem(name: "Donuts", price: 1.99, imageUrl: "lib/cafeimages/donut.png"),
        CoffeeItem(name: "Cakes", price: 5.99, imageUrl: "lib/cafeimages/strawberry-cake.png"),
        CoffeeItem(name: "Pastries", price: 3.49, imageUrl: "lib/cafeimages/cupcake.png"),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${widget.category} Menu'),
      ),
      body: ListView.builder(

        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side: Image
                    Image.asset(
                      items[index].imageUrl,
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16.0), // Add some spacing between image and text
                    // Right side: Name and Price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index].name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '\$${items[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black
                                ),
                                onPressed: () {
                                  // Add the item to the cart
                                  setState(() {
                                    widget.cart[items[index].name] = (widget.cart[items[index].name] ?? 0) + 1;
                                  });
                                },
                                child: Text('+'),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                widget.cart.containsKey(items[index].name) ? widget.cart[items[index].name].toString() : '0',
                              ),
                              SizedBox(width: 8.0),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black
                                ),
                                onPressed: () {
                                  // Remove the item from the cart
                                  setState(() {
                                    if (widget.cart.containsKey(items[index].name)) {
                                      widget.cart[items[index].name] = (widget.cart[items[index].name] ?? 0) - 1;
                                      if (widget.cart[items[index].name] == 0) {
                                        widget.cart.remove(items[index].name);
                                      }
                                    }
                                  });
                                },
                                child: Text('-'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // You can customize this based on your use case
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation item taps
          if (index == 0) {
            // Navigate to the home screen (CoffeeCategoryScreen)
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 1) {
            // Navigate to the cart screen (You can replace this with your cart screen)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(cart: widget.cart),
              ),
            );
          }
        },
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final Map<String, int> cart;

  CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        backgroundColor: Colors.black,
      ),
      body: widget.cart.isEmpty
          ? Center(
        child: Text('Your Cart is Empty'),
      )
          : ListView.builder(
        itemCount: widget.cart.length,
        itemBuilder: (BuildContext context, int index) {
          String itemName = widget.cart.keys.elementAt(index);
          int itemCount = widget.cart.values.elementAt(index);
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$itemName x$itemCount'),
                ElevatedButton(
                  onPressed: () {
                    // Remove the item from the cart
                    setState(() {
                      widget.cart.remove(itemName);
                    });
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
