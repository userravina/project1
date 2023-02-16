import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:   Center(
            child: Text(
              "🛍️List of Fruits",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
          ),
          backgroundColor: Color(0xff008a7a),
        ),
        body: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "\n           🍎Apple\n",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                TextSpan(
                  text: "\n           🍇Greps\n",
                  style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                TextSpan(
                  text: "\n           🍒Cherry\n",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                TextSpan(
                  text: "\n           🍓Strawberry\n",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                TextSpan(
                  text: "\n           🥭Mango\n",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                TextSpan(
                  text: "\n           🍍pineapple\n",
                  style: TextStyle(
                    color: Colors.green.shade400,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                TextSpan(
                  text: "\n           🍋Lemon\n",
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                TextSpan(
                  text: "\n           🍉Watermelon\n",
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                TextSpan(
                  text: "\n           🥥Coconut\n",
                  style: TextStyle(
                    color: Colors.brown.shade500,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
