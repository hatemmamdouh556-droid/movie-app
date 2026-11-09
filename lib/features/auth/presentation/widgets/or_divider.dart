part of 'auth_footer_text.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final line = SizedBox(
      width: width * 0.214,
      child: Divider(color: AppColors.primaryColor, thickness: 1),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        line,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.026),
          child: Text('OR', style: AppStyles.primary15),
        ),
        line,
      ],
    );
  }
}
