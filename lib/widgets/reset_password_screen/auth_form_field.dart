import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A custom text form field with extented options for decorations.
///
/// For password fields, the visibility is automatically handled by the widget
/// If you want to control it manually, set `handleVisibilityManually` to `true` and
/// provide a `onVisibilityChanged` callback to update state manually
class AuthFormField extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final bool isPasswordField;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onVisibilityChanged;
  final bool handleVisibilityManually;
  final String? errorText;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool disable;
  final bool obsecureText;

  const AuthFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPasswordField = false,
    this.obsecureText = false,
    this.disable = false,
    this.handleVisibilityManually = false,
    this.controller,
    this.maxLength,
    this.validator,
    this.padding,
    this.errorText,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.onVisibilityChanged,
  }) : assert(
         !handleVisibilityManually || onVisibilityChanged != null,
         'No onVisibilityChanged method provided when handleVisibilityManually is set to true',
       );

  @override
  State<AuthFormField> createState() => AuthFormFieldState();
}

class AuthFormFieldState extends State<AuthFormField> {
  late bool _isHidden;

  @override
  void initState() {
    super.initState();
    _isHidden = widget.isPasswordField && widget.obsecureText;
  }

  @override
  void didUpdateWidget(covariant AuthFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obsecureText != widget.obsecureText) {
      setState(() => _isHidden = widget.obsecureText);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffix;
    if (widget.isPasswordField) {
      suffix = IconButton(
        onPressed: () {
          if (widget.onVisibilityChanged != null) {
            widget.onVisibilityChanged?.call(!_isHidden);
          } else if (!widget.handleVisibilityManually) {
            setState(() => _isHidden = !_isHidden);
          }
        },
        icon: _isHidden
            ? const Icon(Icons.visibility_off, color: Colors.green)
            : const Icon(Icons.visibility, color: Colors.red),
      );
    }
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: TextFormField(
        focusNode: widget.focusNode,
        enabled: !widget.disable,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _isHidden,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          label: widget.icon,
          suffixIcon: suffix,
          errorText: widget.errorText,
          counterText: '',
          hint: Text(
            widget.hintText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
