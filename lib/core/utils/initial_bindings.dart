import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/data/apiClient/api_admin_client.dart';
import 'package:unibus/data/apiClient/api_client.dart';
import 'package:unibus/data/apiClient/api_company_client.dart';
import 'package:unibus/data/apiClient/api_driver_client.dart';
import 'package:unibus/data/remote_data_source/admin_remote_data_source.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';

import '../../data/remote_data_source/company_remote_data_source.dart';
import '../../data/remote_data_source/driver_remote_data_source.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Get.put(ApiClient(firebaseAuth, firebaseFirestore));
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    Get.put(RemoteDataSourceImpl(Get.find(), Get.find()));
    Get.put(ApiAdminClient(firebaseAuth, firebaseFirestore));
    Get.put(AdminRemoteDataSourceImpl(Get.find(), Get.find()));
    Get.put(ApiCompanyClient(firebaseAuth, firebaseFirestore));
    Get.put(CompanyRemoteDataSourceImpl(Get.find(), Get.find()));
    Get.put(ApiDriverClient(firebaseAuth, firebaseFirestore)) ;
    Get.put(DriverRemoteDataSourceImpl(Get.find(), Get.find()));
  }
}
