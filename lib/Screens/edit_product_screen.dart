import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/Product.dart';
import 'package:shop_app/Providers/products.dart';

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

  var _initValues = {
    'title': '',
    'price': '',
    'imageURL': '',
  };

  var _isInit = true;
  var _isloading = false;

  @override
  void initState() {
    _imagefocusNode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productID =
          ModalRoute.of(context)?.settings.arguments as String? ?? '';

      if (productID != '') {
        _editedproduct =
            Provider.of<Products>(context, listen: false).findById(productID);
        _initValues = {
          'title': _editedproduct.title,
          'price': _editedproduct.price.toString(),
          'imageURL': '',
        };
        imageURLcontroller.text = _editedproduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageURL() {
    if (!_imagefocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveform() async {
    final isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isloading = true;
    });
    if (_editedproduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedproduct.id, _editedproduct);
      setState(() {
        _isloading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedproduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('An error occurred!'),
              content: Text('Something went wrong'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'))
              ],
            );
          },
        );
      }
      setState(() {
        _isloading = false;
      });
      Navigator.of(context).pop();
    }
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
      body: _isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          initialValue: _initValues['title'],
                          focusNode: _focusNode,
                          decoration: InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            _pricefocusNode.requestFocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            if (newValue != null) {
                              _editedproduct = Product(
                                  id: _editedproduct.id,
                                  title: newValue,
                                  imageUrl: _editedproduct.imageUrl,
                                  price: _editedproduct.price,
                                  isfav: _editedproduct.isfav);
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _pricefocusNode.requestFocus(),
                        child: TextFormField(
                          initialValue: _initValues['price'],
                          focusNode: _pricefocusNode,
                          decoration: InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (value) {
                            _descriptionfocusNode.requestFocus();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number.';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            if (newValue != null) {
                              _editedproduct = Product(
                                  id: _editedproduct.id,
                                  title: _editedproduct.title,
                                  imageUrl: _editedproduct.imageUrl,
                                  price: double.parse(newValue),
                                  isfav: _editedproduct.isfav);
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
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: imageURLcontroller.text.isEmpty
                                ? Text('Enter a URL')
                                : FittedBox(
                                    child:
                                        Image.network(imageURLcontroller.text),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: imageURLcontroller,
                              focusNode: _imagefocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide a value';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Please enter a valid URL';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  _editedproduct = Product(
                                      id: _editedproduct.id,
                                      title: _editedproduct.title,
                                      imageUrl: newValue,
                                      price: _editedproduct.price,
                                      isfav: _editedproduct.isfav);
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
