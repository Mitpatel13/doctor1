import "package:flutter/material.dart";
import "package:vidhya_doctors/view/screens/payment/payment.dart";

import "../../../networkhandler.dart";
import "../../Utils/colors.dart";

class AccountAdd extends StatefulWidget {
  @override
  _AccountAddState createState() => _AccountAddState();
}

class _AccountAddState extends State<AccountAdd> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _accountNumController = TextEditingController();
  TextEditingController _reaccountNumController = TextEditingController();
  TextEditingController _ifscController = TextEditingController();
  bool firstClick = true;
  bool validate = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          "Payment Account",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _globalkey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  nameTextField(),
                  SizedBox(
                    height: 15,
                  ),
                  accountTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  reaccountTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  ifscTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "NB: The bank details you provide will be used to Pay you. Please check the details before proceeding ",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                          child: circular
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white70,
                                )
                              : InkWell(
                                  onTap: () async {
                                    if (_globalkey.currentState!.validate()) {
                                      Map<String, String> data = {
                                        "accNo": _accountNumController.text,
                                        "accName": _nameController.text,
                                        "ifsc": _ifscController.text
                                      };
                                      var response = await networkHandler.post2(
                                          "/updatePaymentaccount", data);
                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Account Inserted Successfully"),
                                          backgroundColor: AppColors.mainColor,
                                          elevation: 10,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(5),
                                        ));
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Payment()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Error to process , please try later"),
                                          backgroundColor: Colors.red,
                                          elevation: 10,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(5),
                                        ));
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: Text("Insert Account",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )),
                    ),
                  ),
                  // Divider(
                  //   height: 50,
                  //   thickness: 1.5,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      controller: _nameController,
      validator: (value) {
        if (value!.isEmpty) return "Name Can't be empty ";
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mainColor,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
        labelText: "Account Holder Name",
      ),
    );
  }

  Widget accountTextField() {
    return TextFormField(
      controller: _accountNumController,
      validator: (value) {
        if (value!.isEmpty) return "Account Number can't be empty";
        if (value.length < 8) return "Please enter the Valid input";
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mainColor,
            width: 2,
          ),
        ),
        labelText: "Account Number",
      ),
    );
  }

  Widget reaccountTextField() {
    return TextFormField(
      controller: _reaccountNumController,
      validator: (value) {
        if (value!.isEmpty) return "Account number can't be empty";
        if (value != _accountNumController.text)
          return "Account number Should be Same";
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mainColor,
            width: 2,
          ),
        ),
        labelText: "Re Enter Account number",
      ),
    );
  }

  Widget ifscTextField() {
    return TextFormField(
      controller: _ifscController,
      validator: (value) {
        if (value!.isEmpty) return "IFSC code can't be empty";
        return null;
      },
      // obscureText: vis,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mainColor,
            width: 2,
          ),
        ),
        labelText: "IFSC code",
      ),
    );
  }
}
