import 'dart:io';

import 'package:com263592midtermstiw2044myshop1/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Newproduct extends StatefulWidget {
  @override
  _NewproductState createState() => _NewproductState();
}

class _NewproductState extends State<Newproduct> {
  double screenHeight, screenWidth;

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _productName, _productType;
  double _price;
  int _quantity;

  File _image;
  final picker = ImagePicker();

  Future getImagefromcamera() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  Future getImagefromGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print("No Image Selected");
      }
    });
  }

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
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Product',
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: _imageSelector(context)),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Product Name',
                              labelStyle: TextStyle(
                                fontSize: 20,
                              ),
                              hintText: 'Product Name',
                              prefixIcon: Icon(Icons.note),
                            ),
                            onSaved: (newValue) => _productName = newValue,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Product Type',
                              labelStyle: TextStyle(
                                fontSize: 20,
                              ),
                              hintText: 'Product Type',
                              prefixIcon:
                                  Icon(Icons.local_grocery_store_rounded),
                            ),
                            onSaved: (newValue) => _productType = newValue,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Price',
                                labelStyle: TextStyle(
                                  fontSize: 20,
                                ),
                                hintText: 'Price',
                                prefixIcon: Icon(Icons.attach_money_rounded),
                                suffix: Text('RM')),
                            onSaved: (newValue) =>
                                _price = double.tryParse(newValue),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Quantity',
                              labelStyle: TextStyle(
                                fontSize: 20,
                              ),
                              hintText: 'Quantity',
                              prefixIcon: Icon(Icons.format_list_numbered),
                            ),
                            onSaved: (newValue) =>
                                _quantity = int.tryParse(newValue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(18),
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      _submit(context);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Product product = Product(
          productName: _productName,
          productType: _productType,
          price: _price,
          quantity: _quantity);

      setState(() {
        _isLoading = true;
      });
      // bool isCreated =
      //     await Provider.of<ProductProvider>(context, listen: false)
      //         .addProduct(product, _image);
      // setState(() {
      //   _isLoading = false;
      // });
      // if (!isCreated)
      {
        Fluttertoast.showToast(
            msg: "Adding product failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      Navigator.of(context).pop();
    }
  }

  Container _imageSelector(BuildContext context) {
    return Container(
      height: screenHeight / 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: Text(
                "Take picture from:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton.icon(
                icon: Icon(Icons.camera_alt),
                onPressed: getImagefromcamera,
                label: Text('Camera'),
              ),
              RaisedButton.icon(
                icon: Icon(Icons.photo_album),
                onPressed: getImagefromGallery,
                label: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
