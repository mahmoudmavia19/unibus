import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';

import '../../../widgets/drawer/comapnyDrawer.dart';
import 'controller/profile_controller.dart';

class CompanyProfile  extends StatelessWidget {
  CompanyController controller = Get.put(CompanyController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        drawer: CompanyDrawer(),
        appBar: AppBar(
          title: Text(AppStrings.companyProfile),
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
                _buildTextFormField(AppStrings.companyName, Icons.business,readOnly: !controller.isEditMode.value),
                _buildTextFormField(AppStrings.email, Icons.email),
                _buildTextFormField(AppStrings.phone, Icons.phone,readOnly: !controller.isEditMode.value),
                _buildTextFormFieldPassword(AppStrings.password, Icons.lock,readOnly:!controller.isEditMode.value),
                SizedBox(height: 30.0,),
                Visibility(
                  visible: controller.isEditMode.value,
                  child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(onPressed: () {
                        // Save company profile logic
                      }, child: Text(AppStrings.save))),
                )
              ],
            ),
          ),
        ),
        floatingActionButton:
        FloatingActionButton(onPressed: (){
          controller.toggleEditMode(); 
        }, child: controller.isEditMode.value ?Icon(Icons.edit_off_sharp) : Icon(Icons.edit),),
      ),
    );
  }

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
