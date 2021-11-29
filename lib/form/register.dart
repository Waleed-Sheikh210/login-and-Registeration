
import 'package:demo/form/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  late bool _passwordVisible;
  late bool _ispasswordVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    _ispasswordVisible = false;
  }





  postData() async {

   final response = await http
        .post(Uri.http("192.168.1.115","php_api/post.php"), body: {
      "first_name": firstname.text,
      "last_name": lastname.text,
      "email_Address": email.text,
      "password": password.text,
      "Confirm_password":cpassword.text
      
    });
    
    if (response.statusCode == 200) {
        if(response.body == "Success"){
          return Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
        } else {
          showDialog(context: context, builder: (context)=>AlertDialog(
            title:const Text("ERROR:"),
            content: Text(response.body),
            actions: [TextButton(onPressed: (){Navigator.pop(context);}, child:const Text("OK"))],
          ));
        }
      
    } else {
      showDialog(context: context, builder: (context)=>AlertDialog(
            title:const Text("ERROR:"),
            content:const Text("Failed to connect to server!"),
            actions: [TextButton(onPressed: (){Navigator.pop(context);}, child:const Text("OK"))],
          ));
      print("Failed!");
      throw Exception("Failed to load Album");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Registration Form!",
                  style: TextStyle(color: Colors.black, fontSize: 30))
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              child: TextFormField(
                controller: firstname,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                  
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: lastname,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: "Last Name"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: password,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  labelText: "Password"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: cpassword,
              obscureText: !_ispasswordVisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _ispasswordVisible = !_ispasswordVisible;
                        });
                      },
                      icon: Icon(_ispasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  labelText: "Confirm Password"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 0)),
                onPressed: () {
                  postData();
                },
                child: const Text("Register")),
          ),
        ],
      )),
    );
  }
}
