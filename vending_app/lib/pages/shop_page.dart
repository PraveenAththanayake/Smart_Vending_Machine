import 'package:flutter/material.dart';
import 'package:vending_app/components/my_product_tile.dart';
import 'package:vending_app/models/shop.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Shop>().shop;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Shop Page'),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: ListView(children: [
            const SizedBox(height: 25),
            Center(
                child: Text(
              "Pick from a selected list of premium products",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            )),
            SizedBox(
              height: 550,
              child: ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return MyProductTile(product: product);
                  }),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              width: 300,
              child: SizedBox(
                height: 200,
                child: context.watch<Shop>().cart.isEmpty
                    ? Center(child: Text('Select an item from the products'))
                    : Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12)),
                        child: ListView.builder(
                          itemCount: context.watch<Shop>().cart.length,
                          itemBuilder: (context, index) {
                            final product = context.watch<Shop>().cart[index];
                            return ListTile(
                              title: Text(product.name),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  context.read<Shop>().removeFromCart(product);
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 25),
          ]),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            width: 100,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12)),
            child:
                MaterialButton(onPressed: () {}, child: const Text('Checkout')),
          ),
        ),
      ],
    );
  }
}
