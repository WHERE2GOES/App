import 'package:core/domain/user/model/terms_type.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginTermsAgreementScreen extends StatefulWidget {
  const LoginTermsAgreementScreen({
    super.key,
    required this.onTermsClicked,
    required this.onAgreeClicked,
  });

  final void Function(TermsType termsType) onTermsClicked;
  final VoidCallback onAgreeClicked;

  @override
  State<LoginTermsAgreementScreen> createState() =>
      _LoginTermsAgreementScreenState();
}

class _LoginTermsAgreementScreenState extends State<LoginTermsAgreementScreen> {
  final _terms = [TermsType.termsOfService, TermsType.privacyPolicy];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.pastelYellow,
      child: Container(
        alignment: Alignment.center,
        color: ThemeColors.grey800.withValues(alpha: 0.4),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: ThemeColors.sparseOrange,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            spacing: 40,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "약관 동의",
                style: TextStyle(
                  color: ThemeColors.grey800,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final terms = _terms[index];

                  return GestureDetector(
                    onTap: () => widget.onTermsClicked(_terms[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeColors.pastelGreen,
                        border: Border.all(
                          color: ThemeColors.grey800,
                          width: 0.6,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              "assets/images/ic_human_circle.svg",
                              package: "login",
                              width: 34.95,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              switch (terms) {
                                TermsType.termsOfService => "서비스 이용약관",
                                TermsType.privacyPolicy => "제3자 정보제공 동의",
                                TermsType.marketingAgreement =>
                                  "마케팅 이용 및 수신 동의",
                              },
                              style: TextStyle(
                                color: ThemeColors.grey800,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 9.42);
                },
                itemCount: _terms.length,
              ),
              GestureDetector(
                onTap: widget.onAgreeClicked,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeColors.grey800,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "동의하고 진행하기",
                    style: TextStyle(
                      color: ThemeColors.pastelYellow,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
