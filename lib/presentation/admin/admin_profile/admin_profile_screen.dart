import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/admin/admin_profile/controller/admin_porfile_controller.dart';

import '../../../widgets/drawer/admin_drawer.dart';

class AdminProfileScreen extends GetWidget<AdminProfileController>{

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
      body: Obx(()=>Center(
          child: controller.state.value.getScreenWidget(_body(), (){
            controller.getProfile();
          })
        ),
      ),
      floatingActionButton:  Obx(()=>FloatingActionButton(onPressed: (){
          controller.editMode.value = !controller.editMode.value;
        }, child:!controller.editMode.value ? Icon(Icons.edit): Icon(Icons.edit_off_sharp) ,),
      ),
    );
  }

  _body()=>SingleChildScrollView(
    padding: EdgeInsets.all(20.0),
    child: Column(
      children: [
        Image.asset(ImageConstant.imgLogo, width: 150,),
        SizedBox(height: 30.0,),
        _buildTextFormField(AppStrings.userName, Icons.person, controller: controller.nameController),
        _buildTextFormField(AppStrings.email, Icons.email, controller: controller.emailController,readOnly: true),
        _buildTextFormFieldPassword(AppStrings.password, Icons.lock, controller: controller.passwordController),
        SizedBox(height: 30.0,),
        Obx(()=>Visibility(
            visible: controller.editMode.value,
            child: SizedBox( 
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(onPressed: () {
                  controller.updateProfile();
                }, child: Text(AppStrings.save))),
          ),
        )
      ],
    ),
  ) ;

  _buildTextFormField(title, IconData, {TextEditingController? controller , bool readOnly = false}) {
          return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SizedBox(
          height: 50.0,
          child: TextFormField(
              controller: controller,
              readOnly: readOnly,
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
