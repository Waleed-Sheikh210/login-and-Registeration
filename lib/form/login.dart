import 'package:demo/form/register.dart';
import 'package:demo/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  late bool _passwordVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  
     postData() async {

   final response = await http
        .post(Uri.http("192.168.1.115","/wordpress_learn/woocommerce_api/login/index.php"), body: {
      
      "email_Address": email.text,
      "password": password.text,
      
    });
    
    if (response.statusCode == 200) {
        
        if(response.body == "Successfully Logged in!"){
          return Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
        } else {
          print(response.body);
          showDialog(context: context, builder: (context)=>AlertDialog(
            title:const Text("ERROR:"),
            content:const Text("Your Email or Password does not matched!"),
            actions: [TextButton(onPressed: (){Navigator.pop(context);}, child:const Text("OK"))],
          ));
        }
      
    } else {
      print("Failed!");
      throw Exception("Failed to load Album");
    }

  }
  

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Login Form!",
                    style: TextStyle(color: Colors.black, fontSize: 30))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Email",
                  border: OutlineInputBorder(),
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
                        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off)),
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    labelText: "Password"),
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
                      onPressed: () {print("ds");postData();},
                      child: const Text("Login")),
                ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Flexible(
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                      height: 30,
                    ),
                  ),
                  Flexible(child: Text("OR")),
                  Flexible(
                    child: Divider(
                      height: 30,
                      color: Colors.black,
                      thickness: 2,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                          child: const Text(
                            "Register",
                          ))
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}
