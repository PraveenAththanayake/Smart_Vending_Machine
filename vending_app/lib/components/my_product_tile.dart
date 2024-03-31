import 'package:flutter/material.dart';
import 'package:vending_app/models/product.dart';
import 'package:vending_app/models/shop.dart';
import 'package:provider/provider.dart';

class MyProductTile extends StatefulWidget {
  final Product product;

  const MyProductTile({Key? key, required this.product}) : super(key: key);

  @override
  _MyProductTileState createState() => _MyProductTileState();
}

class _MyProductTileState extends State<MyProductTile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final shop = context.watch<Shop>();
    final isCartEmpty = shop.cart.isEmpty;

    void addToCart() {
      if (!_isSelected && isCartEmpty) {
        setState(() {
          _isSelected = true;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Add ${widget.product.name} to your cart?'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<Shop>().addToCart(widget.product);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: const Icon(Icons.favorite),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${widget.product.price.toStringAsFixed(2)}'),
              Container(
                decoration: BoxDecoration(
                  color: _isSelected
                      ? Colors.grey
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: isCartEmpty ? () => addToCart() : null,
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
