import 'package:flutter/material.dart';

class BookAppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Appointments"),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(
            tabs: [
              Tab(text: "Book Appointment"),
              Tab(text: "Scheduled Appointments"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Book Appointment Section
            BookAppointmentSection(),

            // Scheduled Appointments Section
            ScheduledAppointmentsSection(),
          ],
        ),
      ),
    );
  }
}

class BookAppointmentSection extends StatelessWidget {
  final Map<String, dynamic> doctorInfo = {
    'name': 'Dr Uday Bendale',
    'title': 'Anand Psychiatry Clinic',
    'address': 'Beside Renuka Medical, Opp J.D.C.C Bank Head office, Ring Rd, Jalgaon, Maharashtra 425001, India',
    'image': 'assets/doctor.jpg', // Image path in assets folder
    'city': 'Jalgaon',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures the card size is minimal
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor's Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                doctorInfo['image'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorInfo['name'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    doctorInfo['title'],
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    doctorInfo['address'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'City: ${doctorInfo['city']}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 16),
                  // Aligning the button to minimize space below
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Schedule Session Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScheduleSessionPage(),
                          ),
                        );
                      },
                      child: Text("Book Appointment"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 12.0),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
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




class ScheduledAppointmentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No appointments scheduled yet.",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class ScheduleSessionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Session"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          "Here you can schedule your session (to be implemented).",
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
