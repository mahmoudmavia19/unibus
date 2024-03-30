import 'package:get/get.dart';
import 'package:unibus/data/remote_data_source/company_remote_data_source.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/comapny/chat_center/model/chat_model.dart';
import 'package:unibus/presentation/comapny/chat_center/model/message_model.dart';


class CompanyChatRoomController extends GetxController {
  RxList<MessageModel> messages = <MessageModel>[].obs;
  ChatModel chat = Get.arguments;
  CompanyRemoteDataSource remoteDataSource = Get.find<CompanyRemoteDataSourceImpl>();
  @override
  void onInit() {
    getMessages();
    super.onInit();
  }

  getMessages()async{
    print('Start Messages');
    (await remoteDataSource.getMessages(chat.id!)).listen((event) {
      messages.value = event;
    });
  }

  sendMessage(MessageModel message)async{
    (await remoteDataSource.sendMessage(chat.id!, message));
  }


}
