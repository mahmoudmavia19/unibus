import 'package:flutter/material.dart';
 import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import '../../../core/app_export.dart';
import '../../../widgets/drawer/comapnyDrawer.dart';
import 'controller/drivers_controller.dart';
import 'model/driver.dart';

class DriverManagementScreen extends StatelessWidget {
  final DriverController driverController = Get.put(DriverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawer(),
      appBar: AppBar(
          title: Text(AppStrings.driversManagement),
          actions: [
            Image.asset(ImageConstant.imgLogo, width: 50.0,),
          ]
      ),
      body: Obx(() => driverController.state.value.getScreenWidget(_buildDriversList(), (){
      /*  if(driverController.state.value is SuccessState){
         print("success");
         driverController.state.value = ContentState();
        }*/
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addDriver(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDriversList() {
    return ListView.builder(
      itemCount: driverController.drivers.length,
      itemBuilder: (context, index) {
        Driver driver = driverController.drivers[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap:(){
                _showDriver(driver);
              },
              title: Text(driver.name),
              subtitle: Text(driver.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.rate_review),
                    onPressed: () => _showRateDriver(context, index, driver),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editDriver(context, index, driver),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteDriver(index),
                  ),
                ],
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }

  _buildText(text1,text2){
    return Row(
      children: [
        Text(text1.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(width: 10.0,),
        Text(text2.toString()),
      ],
    );
  }
  void _showDriver(Driver driver) {
    Get.defaultDialog(
      title: driver.name,
      content: SingleChildScrollView(
        child: Form(
          key: driverController.addFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(AppStrings.name,driver.name),
              _buildText(AppStrings.email,driver.email),
              _buildText(AppStrings.phone,driver.phone),
              _buildText(AppStrings.address,driver.address)
                         ],
          ),
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(AppStrings.cancelButtonText),
      ),
    );
  }


  void _addDriver(BuildContext context) {
    TextEditingController userIdController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Get.defaultDialog(
      title: AppStrings.addUserDialogTitle,
      content: SingleChildScrollView(
        child: Form(
          key: driverController.addFormKey,
          child: Column(
            children: [
              _buildTextField(userIdController, AppStrings.userNameLabel),
              _buildTextField(addressController, AppStrings.addressLabel),
              _buildTextField(phoneController, AppStrings.phoneLabel),
              _buildTextField(emailController, AppStrings.emailLabel),
              _buildTextField(passwordController, AppStrings.passwordLabel),
            ],
          ),
        ),
      ),
      confirm: TextButton(
        onPressed: () => _confirmAddDriver(
          userIdController.text,
          addressController.text,
          phoneController.text,
          emailController.text,
          passwordController.text,
        ),
        child: Text(AppStrings.addButtonText),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(AppStrings.cancelButtonText),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
      decoration: InputDecoration(labelText: labelText),
    );
  }

  void _confirmAddDriver(String userId, String address, String phone, String email, String password) {
    if(driverController.addFormKey.currentState!.validate()) {
      Driver newDriver = Driver(
        name: userId,
        address: address,
        phone:phone,
        email: email,
        password: password,
      );
      driverController.addDriver(newDriver);
      Get.back();
    }
  }
  _showRateDriver(BuildContext context, int index, Driver driver) {
    return Get.defaultDialog(
      titlePadding: EdgeInsets.all(10),
      contentPadding:EdgeInsets.all(20),
      title: driver.name + ' ' + AppStrings.rateDriverTitle,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star,color: Colors.amber,),
              Icon(Icons.star,color: Colors.amber,),
              Icon(Icons.star,color: Colors.amber,),
              Icon(Icons.star,color: Colors.grey,),
              Icon(Icons.star,color: Colors.grey,),
            ]
          ),
          SizedBox(height: 10.0,),
          Text('Rate this driver'),
        ]
      )
    ) ;
  }
  void  _editDriver(BuildContext context, int index, Driver driver) {
    TextEditingController userIdController = TextEditingController(text: driver.name);
    TextEditingController addressController = TextEditingController(text: driver.address);
    TextEditingController phoneController = TextEditingController(text: driver.phone.toString());
    TextEditingController emailController = TextEditingController(text: driver.email);
    TextEditingController passwordController = TextEditingController(text: driver.password);

    Get.defaultDialog(
      title: AppStrings.editUserDialogTitle,
      content: SingleChildScrollView(
        child: Form(
          key: driverController.editFormKey,
          child: Column(
            children: [
              _buildTextField(userIdController, AppStrings.userNameLabel),
              _buildTextField(addressController, AppStrings.addressLabel),
              _buildTextField(phoneController, AppStrings.phoneLabel),
              _buildTextField(emailController, AppStrings.emailLabel),
              _buildTextField(passwordController, AppStrings.passwordLabel),
            ],
          ),
        ),
      ),
      confirm: TextButton(
        onPressed: () => _confirmEditDriver(
          index,
          userIdController.text,
          addressController.text,
          phoneController.text,
          emailController.text,
          passwordController.text,
        ),
        child: Text(AppStrings.saveButtonText),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(AppStrings.cancelButtonText),
      ),
    );
  }

  void _confirmEditDriver(int index, String userId, String address, String phone, String email, String password) {
    if(driverController.editFormKey.currentState!.validate()) {
      Driver editedDriver = Driver(
        name: userId,
        address: address,
        phone:phone,
        email: email,
        password: password,
      );
      driverController.editDriver(index, editedDriver);
      Get.back();
    }
  }

  void _deleteDriver(int index) {
    Get.defaultDialog(
      title: AppStrings.confirmDeletionTitle,
      content: Text(AppStrings.confirmDeletionContent),
      confirm: TextButton(
        onPressed: () {
          driverController.deleteDriver(index);
          Get.back();
        },
        child: Text(AppStrings.deleteButtonText),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(AppStrings.cancelButtonText),
      ),
    );
  }
}
