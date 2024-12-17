import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_flutter_app/profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Keeps track of the current tab index

  // List of pages to switch between
  final List<Widget> _pages = [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Map Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Notifications Page', style: TextStyle(fontSize: 24))),
    ProfilePage()
  ];

  // Titles corresponding to each page
  final List<String> _pageTitles = [
    "Home",
    "Map",
    "Notifications",
    "Profile",
  ];

  void _showAddTaskBottomSheet(BuildContext context) {
    TextEditingController _dateController = TextEditingController();
    TextEditingController _taskNameController = TextEditingController();
    TextEditingController _newListController = TextEditingController();

    // Predefined list of task categories
    List<String> taskLists = ["Study", "Personal", "Shopping", "+ Add New List"];
    String? selectedList = "Study"; // Default selected list

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // For full-height bottom sheet
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row with "Add new task" text and button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add New Task",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle button press
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text("Add"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Task List Dropdown
                  Text(
                    "Task Category",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedList,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.list_rounded),
                    ),
                    items: taskLists.map((String list) {
                      return DropdownMenuItem<String>(
                        value: list,
                        child: Text(list),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setModalState(() {
                        selectedList = value;

                        // If "Add New List" is selected, clear the input field
                        if (selectedList == "+ Add New List") {
                          _newListController.text = "";
                        }
                      });
                    },
                  ),
                  SizedBox(height: 16),

                  // Add New List Input (conditionally shown)
                  if (selectedList == "+ Add New List")
                    TextField(
                      controller: _newListController,
                      decoration: InputDecoration(
                        labelText: "New List Name",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.playlist_add_rounded),
                      ),
                      onSubmitted: (newListName) {
                        if (newListName.trim().isNotEmpty) {
                          setModalState(() {
                            // Add new list to the dropdown and select it
                            taskLists.insert(taskLists.length - 1, newListName);
                            selectedList = newListName;
                          });
                        }
                      },
                    ),

                  SizedBox(height: 16),

                  // Task Name Input Field
                  TextField(
                    controller: _taskNameController,
                    decoration: InputDecoration(
                      labelText: "Task Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.task_alt_rounded),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Task Details Input Field
                  TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: "Notes",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.speaker_notes_rounded),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Location Input Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Location",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.pin_drop_rounded),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Date and Time Picker
                  TextField(
                    controller: _dateController, // Use the controller to show the selected date
                    readOnly: true, // Make the field non-editable
                    onTap: () async {
                      // Pick date
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), // Default to current date
                        firstDate: DateTime(2000), // Earliest date selectable
                        lastDate: DateTime(2100), // Latest date selectable
                      );

                      if (pickedDate != null) {
                        // Pick time after date is selected
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(), // Default to current time
                        );

                        if (pickedTime != null) {
                          // Format the selected date and time as needed
                          String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          String formattedTime = "${pickedTime.hour}:${pickedTime.minute < 10 ? '0${pickedTime.minute}' : pickedTime.minute}";

                          // Combine date and time
                          String formattedDateTime = "$formattedDate $formattedTime";

                          setState(() {
                            _dateController.text = formattedDateTime; // Update the controller with date and time
                          });
                        }
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Date and Time",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today_rounded), // Add calendar icon
                    ),
                  ),
                  SizedBox(height: 16),

                  // Tags Input
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Tags (use # for hashtags)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.tag_rounded),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with dynamic title
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // Center the content horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          // Align vertically centered
          children: [
            // Logo Image
            Image.asset(
              'assets/target.png',
              height: 40, // Adjust size of the logo
            ),
            SizedBox(width: 8), // Space between the logo and the text
            // Tasko Text
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Tasko',
                style: TextStyle(
                  fontSize: 26, // Larger font size
                  fontWeight: FontWeight.bold, // Bold font for emphasis
                  color: Colors.white, // White text for contrast
                  letterSpacing: 1.2,
                  // Space between letters
                ),
              ),
            ),
          ],
        ),
        elevation: 2,
        toolbarHeight: 80, // Height of the AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade800
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex, // Only the selected page is visible
        children: _pages,
      ),
      // Conditional Floating Action Button (FAB)
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () => _showAddTaskBottomSheet(context),
              // Icon inside the FAB
              foregroundColor: Colors.white,
              // Add your desired FAB icon here
              backgroundColor: Colors.grey.shade800,
              shape: RoundedRectangleBorder(
                // Ensures a fully rounded shape
                borderRadius:
                    BorderRadius.circular(100), // High value for full roundness
              ),
              child: Icon(Icons.add),
            )
          : null,
      // FAB is null on other pages

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // Position FAB at bottom-right

      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
              color: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              padding: EdgeInsets.all(16),
              selectedIndex: _selectedIndex,
              // Highlight the selected tab
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index; // Update the selected index
                });
              },
              tabs: const [
                GButton(icon: Icons.home_rounded, text: "Home"),
                GButton(icon: Icons.map, text: "Map"),
                GButton(
                    icon: Icons.notifications_rounded, text: "Notifications"),
                GButton(icon: Icons.person_2_rounded, text: "Me"),
              ]),
        ),
      ),
    );
  }
}
