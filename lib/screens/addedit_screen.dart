import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_demo/model/company.dart';
import 'package:flutter/material.dart';
import '../services/firebase_db_services.dart';

class AddEditScreen extends StatefulWidget {
  final Company? company;
  const AddEditScreen({super.key, this.company});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _servicesController = TextEditingController();
  TextEditingController _establishedAtController = TextEditingController();
   TextEditingController _phoneController = TextEditingController();




  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      _nameController.text = widget.company!.name!;
      _addressController.text = widget.company!.address!;
      _establishedAtController.text = widget.company!.establishedAt.toString();
       _phoneController.text = widget.company!.phone.toString();
        _servicesController.text = widget.company!.services .toString();
     
     

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company == null ? 'Add Company' : 'Edit Company'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Company Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a company name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address',
                  
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                 TextFormField(
                  controller: _servicesController,
                  decoration: InputDecoration(labelText: 'Services',
                  
                  )),
                   TextFormField(
                  controller: _establishedAtController,
                  decoration: InputDecoration(labelText: 'establishedAt',
                  
                  )),
                   TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone',
                  
                  )),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    
                    if (_formKey.currentState!.validate()) {
                      Company company = Company(
                         id: widget.company?.id,
                        name: _nameController.text,
                        address: _addressController.text,
                        establishedAt:Timestamp.fromDate(DateTime.now()),
                        services: ['Web development','Mobile Development'],
                        phone: 222222,
                      );
                      if (widget.company == null) {
                        await FirebaseDbServices().addCompany(company);
                      } else {
                        company.id= widget.company!.id;
                        await FirebaseDbServices().updateCompany(company);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.company == null ? 'Add' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}