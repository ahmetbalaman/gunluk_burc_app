import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import 'package:gunluk_burc_app/main.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfo extends StatelessWidget {
  const DeveloperInfo({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchEmail() async {
    // Email için özel URI oluşturma
    final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'ahmetbalaman073@gmail.com',
        queryParameters: {
          'subject': 'İletişim', // Varsayılan konu
          'body': '' // Varsayılan mesaj
        });

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Eğer email uygulaması bulunamazsa, kopyalama seçeneği sun
        await Clipboard.setData(
            const ClipboardData(text: 'ahmetbalaman073@gmail.com'));
        // Kopyalandı bildirimi göster
        if (navigatorKey.currentContext != null) {
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            const SnackBar(
              content: Text('Email adresi panoya kopyalandı'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Email açılırken hata oluştu: $e');
      // Email açılamazsa kopyalama seçeneği sun
      await Clipboard.setData(
          const ClipboardData(text: 'ahmetbalaman073@gmail.com'));
      // Kopyalandı bildirimi göster
      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text('Email adresi panoya kopyalandı'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return Scaffold(
          backgroundColor: isDark
              ? ThemeColors.darkAppBackground
              : ThemeColors.lightAppBackground,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Geliştirici Hakkında',
              style: TextStyle(
                color: isDark
                    ? ThemeColors.darkYaziColor
                    : ThemeColors.lightYaziColor,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: isDark
                    ? ThemeColors.darkYaziColor
                    : ThemeColors.lightYaziColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://c.superprof.com/i/m/12295046/300/20230226190522/12295046.webp"),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Ahmet Balaman',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? ThemeColors.darkYaziColor
                              : ThemeColors.lightYaziColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Mobile Application Developer & Teacher',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark
                              ? ThemeColors.darkYaziColor.withOpacity(0.8)
                              : ThemeColors.lightYaziColor.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Eğitmenlik Bölümü
                Card(
                  color: isDark
                      ? ThemeColors.darkContextBackground
                      : ThemeColors.lightContextBackground,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.school,
                              color: isDark
                                  ? ThemeColors.darkYaziColor
                                  : ThemeColors.lightYaziColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Eğitmenlik & Dersler',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? ThemeColors.darkYaziColor
                                    : ThemeColors.lightYaziColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildSkillChip('Swift', isDark),
                        _buildSkillChip('Flutter', isDark),
                        _buildSkillChip('.NET C#', isDark),
                        _buildSkillChip('C/C++', isDark),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // İletişim Kartları
                Card(
                  color: isDark
                      ? ThemeColors.darkContextBackground
                      : ThemeColors.lightContextBackground,
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(FontAwesomeIcons.linkedin,
                        color: Color(0xFF0A66C2)),
                    title: Text('LinkedIn',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        )),
                    subtitle: Text('ahmetbalaman',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        )),
                    onTap: () =>
                        _launchUrl('https://www.linkedin.com/in/ahmetbalaman/'),
                  ),
                ),
                const SizedBox(height: 8),

                Card(
                  color: isDark
                      ? ThemeColors.darkContextBackground
                      : ThemeColors.lightContextBackground,
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(FontAwesomeIcons.github,
                        color: Color(0xFF333333)),
                    title: Text('GitHub',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        )),
                    subtitle: Text('ahmetbalaman',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        )),
                    onTap: () => _launchUrl('https://github.com/ahmetbalaman'),
                  ),
                ),
                const SizedBox(height: 8),

                Card(
                  color: isDark
                      ? ThemeColors.darkContextBackground
                      : ThemeColors.lightContextBackground,
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(Icons.email, color: Color(0xFFEA4335)),
                    title: Text('Email',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        )),
                    subtitle: Text('ahmetbalaman073@gmail.com',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        )),
                    onTap: _launchEmail, // Yeni email metodunu kullan
                    onLongPress: () async {
                      // Uzun basılınca direkt kopyala
                      await Clipboard.setData(const ClipboardData(
                          text: 'ahmetbalaman073@gmail.com'));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email adresi panoya kopyalandı'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Uygulamalar Başlığı
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Uygulamalarım',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? ThemeColors.darkYaziColor
                          : ThemeColors.lightYaziColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _buildAppsList(isDark)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillChip(String label, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? ThemeColors.darkButtonArkaPlan.withOpacity(0.2)
            : ThemeColors.lightButtonArkaPlan.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? ThemeColors.darkButtonArkaPlan
              : ThemeColors.lightButtonArkaPlan,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color:
              isDark ? ThemeColors.darkYaziColor : ThemeColors.lightYaziColor,
        ),
      ),
    );
  }

  Widget _buildAppsList(bool isDark) {
    return Column(
      children: [
        _buildAppCard(
          'E-Ticaret Uygulaması',
          'İlk Flutter deneyimimde geliştirdiğim satış uygulaması. Kullanıcıların ürünleri listeleyip satın alabileceği bir e-ticaret platformu.',
          'assets/projects/flutter.png', // varsayılan bir icon
          isDark,
          'https://www.linkedin.com/posts/ahmetbalaman_flutter-mobiluygulama-eticaret-activity-7012097119670972416-anzD',
        ),
        _buildAppCard(
          'AK Temizlik',
          'Token tabanlı kimlik doğrulama sistemi ile geliştirilen, temizlik randevusu oluşturma ve yönetme uygulaması.',
          'assets/projects/aktemizlik.png',
          isDark,
          'https://www.linkedin.com/posts/ahmetbalaman_google-mutluluk-flutter-activity-7026423646596259840-Z_-B',
        ),
        _buildAppCard(
          'Burç Tabirim',
          'Günlük burç yorumları ve detaylı burç özelliklerini sunan, sesli okuma özelliğine sahip kapsamlı astroloji uygulaması.',
          'assets/projects/burc.png',
          isDark,
          'https://www.linkedin.com/posts/ahmetbalaman_g%C3%BCnl%C3%BCk-bur%C3%A7lar%C4%B1n%C4%B1-ve-bu-bur%C3%A7la-ilgili-%C3%B6zellikleri-activity-7022123376018141185-ipKN',
        ),
        _buildAppCard(
          'Rüya Tabiri',
          'Kullanıcıların rüyalarını yorumlayabildiği, kapsamlı bir rüya tabirleri veritabanına sahip uygulama.',
          'assets/projects/ruyatabiri.png',
          isDark,
          'https://www.linkedin.com/posts/ahmetbalaman_merhaba-de%C4%9Ferli-ba%C4%9Flant%C4%B1lar%C4%B1m-ge%C3%A7mi%C5%9Fte-activity-7114160848016699392-T2hr',
        ),
        _buildAppCard(
          'QRMedicine',
          'İlaç prospektüslerini QR kod ile dijitalleştiren, ilaç hatırlatması yapabilen yenilikçi sağlık uygulaması.',
          'assets/projects/qrmedicine.png',
          isDark,
          'https://www.linkedin.com/posts/ahmetbalaman_google-gdsc-qrmedicine-activity-7047883097568088064-OgTZ',
        ),
        _buildAppCard(
          'Özlenen Mirasın Peşinde',
          'Teknofest Turizm Teknolojileri yarışmasında En İyi Sunum ödülü alan, tarihi eserleri AR teknolojisi ile canlandıran proje.',
          'assets/projects/flutter.png',
          isDark,
          'https://www.linkedin.com/posts/ahmetbalaman_teknofest-turizmteknolojileri-activity-7065694479697014785-QKPT',
          isAwardWinning: true,
        ),
        _buildAppCard(
          'MarvelPedia',
          'Swift ile geliştirilen, Marvel API kullanarak karakterleri ve çizgi romanları listeleyen kapsamlı bir Marvel rehberi.',
          'assets/projects/marvelpedia.png',
          isDark,
          'https://www.linkedin.com/posts/ahmetbalaman_marvelpedia-marvel-aexizgiromanlar-activity-7094319042634629120-Wyi4',
        ),
      ],
    );
  }

  Widget _buildAppCard(
    String title,
    String description,
    String iconPath,
    bool isDark,
    String linkedinUrl, {
    bool isAwardWinning = false,
  }) {
    return Card(
      color: isDark
          ? ThemeColors.darkContextBackground
          : ThemeColors.lightContextBackground,
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Image.asset(
              iconPath,
              width: 48,
              height: 48,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.apps,
                  size: 48,
                  color: isDark
                      ? ThemeColors.darkYaziColor
                      : ThemeColors.lightYaziColor,
                );
              },
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? ThemeColors.darkYaziColor
                          : ThemeColors.lightYaziColor,
                    ),
                  ),
                ),
                if (isAwardWinning)
                  Icon(
                    Icons.emoji_events,
                    color: isDark
                        ? ThemeColors.darkButtonArkaPlan
                        : ThemeColors.lightButtonArkaPlan,
                  ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                description,
                style: TextStyle(
                  color: isDark
                      ? ThemeColors.darkYaziColor.withOpacity(0.8)
                      : ThemeColors.lightYaziColor.withOpacity(0.8),
                ),
              ),
            ),
            onTap: () => _launchUrl(linkedinUrl),
          ),
        ],
      ),
    );
  }
}
