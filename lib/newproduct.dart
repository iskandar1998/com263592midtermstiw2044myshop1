import 'package:flutter/material.dart';

class Newproduct extends StatelessWidget {
  Widget textField({
    @required String hintText,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget button(
      {@required String buttonName,
      @required Color color,
      @required Color textColor}) {
    return Container(
      width: 120,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 20, color: textColor),
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var prname;
    var prtype;
    var prprice;
    var prqty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "New Product Form",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: prname,
                      decoration: InputDecoration(
                          labelText: 'Product Name',
                          icon: Icon(Icons.pedal_bike_rounded)),
                    ),
                    TextField(
                      controller: prtype,
                      decoration: InputDecoration(
                          labelText: 'Product Type',
                          icon: Icon(Icons.grade_sharp)),
                    ),
                    TextField(
                      controller: prprice,
                      decoration: InputDecoration(
                          labelText: 'Product Price',
                          icon: Icon(Icons.attach_money_rounded)),
                    ),
                    TextField(
                      controller: prqty,
                      decoration: InputDecoration(
                          labelText: 'Product Quanlity',
                          icon: Icon(Icons.local_grocery_store_rounded)),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(
                      buttonName: "Cancel",
                      color: Colors.grey,
                      textColor: Colors.black),
                  button(
                      buttonName: "Buy",
                      color: Colors.red,
                      textColor: Colors.white),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
