import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import './../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    final products = widget.order.products;
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        ListTile(
          title: Text('\$${widget.order.amount}'),
          subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime) ),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more), 
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            }),
        ),
        if (_expanded) Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4
          ),
          height: min(products.length * 20.0 + 10.0, 100),
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    products[index].title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${products[index].quantity}X \$${products[index].price}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                    ),
                  )
                ],
              )
          ),
        ) 
      ],),
    );
  }
}