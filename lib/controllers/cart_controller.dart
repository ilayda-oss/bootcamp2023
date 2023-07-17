import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet_asistanim/controllers/home_controller.dart';
import 'package:diyet_asistanim/core/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var totalP = 0.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];
  var placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code': "234981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': user.email,
      'order_by_address': addressController.text.trim(),
      'order_by_state': stateController.text.trim(),
      'order_by_city': cityController.text.trim(),
      'order_by_phone': phoneController.text.trim(),
      'order_by_postalcode': postalController.text.trim(),
      'shipping_method': "Ön Görüşme",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'img': productSnapshot[i]['img'],
        'surname': productSnapshot[i]['surname'],
        'dietitian_id': productSnapshot[i]['dietitian_id'],
        'tprice': productSnapshot[i]['tprice'],
        'dietitianname': productSnapshot[i]['dietitianname'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
