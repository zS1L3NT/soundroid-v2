import 'package:flutter/material.dart';

class DeleteDataCard extends StatelessWidget {
  const DeleteDataCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text(
                    "Your music listening history will be cleared",
                  ),
                  content: const Text(
                    "Are you sure you want to clear your music listening history? SounDroid's song recommendations will not work as well after this.",
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Clear"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.music_off_rounded, color: Colors.red)],
              ),
              title: const Text("Clear Listening History"),
              subtitle: const Text("Clear all of your music listening history"),
              minVerticalPadding: 8,
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text(
                    "Your search history will be cleared",
                  ),
                  content: const Text(
                    "Are you sure you want to clear your music listening history?",
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Clear"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.search_off_rounded, color: Colors.red)],
              ),
              title: const Text("Clear Search History"),
              subtitle: const Text("Clear all of your search history"),
              minVerticalPadding: 8,
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text(
                    "Your account data will be deleted",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: const Text(
                    "Are you sure you want to delete all your account data? This action is irreversable!",
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed("/auth");
                      },
                      child: const Text("Delete Data"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.delete_rounded, color: Colors.red)],
              ),
              title: const Text(
                "Delete Account Data",
              ),
              subtitle: const Text(
                "Deletes all of your data from SounDroid's servers, then logs you out of the App",
              ),
              minVerticalPadding: 8,
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text("You will be logged out"),
                  content: const Text(
                    'Are you sure you want to log out of SounDroid? Any music playing will be stopped.',
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed("/auth");
                      },
                      child: const Text("Logout"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.logout_rounded)],
              ),
              title: const Text(
                "Logout",
              ),
              subtitle: const Text("Logout of SounDroid"),
              minVerticalPadding: 8,
            ),
          ),
        ],
      ),
    );
  }
}
