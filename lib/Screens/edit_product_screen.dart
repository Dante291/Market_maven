import 'package:flutter/material.dart';

class EditproductScreen extends StatefulWidget {
  static const routename = '/edit_product';
  const EditproductScreen({Key? key}) : super(key: key);

  @override
  State<EditproductScreen> createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _pricefocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                  ),
                ),
                GestureDetector(
                  onTap: () => _pricefocusNode.requestFocus(),
                  child: TextFormField(
                    focusNode: _pricefocusNode,
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
