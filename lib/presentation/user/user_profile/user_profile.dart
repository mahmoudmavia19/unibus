import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'controller/user_profile_controller.dart';

class UserProfileScreen  extends StatelessWidget {
  UserProfileController controller = Get.put(UserProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
         body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: controller.flowState.value.getScreenWidget(_body(), (){
              controller.getProfile() ;
            }),
          ),
        ),
        floatingActionButton:
        FloatingActionButton(onPressed: (){
          controller.toggleEditMode(); 
        }, child: controller.isEditMode.value ?Icon(Icons.edit_off_sharp) : Icon(Icons.edit),),
      ),
    );
  }

  _body()=>Column(
    children: [
      Image.asset(ImageConstant.imgLogo, width: 150,),
      SizedBox(height: 30.0,),
      _buildTextFormField(AppStrings.name, Icons.person,readOnly: !controller.isEditMode.value,controller: controller.nameController),
      _buildTextFormField(AppStrings.email, Icons.email,controller: controller.emailController,readOnly: true),
      _buildTextFormField(AppStrings.phone, Icons.phone,readOnly: !controller.isEditMode.value,controller: controller.phoneController),
      _buildTextFormFieldPassword(AppStrings.password, Icons.lock,readOnly:!controller.isEditMode.value,controller: controller.passwordController),
      SizedBox(height: 30.0,),
      Visibility(
        visible: controller.isEditMode.value,
        child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(onPressed: () {
              controller.updateProfile();
            }, child: Text(AppStrings.save))),
      ) ,
      SizedBox(
        width: 150.0,
        child: TextButton(onPressed: (){
          Get.offAndToNamed(AppRoutes.switchScreen);
        },
            style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout),
                Text('Logout',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
              ],
            )),
      ),

    ],
  );
  _buildTextFormField(String title, IconData iconData, {TextEditingController? controller , bool readOnly = true}) {
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
                      child: Icon(iconData, color: Colors.white,)),
                )
            )
        ),
      ),
    );
  }

  _buildTextFormFieldPassword(String title, IconData iconData, {TextEditingController? controller,bool readOnly = true}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        height: 50.0,
        child: TextFormField(
            controller: controller,
            readOnly: readOnly,
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
                      child: Icon(iconData, color: Colors.white,)),
                )
            )
        ),
      ),
    );
  }
}
