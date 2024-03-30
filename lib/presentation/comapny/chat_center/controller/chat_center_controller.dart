import 'package:get/get.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/admin/users_manage/model/user_model.dart';

import '../model/chat_model.dart';

class ChatCenterController extends GetxController {
   RxList<ChatModel> chats = <ChatModel>[].obs;
   RxList<UserModel> users = <UserModel>[].obs;
   CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  @override
  void onInit() async{
    await getUsers();
    await getChats();
      super.onInit();
  }
  Future<void> getUsers()async{
    (await remoteDataSource.getUsers()).fold((l){

    }, (r){
      users.value = r;
    });
  }
   Future<void> getChats()async{
    (await remoteDataSource.getChats()).listen((event) {
      chats.value = event.map((e){
        e.title = users.firstWhere((element) => element.userId == e.id).name;
        return e;
      }).toList();
    });
  }


}
