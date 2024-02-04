import 'package:flutter/material.dart';
import 'package:unibus/core/app_export.dart';
import 'package:unibus/core/utils/app_strings.dart';
import 'package:unibus/widgets/admin_drawer/admin_drawer.dart';

import 'model/company_model.dart';


class CompanyManagementScreen extends StatelessWidget {
  final List<Company> companies = [
    Company(
      companyId: '1',
      name: 'Company A',
      email: 'companya@example.com',
      phone: '1234567890',
      password: '********',
    ),
    Company(
      companyId: '2',
      name: 'Company B',
      email: 'companyb@example.com',
      phone: '9876543210',
      password: '********',
    ),
    // Add more companies here as needed
  ];

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: companies.map((company) {
            return _buildCompanyCard(company: company);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCompanyCard({required Company company}) {
    return Card(
      child: ListTile(
        title: Text(
          company.name,
          style: TextStyle(
            color: theme.primaryColor,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppStrings.companyId}: ${company.companyId}'),
            Text('${AppStrings.email}: ${company.email}'),
            Text('${AppStrings.phone}: ${company.phone}'),
            Text('${AppStrings.password}: ${company.password}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.block, color: Colors.red),
          onPressed: () {
            // Implement logic to block company
          },
        ),
      ),
    );
  }
}
