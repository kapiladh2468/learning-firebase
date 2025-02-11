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

  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      _nameController.text = widget.company!.name!;
      _addressController.text = widget.company!.address!;
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Company company = Company(
                      id: widget.company?.id,
                      name: _nameController.text,
                      address: _addressController.text,
                    );
                    if (widget.company == null) {
                      await FirebaseDbServices().addCompany(company);
                    } else {
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
    );
  }
}