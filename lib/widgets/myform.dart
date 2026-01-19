import 'package:flutter/material.dart';

class Myform extends StatefulWidget {
  const Myform({super.key});

  @override
  State<Myform> createState() => _MyformState();
}

class _MyformState extends State<Myform> {
  final _formKey = GlobalKey<FormState>();
  String? ville = 'Sfax';
  var items = ['Sfax', 'Tunis', 'Sousse', 'Gabes'];
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  // show the password or not
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,

            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: "Enter your Name",
              labelText: "Name",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,

            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              hintText: "Enter your Email",
              labelText: "Email",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Email';
              }
              return null;
            },
          ),
          TextFormField(
            obscureText: _isObscure,

            controller: _passwordController,

            decoration: InputDecoration(
              icon: const Icon(Icons.key),
              hintText: "Enter your password",
              labelText: "Password",
              // this button is used to toggle the password visibility
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,

            decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              hintText: "Enter your phone",
              labelText: "Phone",
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your phone';
              }
              return null;
            },
          ),
          DropdownButton(
            value: ville,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                ville = newValue;
              });
            },
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Retourne true si le formulaire est valide, sinon false
                if (_formKey.currentState!.validate()) {
                  print(_nameController.text);
                  print(_emailController.text);
                  print(_passwordController.text);
                  print(_phoneController.text);
                  print(ville);
                  // Affiche le Snackbar si le formulaire est valide
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.greenAccent,
                ),
              ),
              child: const Text("submit"),
            ),
          ),
        ],
      ),
    );
  }
}
