import 'package:flutter/widgets.dart';
import '../models/traveller.dart';
import 'package:http/http.dart' as http;

class Profile with ChangeNotifier {
  Traveller travellerUser;
  final String userId;
  final String username;
  final String authToken;

  Profile([this.username, this.userId, this.authToken, this.travellerUser]);

  void editProfile(Traveller profile) {
    print(profile.firstname);
    // final url =
    //     'https://flutter-update.firebaseio.com/products.json?auth=$authToken';
    // try {
    //   // final response = await http.post(
    //   //   url,
    //   //   body: json.encode({
    //   //     'title': product.title,
    //   //     'description': product.description,
    //   //     'imageUrl': product.imageUrl,
    //   //     'price': product.price,
    //   //     'creatorId': userId,
    //   //   }),
    //   // );
    //   // final newProduct = Product(
    //   //   title: product.title,
    //   //   description: product.description,
    //   //   price: product.price,
    //   //   imageUrl: product.imageUrl,
    //   //   id: json.decode(response.body)['name'],
    //   // );
    //   // _items.add(newProduct);
    //   // _items.insert(0, newProduct); // at the start of the list
    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw error;
    // }
  }
}
