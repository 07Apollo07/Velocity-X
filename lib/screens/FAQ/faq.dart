import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocityx/screens/settings/settings.dart';
import 'package:expandable/expandable.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  String loremIpsum =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ";
  List<String> questions = [
    "How can I access my document?",
    "Why can I not view the whole document?",
    "How can I add priority to a document?",
    "Can I view documents from other organizations?",
    "Can I modify the document after I have uploaded it?",
    "How can I view the documents assigned to me?",
    "Can I change my organization in the app?",


  ];

  List<String> answers = [
    "Please go to your Profile > Documents. You will find a list of all the documents you have created. You can easily track the status by clicking on any document.",
    "The document is assigned at the time of creation by the owner. If you feel there is a mistake / you should be able to access a particular document, please try contacting the owner.",
    "You can easily add prioritity to your pending documents. You can find the documents assigned to you on the dashboard. Simply, select the document you want and you will find the options to choose the priority.",
    "No, you can only access documents from your organization. ",
    "Yes, you can! If you have created the document, or the document is assigned to you, you can definitely modify it. However, the document can not be modified once its approved by the final approver.",
    "The documents assigned to you are available on the dashboard. Tip: You can assign priority to your pending documents. You can also easily access documents based on the categories mentioned at the top of the page: (Urgent, High, Medium, Low). Choose your documents smartly!",
    "No, you cannot. In case of any changes, you need to be first removed from your current organization and added to the new one by the administartor of the involved organizations.",


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black38,
        title: Text("Help",
            style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(children: [

                for(var i=0; i< questions.length; i++) dropdowncard(questions[i],answers[i])
              ])),
        ),
      ),
      // bottomNavigationBar: BottomNavigation()
    );
  }

  Widget dropdowncard(
    String heading,
    String answer
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ExpandableTheme(
            data: ExpandableThemeData(
                iconColor: Theme.of(context).secondaryHeaderColor,
                animationDuration: const Duration(milliseconds: 500)
            ),
            child: ExpandablePanel(
              
              header: Text(
                heading,
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,

                  fontSize: 16,
                ),
              ),
              collapsed: Text(
                "",
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              expanded: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(

                  answer,
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor
                  ),
                  softWrap: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
