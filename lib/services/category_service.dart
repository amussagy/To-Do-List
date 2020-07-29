import 'package:todoList/models/category.dart';
import 'package:todoList/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.save('categories', category.categoryMap());
  }

  getCategoryServices() async {
    return await _repository.getAll('categories');
  }
}
