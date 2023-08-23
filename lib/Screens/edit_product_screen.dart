import 'package:flutter/material.dart';
import 'package:shop_app/Providers/Product.dart';

class EditproductScreen extends StatefulWidget {
  static const routename = '/edit_product';
  const EditproductScreen({Key? key}) : super(key: key);

  @override
  State<EditproductScreen> createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _pricefocusNode = FocusNode();
  final FocusNode _descriptionfocusNode = FocusNode();
  final imageURLcontroller = TextEditingController();
  final FocusNode _imagefocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedproduct = Product(id: '', imageUrl: '', price: 0, title: '');

  @override
  void dispose() {
    _imagefocusNode.removeListener(_updateImageURL);
    _descriptionfocusNode.dispose();
    _focusNode.dispose();
    _pricefocusNode.dispose();
    imageURLcontroller.dispose();
    _imagefocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imagefocusNode.addListener(_updateImageURL);
    super.initState();
  }

  void _updateImageURL() {
    if (!_imagefocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveform() {
    _form.currentState?.save();
    print(_editedproduct.id);
    print(_editedproduct.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: _saveform,
              icon: Icon(
                Icons.save,
                size: 30,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () => _focusNode.requestFocus(_focusNode),
                  child: TextFormField(
                    focusNode: _focusNode,
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      _pricefocusNode.requestFocus();
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _editedproduct = Product(
                            id: _editedproduct.id,
                            title: newValue,
                            imageUrl: _editedproduct.imageUrl,
                            price: _editedproduct.price);
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => _pricefocusNode.requestFocus(),
                  child: TextFormField(
                    focusNode: _pricefocusNode,
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      _descriptionfocusNode.requestFocus();
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _editedproduct = Product(
                            id: _editedproduct.id,
                            title: newValue,
                            imageUrl: _editedproduct.imageUrl,
                            price: double.parse(newValue));
                      }
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: imageURLcontroller.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(imageURLcontroller.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: imageURLcontroller,
                        focusNode: _imagefocusNode,
                        onSaved: (newValue) {
                          if (newValue != null) {
                            _editedproduct = Product(
                                id: _editedproduct.id,
                                title: newValue,
                                imageUrl: newValue,
                                price: _editedproduct.price);
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
