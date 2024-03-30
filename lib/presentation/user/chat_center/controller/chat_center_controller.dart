import 'package:get/get.dart';
import 'package:unibus/data/remote_data_source/remote_data_source.dart';
import 'package:unibus/presentation/admin/companies_management/model/company_model.dart';
import 'package:unibus/presentation/comapny/chat_center/model/message_model.dart';


class ChatRoomController extends GetxController {
   RxList<MessageModel> messages = <MessageModel>[].obs;
   Company company = Get.arguments;
   RemoteDataSource remoteDataSource = Get.find<RemoteDateSourceImpl>();
  @override
  void onInit() {
    getMessages();
      super.onInit();
  }

   getMessages()async{
     print('Start Messages');
     (await remoteDataSource.getMessages(company.companyId!)).listen((event) {
       messages.value = event;
     });
   }

  sendMessage(MessageModel message)async{
    (await remoteDataSource.sendMessage(company.companyId!, message));
  }


}
