import 'package:flutter/material.dart';
import 'package:flutter_application_1/user_signin_form.dart';
import 'package:supabase/supabase.dart';

class UserCreationForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  UserCreationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Creation Form'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final client = SupabaseClient('https://ilouurvbfhqliazirjja.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlsb3V1cnZiZmhxbGlhemlyamphIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTgwMjIxOTgsImV4cCI6MjAzMzU5ODE5OH0.KhNniOqhL7hLQq1Y8MK8NAL5EeHy3t7beU2ASx6LEW4');
                    final response = await client.from('Clients').insert({
                      'username': _usernameController.text,
                      'email': _emailController.text,
                      'password': _passwordController.text,
                    }).execute();
                    if (response.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${response.error!.message}')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User created successfully')));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserSignInForm()),
                      );
                    }

                  }
                },
                child: const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}