part of 'delete_account_dialog.dart';

class _DeleteAccountDialogViewState extends State<_DeleteAccountDialogView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await context.read<DeleteAccountCubit>().confirmDeletion(
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (!state.isSuccess) return;
        // The session ends with the account: the gate closes every pushed route
        // (including this dialog) and shows the login screen again.
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.authDeleteAccountSuccess)));
      },
      builder: (context, state) => AlertDialog(
        backgroundColor: AppColors.darkFieldColor,
        title: Text(l10n.authDeleteAccount, style: AppStyles.bold20White),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.authDeleteAccountConfirmBody,
                style: AppStyles.bold14White.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16),
              PasswordField(
                controller: _passwordController,
                label: l10n.authPasswordLabel,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _confirm(),
                validator: (value) => (value ?? '').isEmpty
                    ? l10n.authErrorPasswordRequired
                    : null,
              ),
              if (state.hasFailed)
                AuthFormMessage(
                  text: AuthMessages.failure(l10n, state.failure!),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: state.isSubmitting
                ? null
                : () => Navigator.of(context).pop(),
            child: Text(l10n.authCancel, style: AuthFieldDefaults.hintStyle),
          ),
          CustomElevatedButton(
            backgroundColor: AppColors.redColor,
            onPressed: _confirm,
            isLoading: state.isSubmitting,
            padding: 8,
            progressIndicatorColor: AppColors.whiteColor,
            child: Text(
              l10n.authDeleteAccountConfirmButton,
              style: AppStyles.bold16White,
            ),
          ),
        ],
      ),
    );
  }
}
