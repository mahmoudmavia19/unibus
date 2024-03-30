import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/student_requests/controller/student_requests_controller.dart';
import 'package:unibus/presentation/user/payment_screen/request/request.dart';
import 'package:unibus/widgets/drawer/comapnyDrawer.dart';
import '../../../core/utils/app_strings.dart';


// Model class for user requests

class StudentRequestScreen extends GetWidget<StudentRequestsController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.Requests), // Utilizing AppStrings
        actions: [
          Image.asset(
            ImageConstant.imgLogo,
            width: 50.0,
          ),
        ],
      ),
      body:DefaultTabController(length: 2, child:Column(
        children: [
          TabBar(tabs:[
            Tab(text: AppStrings.student,),
            Tab(text: AppStrings.employee,),
          ]),
          Expanded(
            child: Obx(
                ()=> controller.state.value.getScreenWidget(_body(),(){
                  controller.getRequests();
                })
            )
          )
        ]
      ))
    );
  }
_body()=>TabBarView(children: [
  _tab1(),
  _tab2(),
]);
  _tab1()=> ListView.builder(
    itemCount: controller.requests.length,
    itemBuilder: (context, index) {
      final userRequest = controller.requests[index];
      final user = controller.requests[index].user!;
       return Column(
        children: [
          ListTile(
            title: Text(
              user.name??'',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppStrings.email}: ${user.email}'),
                Text('${AppStrings.phone}: ${user.phone}'),
                Text('${AppStrings.status}: ${userRequest.status==0?AppStrings.pending:userRequest.status==1? AppStrings.accepted : AppStrings.rejected}'),              ],
            ),
            // You can add more actions if needed
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: userRequest.status == 0 || userRequest.status == 2,
                  child: IconButton(
                    icon: Icon(Icons.check, color: Colors.green), // or any other appropriate icon
                    onPressed: ()  {
                      Get.defaultDialog(title: 'Confirmation', middleText: 'Are you sure you want to accept this request?',actions: [
                        TextButton(onPressed: (){
                          userRequest.status = 1;
                          controller.updateRequest(userRequest);
                        }, child: Text('Yes')),
                        TextButton(onPressed: (){
                          Get.back();
                        }, child: Text('No')),
                      ]);
                    },
                  ),
                ),
                Visibility(
                  visible: userRequest.status == 0 || userRequest.status == 1,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.red), // or any other appropriate icon
                    onPressed: ()  {
                      Get.defaultDialog(title: 'Confirmation', middleText: 'Are you sure you want to reject this request?',actions: [
                        TextButton(onPressed: (){
                          userRequest.status =2;
                          controller.updateRequest(userRequest);
                        }, child: Text('Yes')),
                        TextButton(onPressed: (){
                          Get.back();
                        }, child: Text('No')),
                      ]);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.payment, color: Colors.blue), // Payment information button
                  onPressed: () {
                    // Show payment information dialog
                    _showPaymentInfoDialog(context, userRequest);
                  },
                ),
              ],
            ),
          ),
          Divider()
        ],
      );
    },
  );
  _tab2()=> ListView.builder(
    itemCount: controller.requests.length,
    itemBuilder: (context, index) {
      final userRequest = controller.requests[index];
      final user = controller.requests[index].user!;
      return Column(
        children: [
          ListTile(
            title: Text(
              user.name??'',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppStrings.email}: ${user.email}'),
                Text('${AppStrings.phone}: ${user.phone}'),
                 Text('${AppStrings.status}: ${userRequest.status==0?AppStrings.pending:userRequest.status==1? AppStrings.accepted : AppStrings.rejected}'),
              ],
            ),
            // You can add more actions if needed
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: userRequest.status == 0 || userRequest.status == 2,
                  child: IconButton(
                    icon: Icon(Icons.check, color: Colors.green), // or any other appropriate icon
                    onPressed: () {
                      Get.defaultDialog(title: 'Confirmation', middleText: 'Are you sure you want to accept this request?',actions: [
                        TextButton(onPressed: (){
                          userRequest.status = 1;
                          controller.updateRequest(userRequest);
                        }, child: Text('Yes')),
                        TextButton(onPressed: (){
                          Get.back();
                        }, child: Text('No')),
                      ]);
                    },
                  ),
                ),
                Visibility(
                  visible: userRequest.status == 0 || userRequest.status == 1,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.red), // or any other appropriate icon
                    onPressed: () {
                      Get.defaultDialog(title: 'Confirmation', middleText: 'Are you sure you want to reject this request?',actions: [
                        TextButton(onPressed: (){
                          userRequest.status =2;
                          controller.updateRequest(userRequest);
                        }, child: Text('Yes')),
                        TextButton(onPressed: (){
                          Get.back();
                        }, child: Text('No')),
                      ]);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.payment, color: Colors.blue), // Payment information button
                  onPressed: () {
                    // Show payment information dialog
                    _showPaymentInfoDialog(context, userRequest);
                  },
                ),
              ],
            ),
          ),
          Divider()
        ],
      );
    },
  );


  // Method to show payment information dialog
  void _showPaymentInfoDialog(BuildContext context, Request request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('User Name: ${request.user?.name}'),
              Text('Payment Method:${request.payment?.method}'), // Assuming it's a subscription payment
              Text('Payment Date: ${DateFormat.yMMMd().format(request.date!)}'), // Example payment date
              Text('Payment Amount: \$${request.payment?.amount}'), // Example payment amount
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
