import 'package:core/domain/user/model/terms_type.dart';
import 'package:design/util/navigation_bar_handler.dart';
import 'package:flutter/material.dart';
import 'package:mypage/screens/my_page_screen.dart';
import 'package:mypage/screens/my_page_terms_view_screen.dart';
import 'package:mypage/vms/my_page_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPageApp extends StatefulWidget {
  const MyPageApp({
    super.key,
    required this.vm,
    required this.onLogout,
    required this.onBack,
  });

  final MyPageViewModel vm;
  final VoidCallback onLogout;
  final VoidCallback onBack;

  @override
  State<MyPageApp> createState() => _MyPageAppState();
}

class _MyPageAppState extends State<MyPageApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    widget.vm.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return BackButtonListener(
              onBackButtonPressed: () async {
                _back();
                return true;
              },
              child: ListenableBuilder(
                listenable: widget.vm,
                builder: (context, child) {
                  return switch (settings.name) {
                    '/' => _buildMyPageScreen(),
                    '/terms' => _buildTermsViewScreen(
                      termsType: settings.arguments as TermsType,
                    ),
                    _ => throw Exception("Invalid route"),
                  };
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMyPageScreen() {
    return MyPageScreen(
      profileImage: widget.vm.user?.profileImage,
      nickname: widget.vm.user?.nickname,
      onMyRewardsButtonClicked: () {
        /* TODO */
      },
      onEditProfileButtonClicked: () {
        /* TODO */
      },
      onInquiryButtonClicked: _onInquiryButtonClicked,
      onTermsOfServiceButtonClicked: () {
        _onTermsButtonClicked(termsType: TermsType.termsOfService);
      },
      onPrivacyPolicyButtonClicked: () {
        _onTermsButtonClicked(termsType: TermsType.privacyPolicy);
      },
      onMarketingPolicyButtonClicked: () {
        _onTermsButtonClicked(termsType: TermsType.marketingAgreement);
      },
      onLogoutButtonClicked: () async {
        await widget.vm.logout();
        widget.onLogout();
      },
    );
  }

  Widget _buildTermsViewScreen({required TermsType termsType}) {
    return MyPageTermsViewScreen(html: widget.vm.termsHtml[termsType]);
  }

  void _back() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
      NavigationBarHandler.visibility.show();
    } else {
      widget.onBack();
    }
  }

  void _onInquiryButtonClicked() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'eodilo28@gmail.com', // 1. 수신자 이메일 주소
      query: _encodeQueryParameters(<String, String>{
        'subject': '안녕하세요! 어디로 서비스 문의드립니다.', // 2. 이메일 제목
        'body': '문의 내용: ', // 3. 이메일 본문
      }),
    );

    await launchUrl(emailLaunchUri);
  }

  void _onTermsButtonClicked({required TermsType termsType}) {
    NavigationBarHandler.visibility.value = false;
    widget.vm.loadTermsHtml(termsType: termsType);
    _navigatorKey.currentState?.pushNamed("/terms", arguments: termsType);
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }
}
