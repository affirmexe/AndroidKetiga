import 'package:flutter/material.dart';
import 'package:flutter_application_2/cubit/create_users/create_user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void_registerUser({
    required String nama,
    required String username,
    required String password,
  }) async {
    if (_namaController.text.trim().isEmpty ||
        _usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }

    context.read<CreateUserCubit>().createUser(
      nama: nama,
      username: username,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CreateUserCubit, CreateUserState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (dataUser) {
              return showBottomSheet(
                enableDrag: true,
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return Container(
                    height: 300,
                    width: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, size: 56, color: Colors.green),
                        SizedBox(height: 24),
                        Text("Register Berhasil"),
                      ],
                    ),
                  );
                },
              );
            },
            orElse: () {},
          );
        },
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/images/blob-scene-haikei.svg",
              fit: BoxFit.cover,
            ),

            Align(
              alignment: Alignment.center,
              child: Container(
                height: 400,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "nama :",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          TextField(controller: _namaController),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "username :",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          TextField(controller: _usernameController),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password :",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    BlocBuilder<CreateUserCubit, CreateUserState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );

                        return FilledButton(
                          onPressed: () => _registerUser(
                            nama: _namaController.text.trim(),
                            username: _usernameController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                )
                              : Text("Register"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
