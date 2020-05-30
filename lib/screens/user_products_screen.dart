import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../screens/edit_product_screen.dart';
import './../widgets/app_drawer.dart';
import './../providers/products.dart';
import './../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add), 
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            }
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
              child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (ctx, index) => Column(
              children: <Widget>[
                UserProductItem(
                  products.items[index].id,
                  products.items[index].title, 
                  products.items[index].imageUrl
                ),
                Divider(),
              ],
            ),
            itemCount: products.items.length,
          ),
        ),
      ),
    );
  }
}