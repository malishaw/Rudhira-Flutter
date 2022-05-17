import 'package:blooddonateapp/views/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BloodRequestScreen extends StatefulWidget {
  const BloodRequestScreen({Key? key}) : super(key: key);

  @override
  _BloodRequestScreenState createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('blood_requests');

  String dropdownValue = 'A-';

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _cityController.text = documentSnapshot['city'];
      _reasonController.text = documentSnapshot['reason'];
      dropdownValue = documentSnapshot['bloodType'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  // prevent the soft keyboard from covering text fields
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Blood Request Form",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: 'Full Name',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 90, 90, 90),
                              width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themColor, width: 2.0),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //blood types dropdown
                  Row(
                    children: [
                      const Text("Select Blood type :"),
                      const SizedBox(
                        width: 20,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black38, width: 3),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.4), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 13, 8, 23),
                                fontSize: 18),
                            underline: Container(
                                // height: 2,
                                // color: Colors.deepPurpleAccent,
                                ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                              'A-',
                              'A+',
                              'B-',
                              'O-',
                              'O+',
                              'AB-',
                              'AB+',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                        labelText: 'City',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 90, 90, 90),
                              width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themColor, width: 2.0),
                        )),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    color: const Color.fromARGB(255, 217, 217, 217),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 5,
                        controller: _reasonController,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Enter your Reason"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: themColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 15),
                          textStyle:const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      child: Text(action == 'create' ? 'Create' : 'Update'),
                      onPressed: () async {
                        final String? name = _nameController.text;
                        final String? city = _cityController.text;
                        final String? reason = _reasonController.text;
                        final String? bloodType = dropdownValue;

                        if (name != null &&
                            city != null &&
                            reason != null &&
                            bloodType != null) {
                          if (action == 'create') {
                            // Persist a new product to Firestore
                            await _productss.add({
                              "name": name,
                              "city": city,
                              "reason": reason,
                              "bloodType": bloodType
                            });
                          }

                          if (action == 'update') {
                            // Update the product
                            await _productss.doc(documentSnapshot!.id).update({
                              "name": name,
                              "city": city,
                              "reason": reason,
                              "bloodType": bloodType
                            });
                          }

                          // Clear the text fields
                          _nameController.text = '';
                          _reasonController.text = '';
                          _cityController.text = '';

                          // Hide the bottom sheet
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themColor,
        title: const Text("Request Blood"),
      ),
      body: StreamBuilder(
        stream: _productss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['city'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        backgroundColor: themColor,
        onPressed: () => _createOrUpdate(),
        child: const Icon(
          Icons.water_drop_rounded,
        ),
      ),
    );
  }
}

class Item {
  const Item(
    this.name,
  );
  final String name;
}
