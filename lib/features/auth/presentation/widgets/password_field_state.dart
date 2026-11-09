part of 'password_field.dart';

class _PasswordFieldState extends State<PasswordField> {
  bool _obscured = true;

  void _toggleVisibility() => setState(() => _obscured = !_obscured);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomTextField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscured,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      autofocus: widget.autofocus,
      hintText: widget.hint,
      labelText: widget.label,
      prefixIcon: const Icon(Icons.lock, color: AuthFieldDefaults.iconColor),
      suffixIcon: IconButton(
        tooltip: _obscured ? l10n.authShowPassword : l10n.authHidePassword,
        onPressed: _toggleVisibility,
        icon: Icon(
          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AuthFieldDefaults.iconColor,
        ),
      ),
      style: AuthFieldDefaults.textStyle,
      hintStyle: AuthFieldDefaults.hintStyle,
      labelStyle: AuthFieldDefaults.labelStyle,
      filled: true,
      fillColor: AuthFieldDefaults.fillColor,
      borderColor: AuthFieldDefaults.borderColor,
      cursorColor: AppColors.primaryColor,
    );
  }
}
