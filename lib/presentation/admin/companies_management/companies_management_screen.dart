import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/admin/companies_management/controller/companies_controller.dart';

import '../../../widgets/drawer/admin_drawer.dart';
import 'model/company_model.dart';


class CompanyManagementScreen extends GetWidget<CompaniesController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.companyManagement),
        actions: [
          Image.asset(
            ImageConstant.imgLogo,
            width: 50.0,
          ),
        ],
      ),
      body: Obx(()=>SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: controller.state.value.getScreenWidget(_body(), (){
            controller.getCompanies();
          })
        ),
      ),
    );
  }

  _body()=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: controller.companies.map((company) {
      return _buildCompanyCard(company: company);
    }).toList(),
  );

  Widget _buildCompanyCard({required Company company}) {
    return Card(
      child: ListTile(
        title: Text(
          company.name??'',
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          //  Text('${AppStrings.companyId}: ${company.companyId}'),
            Text('${AppStrings.email}: ${company.email}'),
            Text('${AppStrings.phone}: ${company.phone}'),
           ],
        ),
        trailing: IconButton(
          icon: company.blocked?Icon(Icons.remove_circle_outline, color: Colors.green):Icon(Icons.block, color: Colors.red),
          onPressed: () {
            controller.blockCompany(company);
          },
        ),
      ),
    );
  }
}
