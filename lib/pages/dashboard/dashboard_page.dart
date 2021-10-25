import 'package:bank_sqlite_app_alura/pages/dashboard/components/card_contact_component.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Image.asset('assets/bytebank_logo.png', fit: BoxFit.fill),
            ),
            const Spacer(),
            Expanded(
              flex: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CardContactComponent(
                    icon: Icons.people,
                    text: "Contatos",
                    margin: const EdgeInsets.only(right: 10),
                    onTap: () => Navigator.of(context).pushNamed("/contacts"),
                  ),
                  CardContactComponent(
                    icon: Icons.people,
                    text: "Contatos",
                    margin: const EdgeInsets.only(right: 10),
                    onTap: () {},
                  ),
                  CardContactComponent(
                    icon: Icons.people,
                    text: "Contatos",
                    margin: const EdgeInsets.only(right: 10),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}