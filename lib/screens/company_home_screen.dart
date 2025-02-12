import 'package:database_demo/model/company.dart';
import 'package:database_demo/screens/addedit_screen.dart';
import 'package:database_demo/services/firebase_db_services.dart';
import 'package:flutter/material.dart';
class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Home'),
      ),
      body: FutureBuilder(
        future: FirebaseDbServices().getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error getting data"));
          }
          if (snapshot.hasData) {
            List<Company> allCompanies = snapshot.data as List<Company>;
            return ListView.builder(
              itemCount: allCompanies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(allCompanies[index].name!),
                  subtitle:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ Text(allCompanies[index].address!),
                     
                     Row(
                      children: [
                        Text(allCompanies[index].phone!.toString()),
                      ],
                      
                    )
                   
                    ],
                  ),
    
                  trailing: PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditScreen(company: allCompanies[index]),
                          ),
                        );
                      } else {
                        await FirebaseDbServices().deleteCompany(allCompanies[index].id!);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(child: Text("Edit"), value: 'edit'),
                        PopupMenuItem(child: Text("Delete"), value: 'delete'),
                      ];
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditScreen()
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
