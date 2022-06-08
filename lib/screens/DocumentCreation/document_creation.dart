import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../assets/custom_icons_icons.dart';
import '../../controllers/authController.dart';


class DocumentCreation extends StatefulWidget {

  // final Function toggleView;
  //
  // DocumentCreation({required this.toggleView});

  @override
  State<DocumentCreation> createState() => _DocumentCreationState();
}

class _DocumentCreationState extends State<DocumentCreation> {

  final _formkey = GlobalKey<FormState>();

  bool finalApprover = false;
  bool downloadDocument = false;

  bool loading = false;

  String email = '';

  String password = '';

  String error = '';

  String _selectedService = "Final Approver";
  static const List<String> _services = ['Final Approver','Plumber','Carpenter','AC Mechanic','Pest Services','Washing Machine Mechanic'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new_rounded),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                new Text(
                  "Create Document",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // new Text(
                //   "Organization Code",
                //   style: TextStyle(fontSize: 13),
                // ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15.0),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 5.0,
                  ),
                ]),
            child: IconButton(
                onPressed: () {
                  AuthController.instance.signOut();
                },
                icon: Icon(CustomIcons.bell),
                color: Theme.of(context).primaryColor),
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,20,20,0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NAME',
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    width: 600,
                    child: TextFormField(
                      // style: TextStyle(color: Colors.black),

                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 2.0),
                        ),
                        // hintText: 'NAME',
                        fillColor: Colors.black54,
                        filled: true,


                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  CheckboxListTile(

                    title: Text("Do you want to appoint a final approver?"),
                    value: finalApprover,
                    onChanged: (newValue) {
                      setState(() {
                        finalApprover = newValue!;
                      });
                    },
                    // checkColor: Color(0xFF4784F1),
                    activeColor: Color(0xFF4784F1),
                    controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                  ),
                  SizedBox(height: 20,),
                  CheckboxListTile(

                    title: Text("Do you want the assigned person to download this document?"),
                    value: downloadDocument,
                    onChanged: (newValue) {
                      setState(() {
                        downloadDocument = newValue!;
                      });
                    },
                    // checkColor: Color(0xFF4784F1),
                    activeColor: Color(0xFF4784F1),
                    controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                  ),


                  Visibility(
                    visible: finalApprover,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        // boxShadow: <BoxShadow>[
                        //   BoxShadow(
                        //       color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                        //       blurRadius: 5) //blur radius of shadow
                        // ]
                      ),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(

                                  width: 0,
                                  style: BorderStyle.none
                              )
                          ),

                        ),
                        hint: Text('Final Approver'),
                        value: _selectedService,
                        onChanged: (newValue){
                          setState(() {
                            _selectedService = newValue.toString();
                          });
                        },
                        items: _services.map((service){
                          return DropdownMenuItem(
                            child: Text(service),
                            value: service,

                          );
                        }).toList(),
                      ),
                    ),
                  ),


                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload Document',
                            style: TextStyle(
                                fontSize:20
                            ),
                          ),
                          // Text(
                          //     '(Proof of Address)'
                          // )
                        ],
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.upload_file,
                            color: Color(0xFF4784F1),
                            size: 40,
                          )
                      )

                    ],
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: TextButton(

                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF4784F1),
                          padding: EdgeInsets.fromLTRB(40, 20, 40, 20)
                      ),
                      child: Text(
                        "Upload",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: () async{

                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}