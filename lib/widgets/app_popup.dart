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

  /// The function that is called when this dialog is closed, if any
  final Function()? onClose;

  /// Shows the Alert Dialog
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

/// A helper class for building a Confirm Dialog
///
/// A Confirm Dialog contains
/// - A title
/// - A description
/// - A cancel button to close the dialog
/// - An action button to confirm the action
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

  /// The title of the dialog
  final String title;

  /// The description of the dialog
  final String? description;

  /// The text shown on the confirm button
  final String confirmText;

  /// Whether the confirm button should be colored red
  final bool isDanger;

  /// The function that is called when the cancel button is pressed, if any
  final Function()? onCancel;

  /// The function that is called when the confirm button is pressed
  final Function() onConfirm;

  /// The function that is called when this dialog is closed, if any
  final Function()? onClose;

  /// Shows the Confirm Dialog
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

/// A helper class for building a Bottom Sheet
///
/// A Bottom Sheet is just a popup from the bottom of the screen
/// on top of the current screen
class AppBottomSheet {
  const AppBottomSheet({
    required this.child,
  });

  /// The widget to render as the Bottom Sheet
  final Widget child;

  /// Shows the Bottom Sheet
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return child;
      },
    );
  }
}

/// A helper class for building a Select Dialog
///
/// This is a class that defines an option in an [AppSelectDialog]
class AppSelectOption {
  const AppSelectOption({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  /// The title of the option
  final String title;

  /// The icon of the option
  final IconData icon;

  /// The function that is called when the option is pressed
  final Function() onPressed;
}

/// A helper class for building a Select Dialog
///
/// A Select Dialog contains
/// - A title
/// - A list of options to choose from
class AppSelectDialog {
  const AppSelectDialog({
    required this.title,
    required this.options,
    this.onClose,
  });

  /// The title of the dialog
  final String title;

  /// The options of the dialog
  ///
  /// This is a list of [AppSelectOption]
  final List<AppSelectOption> options;

  /// The function that is called when this dialog is closed, if any
  final Function()? onClose;

  /// Shows the Select Dialog
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

/// A helper class for building a Text Dialog
///
/// A Text Dialog contains
/// - A title
/// - A description
/// - A text field to enter text
/// - A cancel button to close the dialog
/// - An action button to confirm the text
class AppTextDialog {
  const AppTextDialog({
    required this.title,
    required this.textFieldName,
    this.initialText,
    required this.confirmText,
    this.onClose,
    required this.onConfirm,
  });

  /// The title of the dialog
  final String title;

  /// The name of the text field
  ///
  /// This would be the legend of the text field
  final String textFieldName;

  /// The text shown initially in the dialog
  final String? initialText;

  /// The text shown on the confirm button
  final String confirmText;

  /// The function that is called when this dialog is closed, if any
  final Function()? onClose;

  /// The function that is called when the confirm button is pressed
  final Function(String) onConfirm;

  /// Shows the Text Dialog
  void show(BuildContext context) {
    final controller = TextEditingController(text: initialText);

    showDialog(
      context: context,
      builder: (context) {
        // This is needed to rebuild the widget when the text changes
        // so that the confirm button is only enabled when the text is not empty
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(title),
              content: TextField(
                controller: controller,
                // Rerender widget every time the text changes
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

/// A helper class for building a SnackBar
///
/// A SnackBar contains
/// - An icon
/// - A line of text
class AppSnackBar {
  const AppSnackBar({
    required this.text,
    required this.icon,
    this.color,
    this.duration,
  });

  /// The text to show in the snackbar
  final String text;

  /// The icon to show in the snackbar
  final IconData icon;

  /// The background color of the snackbar
  final Color? color;

  /// The duration to show the snackbar for
  final Duration? duration;

  /// Shows the SnackBar
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            AppIcon.white(icon),
            const SizedBox(width: 16),
            AppText.marquee(
              text,
              width: MediaQuery.of(context).size.width - 102,
              extraHeight: 3,
              startAfter: const Duration(seconds: 1),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color ?? Theme.of(context).primaryColor,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }
}
