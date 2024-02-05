import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/widgets/admin_drawer/admin_drawer.dart';

class AdminProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.adminProfile),
        actions: [
          Image.asset(ImageConstant.imgLogo, width: 50.0,),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(ImageConstant.imgLogo, width: 150,),
              SizedBox(height: 30.0,),
              _buildTextFormField(AppStrings.userName, Icons.person),
              _buildTextFormField(AppStrings.email, Icons.email),
              _buildTextFormFieldPassword(AppStrings.password, Icons.lock),
              SizedBox(height: 30.0,),
              SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(onPressed: () {
                 //   Get.toNamed(AppRoutes.adminUsersManagementScreen);
                    Get.toNamed(AppRoutes.adminCompaniesManagementScreen);
                  }, child: Text(AppStrings.save)))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.edit),),
    );
  }

  _buildTextFormField(title, IconData, {TextEditingController? controller}) {
          return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SizedBox(
          height: 50.0,
          child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: title,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          border: Border(
                            left: BorderSide(color: Colors.black,width: 1.0),
                            top: BorderSide(color: Colors.black,width: 1.0),
                            bottom: BorderSide(color: Colors.black,width: 1.0),
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                        ),
                        child: Icon(IconData, color: Colors.white,)),
                  )
              )
          ),
        ),
      );
  }

  _buildTextFormFieldPassword(title, IconData, {TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        height: 50.0,
        child: TextFormField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
                hintText: title,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        border: Border(
                          left: BorderSide(color: Colors.black,width: 1.0),
                          top: BorderSide(color: Colors.black,width: 1.0),
                          bottom: BorderSide(color: Colors.black,width: 1.0),
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                      ),
                      child: Icon(IconData, color: Colors.white,)),
                )
            )
        ),
      ),
    );
  }
}
