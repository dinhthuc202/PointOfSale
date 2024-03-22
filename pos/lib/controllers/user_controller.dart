import 'package:get/get.dart';

import '../models/User.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  User user = User.fromJson({
    "id": 2,
    "userName": "admin",
    "password": null,
    "groupId": "ADMIN",
    "name": "Bui The Anh",
    "address": "2112",
    "email": "btanh@cmc.com.vn",
    "phone": "0904132399",
    "provinceId": 1,
    "districtId": 1,
    "createdDate": "2021-04-11T20:34:39.807",
    "createdBy": null,
    "modifiedDate": null,
    "modifiedBy": null,
    "status": true
  });
}
