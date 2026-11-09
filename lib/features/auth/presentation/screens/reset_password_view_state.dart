part of 'reset_password_screen.dart';

class _ResetPasswordViewState extends State<_ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    await context.read<ForgotPasswordCubit>().submit(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(l10n.authForgotPasswordTitle, style: AppStyles.primary16),
      ),
      body: SafeArea(
        child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
          builder: (context, state) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    kForgetPasswordImage,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.45,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.authForgotPasswordBody,
                    textAlign: TextAlign.center,
                    style: AppStyles.white14,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    onChange: (_) =>
                        context.read<ForgotPasswordCubit>().clearResult(),
                    hintText: l10n.authEmailLabel,
                    hintStyle: AppStyles.white14,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: AppColors.whiteColor,
                    ),
                    style: AppStyles.white16,
                    filled: true,
                    fillColor: AppColors.darkFieldColor,
                    borderColor: AppColors.transparentColor,
                    validator: (value) {
                      final error = AuthValidators.validateEmail(value);
                      return error == null
                          ? null
                          : AuthMessages.emailError(l10n, error);
                    },
                  ),
                  const SizedBox(height: 16),
                  if (state.hasFailed)
                    AuthFormMessage(
                      text: AuthMessages.failure(l10n, state.failure!),
                    ),
                  if (state.isSuccess)
                    AuthFormMessage(
                      text: l10n.authResetLinkSent,
                      isError: false,
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      backgroundColor: AppColors.primaryColor,
                      padding: 16,
                      isLoading: state.isSubmitting,
                      onPressed: _submit,
                      child: Text(
                        l10n.authSendResetLink,
                        style: AppStyles.black16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
