import 'package:flutter/material.dart';

class EditproductScreen extends StatefulWidget {
  static const routename = '/edit_product';
  const EditproductScreen({Key? key}) : super(key: key);

  @override
  State<EditproductScreen> createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus all focus nodes
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    // Prevent the GestureDetector above from unfocusing this field
                    _focusNode.requestFocus();
                  },
                  child: TextFormField(
                    focusNode: _focusNode,
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
