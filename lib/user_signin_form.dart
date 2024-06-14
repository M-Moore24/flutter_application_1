import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/user_creation_form.dart';
import 'package:supabase/supabase.dart';

class UserSignInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Sign In Form'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
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
                    final response = await client.from('Clients').select().eq('email', _emailController.text).eq('password', _passwordController.text).execute();
                    
                    if (response.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${response.error!.message}')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signed in successfully')));
                      // Navigate to the next screen after successful sign in
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                    }
                  }
                },
                child: const Text('Sign In'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserCreationForm()),
                  );
                },
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: const Center(
        child: Text('Welcome!'),
      ),       
    );
  }
}