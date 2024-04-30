import 'package:flutter/material.dart';
import 'package:flutter_splash_login_signup/SETTINGS/settings.dart';
import 'package:flutter_splash_login_signup/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Important(),
    );
  }
}

class Important extends StatefulWidget {
  @override
  _ImportantPageState createState() => _ImportantPageState();
}

class _ImportantPageState extends State<Important> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 70,
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            gradient: LinearGradient(
                colors: [
                  mainColor,
                  gradientColor,
                  mainColor2,
                ]
            ),
          ),
        ),
        title: Text(
          'Guide for security',
          style: GoogleFonts.lato(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Image.asset("images/staysafe.jpeg",
                fit: BoxFit.fill,
              ),
            ),
            titlesection,
            contentsection,
            donttitle,
            dontcontent,
            dostitle,
            doscontent
          ],
        ),
      )

    );

  }
  Widget titlesection = Padding(
      padding: EdgeInsets.only(left: 25,right: 25,top: 20,bottom: 10),
    child: Text(
        "Maintain safety on the roads with these safe driving tips from Automophiles: Important Dos✔ and Don'ts⛔",
      style: GoogleFonts.robotoSlab(
        fontSize: 30,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center
    ),
  );

  Widget contentsection = Padding(
    padding: EdgeInsets.only(left: 50,right: 50,top:10, bottom: 10),
    child: Text("Car accidents are a common occurrence in the Philippines. "
      "Aside from the weather and traffic, actions such as bad overtaking, "
      "drunk driving, and improper turning also lead to road mishaps. "
      "While you can’t control the actions of other drivers, "
      "there are some things you can do and mustn’t do to ensure your safety and those who are driving with you.",
    style: GoogleFonts.lora(
      fontSize: 17,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300
    ),
      textAlign: TextAlign.justify,
    ),
  );

  Widget donttitle = Padding(
    padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 20),
    child: Text("What are things you should NOT do?",
    style: GoogleFonts.robotoSlab(
      fontSize: 25,
      fontWeight: FontWeight.bold
    ),
      textAlign: TextAlign.start,
    ),
  );

  Widget dontcontent = Padding(
      padding: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("1. Do not drink and drive",
        style: GoogleFonts.varelaRound(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 3,
        ),
        Text("Being under the influence of alcohol and dangerous drugs will affect your driving ability. "
            "Any amount of these substances in your system will slow down your coordination and reflexes and blur your vision. "
            "It’s also important to note that under RA No. 10586, anyone caught under the influence will face hefty fines and imprisonment.",
          style: GoogleFonts.varelaRound(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 15,
        ),
        Text("2. Do not exceed speed limit",
          style: GoogleFonts.varelaRound(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 3,
        ),
        Text("Going over the speed limit may get you to your destination faster or "
            "satisfy your adrenaline cravings. But remember, with each kilometer per hour over the speed limit, "
            "your chance to get into an accident increases. You are also putting other people in danger by going over it, "
            "including your passengers, other drivers, bicyclists, and pedestrians.",
          style: GoogleFonts.varelaRound(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Image.asset("images/dont1.jpg",
                height: 80,
                width: 160,
                fit: BoxFit.fill,
              ),
              ),

            Container(
              child: Image.asset("images/dont2.jpg",
                height: 80,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text("3. Do not engage in other activities while driving",
          style: GoogleFonts.varelaRound(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 3,
        ),
        Text("Driving requires your full attention on the road. Activities like eating, "
            "changing clothes, and putting on makeup while you’re behind the wheel are dangerous. "
            "Also, if there’s a high need for you to answer a call or send a text message while driving, "
            "pull over at a safe place first, use the phone, and then resume on your journey.",
          style: GoogleFonts.varelaRound(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 15,
        ),
        Text("4. Do not tailgate",
          style: GoogleFonts.varelaRound(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 3,
        ),
        Text("Driving too close to other vehicles, or tailgating as it is more commonly known, "
            "is extremely risky because you have little time to slow down if the driver in front of you hits the breaks. "
            "To keep a safer journey on the road, leave a 3-second distance between you and the car ahead of you.",
          style: GoogleFonts.varelaRound(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Image.asset("images/dont4.jpg",
                height: 80,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),

            Container(
              child: Image.asset("images/dont3.jpg",
                height: 80,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget dostitle = Padding(
    padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 30),
    child: Text("What are things you should do?🤔",
      style: GoogleFonts.robotoSlab(
          fontSize: 25,
          fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.start,
    ),
  );

  Widget doscontent = Padding(
    padding: EdgeInsets.only(left: 15,right: 15,bottom: 30,top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("1. Always wear your seat belt",
          style: GoogleFonts.varelaRound(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 3,
        ),
        Text("It’s against the law in the country to ride in a vehicle without wearing a "
            "seat belt because you are twice as likely to get fatal injuries. "
            "In a car crash, seat belts provide security to stop you from catapulting forward.",
          style: GoogleFonts.varelaRound(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 15,
        ),
        Text("2. Follow your vehicle’s maintenance schedule",
          style: GoogleFonts.varelaRound(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 3,
        ),
        Text("Making time for routine preventative car maintenance will ensure that "
            "your vehicle has properly inflated tires, all fluids are at their apt levels, "
            "and brakes are properly working. If your vehicle is in good condition, "
            "dangerous and unexpected breakdowns in the middle of your trip will be the least of your worries.",
          style: GoogleFonts.varelaRound(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Image.asset("images/dos1.jpg",
                height: 80,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),

            Container(
              child: Image.asset("images/dos2.jpg",
                height: 80,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text("3. Exercise caution in bad weather",
          style: GoogleFonts.varelaRound(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 3,
        ),
        Text("The best advice for driving in heavy rain is to avoid it. "
            "But if going out is inevitable or you’re caught in bad conditions once "
            "you’re already on the road, make sure that you turn on your windshield wipers and headlights. "
            "Also, try to drive in the middle lanes and avoid puddles of water because "
            "it can cause your car to hydroplane out of control.",
          style: GoogleFonts.varelaRound(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 15,
        ),
        Text("4. Insure your vehicle",
          style: GoogleFonts.varelaRound(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 3,
        ),
        Text("Preventing getting into a car accident isn’t just about avoiding "
            "injuries but also avoiding the emotional turmoil and the sky-high expenses "
            "that go along with it. Therefore, it is essential to complete all your safety measures "
            "by looking into a reliable, comprehensive car policy that can sufficiently protect you from financial liabilities.",
          style: GoogleFonts.varelaRound(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Image.asset("images/dos3.jpg",
                height: 80,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),

            Container(
              child: Image.asset("images/dos4.jpg",
                height: 80,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ],
    ),
  );


}
