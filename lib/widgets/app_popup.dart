import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

// This file contains various helper classes for building popups
//
// ### Rationale
// - Building popups in flutter requires a lot of code
// - Many dialogs look very similar, except the text in them

/// A helper class for building an Alert Dialog.
///
/// An Alert Dialog contains
/// - A title
/// - A description
/// - A button showing "Ok" to close the Dialog
class AppAlertDialog {
  const AppAlertDialog({
    required this.title,
    this.description,
    this.onClose,
  });

  /// The title of the dialog
  final String title;

  /// The description of the dialog
  final String? description;

  /// The function that is called when this Dialog is closed, if any
  final Function()? onClose;

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: description != null ? Text(description!) : null,
          actions: [
            ElevatedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    ).then((_) {
      if (onClose != null) {
        onClose!();
      }
    });
  }
}

class AppConfirmDialog {
  const AppConfirmDialog({
    required this.title,
    this.description,
    required this.confirmText,
    this.isDanger = false,
    this.onCancel,
    required this.onConfirm,
    this.onClose,
  });

  final String title;

  final String? description;

  final String confirmText;

  final bool isDanger;

  final Function()? onCancel;

  final Function() onConfirm;

  final Function()? onClose;

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: description != null ? Text(description!) : null,
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(
                "Cancel",
                style: isDanger ? const TextStyle(color: Colors.black) : null,
              ),
            ),
            ElevatedButton(
              onPressed: onConfirm,
              child: Text(confirmText),
              style: isDanger
                  ? ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                    )
                  : null,
            ),
          ],
        );
      },
    ).then((_) {
      if (onClose != null) {
        onClose!();
      }
    });
  }
}

class AppBottomSheet {
  const AppBottomSheet({
    required this.child,
  });

  final Widget child;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return child;
      },
    );
  }
}

class AppSelectOption {
  const AppSelectOption({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;

  final IconData icon;

  final Function() onPressed;
}

class AppSelectDialog {
  const AppSelectDialog({
    required this.title,
    required this.options,
    this.onClose,
  });

  final String title;

  final String? description = null;

  final List<AppSelectOption> options;

  final Function()? onClose;

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(title),
          children: options.map((option) {
            return SimpleDialogOption(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              onPressed: option.onPressed,
              child: Row(
                children: [
                  Icon(option.icon),
                  const SizedBox(width: 16),
                  Text(option.title),
                ],
              ),
            );
          }).toList(),
        );
      },
    ).then((_) {
      if (onClose != null) {
        onClose!();
      }
    });
  }
}

class AppTextDialog {
  const AppTextDialog({
    required this.title,
    required this.textFieldName,
    required this.confirmText,
    required this.onConfirm,
    this.onClose,
  });

  final String title;

  final String? description = null;

  final String textFieldName;

  final String confirmText;

  final Function(String) onConfirm;

  final Function()? onClose;

  void show(BuildContext context) {
    final controller = TextEditingController(text: initialText);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(title),
              content: TextField(
                controller: controller,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: textFieldName,
                ),
                autofocus: true,
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: controller.text.isNotEmpty ? () => onConfirm(controller.text) : null,
                  child: Text(confirmText),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      if (onClose != null) {
        onClose!();
      }
    });
  }
}

class AppSnackBar {
  const AppSnackBar({
    required this.text,
    required this.icon,
    this.color,
  });

  final String text;

  final IconData icon;

  final Color? color;

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            AppIcon.white(icon),
            const SizedBox(width: 16),
            Text(text),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
