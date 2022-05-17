import 'package:blooddonateapp/views/colors.dart';
import 'package:flutter/material.dart';

class AboutJune14Screen extends StatelessWidget {
  const AboutJune14Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themColor,
        title: const Text("About June 14"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/date.jpg'),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Image.asset('assets/images/blood-donation.jpg'),
                        const SizedBox(
                          height: 10,
                        ),
                      const  Text(
                            "•	Every year on June 14th countries around the world celebrate World Blood Donor Day (WBDD) as this date is allocated for as the world blood donor date. The event serves to raise awareness of the need for safe blood and blood products and to thank voluntary, unpaid blood donors for their life-saving gifts of blood."),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/blood_date.jpg',
                          height: 200,
                        ),
                    const    Text(
                            "•	A blood service that gives patients access to safe blood and blood products in sufficient quantity is a key component of an effective health system. The global theme of World Blood Donor Day changes each year in recognition of the selfless individuals who donate their blood for people unknown to them."),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/donation.png',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(" What is the aim of WBDD ?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                  "What is the aim o f WBDD ? The aim is to raise global awareness of the need for safe blood and blood products for transfusion and of the critical contribution voluntary, unpaid blood donors make to national health systems."),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
