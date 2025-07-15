import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/core/enums/controller_status.dart';
import 'package:teacher/core/resource/navigator_manager.dart';
import 'package:teacher/core/resource/route_const.dart';
import 'package:teacher/features/auth/controller/auth_bloc.dart';
import 'package:teacher/features/auth/controller/auth_event.dart';
import 'package:teacher/features/auth/controller/auth_state.dart';
import '../../../../core/resource/assets_manager.dart';
import '../../../../core/resource/colors_manager.dart';
import '../../../../core/resource/string_manager.dart';
import '../../../../core/widgets/custom_snakbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _myCodeController = TextEditingController(text: '292317');
  final TextEditingController _mosqueCodeController = TextEditingController(text: '362646');

  @override
  void dispose() {
    _myCodeController.dispose();
    _mosqueCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesManager.signInPage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 240),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.loginStatus == ControllerStatus.error) {
                  showCustomSnackBar(
                    context,
                    message: state.message,
                    isError: true,
                  );
                }
                else if (state.loginStatus == ControllerStatus.loaded) {
                  showCustomSnackBar(
                    context,
                    message: StringManager.login,
                    isError: false,
                  );
                  AppNavigator.instance.push(name: RouteConst.home);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildTextField(
                      hintText: StringManager.myCode,
                      icon: Icons.lock,
                      controller: _myCodeController,
                    ),
                    SizedBox(height: 20),
                    buildTextField(
                      hintText: StringManager.groupCode,
                      icon: Icons.person,
                      controller: _mosqueCodeController,
                    ),
                    SizedBox(height: 230),
                    buildElevatedButton(context, state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(BuildContext context, AuthState state) {
    return ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            LoginEvent(
                              myCode: _myCodeController.text,
                              mosqueCode: _mosqueCodeController.text,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: offWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: state.loginStatus == ControllerStatus.loading
                        ? CircularProgressIndicator()
                        : const Text(
                            StringManager.register,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black),
                          ),
                  );
  }

  Widget buildTextField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: offWhite,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: greenLight, fontWeight: FontWeight.w700),
          suffixIcon: Icon(icon, color: greenLight),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
