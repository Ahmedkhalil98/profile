import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final Uri _urllinkedin =
      Uri.parse('https://www.linkedin.com/in/ahmed-khalil-4a5156239/');
  final Uri _urlfacebook = Uri.parse('https://www.facebook.com');
  final Uri _urlinstagram = Uri.parse('https://www.instagram.com/?hl=en');
  final Uri _urlwebsite = Uri.parse('https://flutter.dev');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(90),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 10.0,
                    backgroundImage: NetworkImage(
                        "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text(
                    "FULL NAME",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff404040),
                    ),
                  )),
              const SizedBox(height: 10),
              Container(
                width: 250,
                child: Text(
                  textAlign: TextAlign.center,
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              profileButton("LinkedIn Profile", FeatherIcons.linkedin,
                  Colors.grey, _urllinkedin),
              profileButton("Facebook Profile", Icons.facebook, Colors.blue,
                  _urlfacebook),
              profileButton("Instagram Profile", FeatherIcons.instagram,
                  Colors.pink, _urlinstagram),
              profileButton("My Website", FeatherIcons.chrome, Colors.orange,
                  _urlwebsite),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  callbutton(Colors.green, Icons.whatsapp),
                  callbutton(Colors.blue, Icons.email),
                  callbutton(Colors.red, Icons.message),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileButton(String title, IconData iconData, Color color, Uri url) {
    return InkWell(
      onTap: () {
        launchUrl(url);
      },
      child: Container(
        height: 50,
        width: 310,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Icon(
              iconData,
              size: 35,
            )),
            Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget callbutton(Color color, IconData iconData) {
    return Expanded(
      child: Stack(children: [
        Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              iconData,
              size: 35,
            ),
          ),
        ),
      ]),
    );
  }
}
