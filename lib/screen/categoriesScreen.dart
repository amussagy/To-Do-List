import 'package:flutter/material.dart';
import 'package:todoList/models/category.dart';
import 'package:todoList/screen/home_screen.dart';
import 'package:todoList/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key key}) : super(key: key);

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  _showFormInDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            FlatButton(
                onPressed: () async {
                  _category.name = _categoryName.text;
                  _category.description = _categoryDescription.text;
                  var result = await _categoryService.saveCategory(_category);
                  print(result);
                },
                child: Text("Save")),
            FlatButton(onPressed: () {}, child: Text("Cancel")),
          ],
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _categoryName,
                  decoration: InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'Write Category name',
                  ),
                ),
                TextField(
                  controller: _categoryDescription,
                  decoration: InputDecoration(
                    labelText: 'Category Description',
                    hintText: 'Write Category Description',
                  ),
                )
              ],
            ),
          ),
          title: Text("Categorty Form"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        leading: RaisedButton(
          elevation: 0,
          color: Colors.red,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: Center(
        child: Text('Welcome to categories screen!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormInDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
