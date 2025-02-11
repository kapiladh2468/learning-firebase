import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_demo/model/company.dart';

class FirebaseDbServices {

FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference companyCollection =FirebaseFirestore.instance.collection("Companies");

getAllData()async{
  try{
    var querySnapshot = await companyCollection.get();
    var allDocuments =querySnapshot.docs;
    print("All documents are $allDocuments");
    List<Company> allCompanies =[];

    for (var document in allDocuments){
      String id = document.id;
      Map data = document.data() as Map;

      // print("the data is $data");
      Company newCompany = Company(
        id: id,
      name: data['name']??"No name provided",
        address:data['address']?? "No address provided",
        phone:data['phone'],
       services:data['services'],
        establishedAt:  data['establishedAt'] 
      );
      allCompanies.add(newCompany);
    }
    return allCompanies;

  }
  catch(e){
print("The error is $e");
  }   
  }


  deleteCompany(String docId)async{

    await companyCollection.doc(docId)
    .delete().then((value)=>print("successfully deleted"))
    .onError((error, stackTrace) => print("error is $error and stack trace is $stackTrace"));
    

  }

  addCompany(Company company) {

  }

  updateCompany(Company company) {
    
  }
}




