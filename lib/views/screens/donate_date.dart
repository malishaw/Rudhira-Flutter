import 'package:blooddonateapp/views/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DanateDateScreen extends StatefulWidget {
  DanateDateScreen({Key? key, required this.user}) : super(key: key);
  GoogleSignInAccount user;
  @override
  _DanateDateScreenState createState() => _DanateDateScreenState();
}

class _DanateDateScreenState extends State<DanateDateScreen> {
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('donate_days');
  DateTime selectedDate = DateTime.now();
  String date = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: themColor.withOpacity(0.6), // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Color.fromARGB(255, 4, 19, 75), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      date = documentSnapshot['date'];
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Add Your Blood Danate Date",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  FloatingActionButton.extended(
                    label: const Text('Select date'), // <-- Text
                    backgroundColor: themColor,
                    icon: const Icon(
                      // <-- Icon
                      Icons.calendar_month,
                      size: 24.0,
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(action == 'create' ? 'Create' : 'Update'),
                    onPressed: () async {
                      final String? date = this.date;

                      if (date != null) {
                        if (action == 'create') {
                          // Persist a new product to Firestore
                          await _productss.add({
                            "date": date,
                            "name": widget.user.displayName,
                            "email": widget.user.email,
                          });
                        }

                        if (action == 'update') {
                          // Update the product
                          await _productss.doc(documentSnapshot!.id).update({
                            "date": date,
                          });
                        }
                        // Hide the bottom sheet
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: themColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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
        title: const Text("Blood Donation Date"),
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
                    title: Text(documentSnapshot['date']),
                    subtitle: Text(documentSnapshot['name'].toString()),
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
