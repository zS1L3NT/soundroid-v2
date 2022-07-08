import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/settings/settings.dart';
import 'package:soundroid/widgets/widgets.dart';

class ChangePasswordSection extends StatefulWidget {
  const ChangePasswordSection({Key? key}) : super(key: key);

  @override
  State<ChangePasswordSection> createState() => _ChangePasswordSectionState();
}

class _ChangePasswordSectionState extends State<ChangePasswordSection> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmationController = TextEditingController();
  bool _isLoading = false;

  void handleChangePassword() async {
    setState(() => _isLoading = true);

    try {
      await context.read<AuthenticationRepository>().updatePassword(
            _currentPasswordController.text,
            _newPasswordController.text,
          );
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _newPasswordConfirmationController.clear();
      const AppSnackBar(
        text: "Password changed",
        icon: Icons.check_rounded,
      ).show(context);
    } catch (e) {
      AppSnackBar(
        text: (e as dynamic).message,
        icon: Icons.close_rounded,
        color: Colors.red,
      ).show(context);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final providers = context.read<AuthenticationRepository>().providers;

    return providers.contains("password")
        ? SettingsGroup(
            title: "Change Password",
            children: [
              PasswordFormField(
                controller: _currentPasswordController,
                name: "Current Password (optional)",
                nullable: true,
                onChanged: (password) {
                  if (password != "") {
                    setState(() {});
                  }
                },
              ),
              PasswordFormField(
                controller: _newPasswordController,
                nullable: _currentPasswordController.text == "",
                name: "New Password",
              ),
              PasswordFormField(
                controller: _newPasswordConfirmationController,
                nullable: _currentPasswordController.text == "",
                name: "New Password Confirmation",
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return "Passwords don't match";
                  }

                  return null;
                },
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : handleChangePassword,
                  child: const Text("Change Password"),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
