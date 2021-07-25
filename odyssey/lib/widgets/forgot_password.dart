import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(borderRadius: 
          BorderRadius.circular(14),
          color: Colors.white,),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width:MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 30),
                alignment:Alignment.center,
                child: 
                    Text(
                          "Enter the email address associated with your account:",
                          textAlign: TextAlign.center,
                           style: TextStyle(color: Theme.of(context).primaryColor, fontSize:16,
                        fontWeight: FontWeight.w400),
                        ),                 
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: TextField(textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Enter your email address",
                  
                ),),
              ),
              Container(
                margin: EdgeInsets.only(top:18, bottom: 18),
                width:MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 30),
                alignment:Alignment.center,
                child: 
                    Text(
                          "(We'll send you a confirmation code to this email)",
                          textAlign: TextAlign.center,
                           style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.6), fontSize:14,
                        fontWeight: FontWeight.w400),
                        ),
              ),
              Container(
                        // height: (deviceSize.height - 200) * 0.10,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          // onPressed: ()=>_secondStep(context),
                          onPressed:()=>showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _secondStep(context);
                              },
                            ),
                          child: Text(
                           'Continue'
                          ),
                        ),
                      ),
              
            ],
          ),
        ),
      ),
    );
  }
}

_secondStep(context){
  return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(borderRadius: 
          BorderRadius.circular(14),
          color: Colors.white,),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text(
                  "Verification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width:MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 30),
                alignment:Alignment.center,
                child: 
                    Text(
                          "Enter the verfication code that you received in your mail:",
                          textAlign: TextAlign.center,
                           style: TextStyle(color: Theme.of(context).primaryColor, fontSize:16,
                        fontWeight: FontWeight.w400),
                        ),                 
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                child: TextField(textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Verification code",
                  
                ),),
              ),
              
              Container(
                        // height: (deviceSize.height - 200) * 0.10,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: (){},
                          child: Text(
                           'Verify'
                          ),
                        ),
                      ),
              
            ],
          ),
        ),
      ),
    ); 
}