part of 'update_profile_screen.dart';

class _UpdateProfileViewState extends State<_UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late int _selectedAvatar;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().state.user;
    _nameController = TextEditingController(text: user?.displayName ?? '');
    _phoneController = TextEditingController(text: AppPrefs.profilePhone);
    final avatarIndex = AppAssets.authAvatars.indexOf(user?.photoUrl ?? '');
    _selectedAvatar = avatarIndex < 0 ? 0 : avatarIndex;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _openAvatarPicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.transparentColor,
      builder: (_) => AvatarPickerSheet(
        avatars: AppAssets.authAvatars,
        selected: _selectedAvatar,
        onSelected: (index) {
          setState(() => _selectedAvatar = index);
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    await context.read<UpdateProfileCubit>().update(
      name: _nameController.text,
      phone: _phoneController.text,
      avatarPath: AppAssets.authAvatars[_selectedAvatar],
    );
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
        title: Text(l10n.authEditProfile, style: AppStyles.primary16),
        actions: const [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 12),
            child: LanguageSwitch(),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.isSuccess) {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.of(context).pop();
              messenger.showSnackBar(
                SnackBar(content: Text(l10n.authProfileUpdated)),
              );
            }
          },
          builder: (context, state) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _openAvatarPicker,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: AppColors.avatarBackground,
                      backgroundImage: AssetImage(
                        AppAssets.authAvatars[_selectedAvatar],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _openAvatarPicker,
                    child: Text(
                      l10n.authPickAvatar,
                      style: AppStyles.primary14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    hintText: l10n.authNameLabel,
                    hintStyle: AppStyles.white14,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: AppColors.whiteColor,
                    ),
                    style: AppStyles.white16,
                    filled: true,
                    fillColor: AppColors.darkFieldColor,
                    borderColor: AppColors.transparentColor,
                    validator: (value) {
                      final error = AuthValidators.validateName(value);
                      return error == null
                          ? null
                          : AuthMessages.nameError(l10n, error);
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    hintText: l10n.authPhoneLabel,
                    hintStyle: AppStyles.white14,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: AppColors.whiteColor,
                    ),
                    style: AppStyles.white16,
                    filled: true,
                    fillColor: AppColors.darkFieldColor,
                    borderColor: AppColors.transparentColor,
                    validator: (value) {
                      final error = AuthValidators.validatePhone(value);
                      return error == null
                          ? null
                          : AuthMessages.phoneError(l10n, error);
                    },
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.forgotPasswordRouteName),
                      child: Text(
                        l10n.authResetPassword,
                        style: AppStyles.white14,
                      ),
                    ),
                  ),
                  if (state.hasFailed)
                    AuthFormMessage(
                      text: AuthMessages.failure(l10n, state.failure!),
                    ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      backgroundColor: AppColors.redColor,
                      padding: 16,
                      onPressed: () => DeleteAccountDialog.show(context),
                      child: Text(
                        l10n.authDeleteAccount,
                        style: AppStyles.white16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      backgroundColor: AppColors.primaryColor,
                      padding: 16,
                      isLoading: state.isSubmitting,
                      onPressed: _submit,
                      child: Text(
                        l10n.authUpdateData,
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
