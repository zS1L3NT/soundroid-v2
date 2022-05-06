import 'package:flutter/material.dart';

class DeleteDataCard extends StatelessWidget {
  const DeleteDataCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.music_off, color: Colors.red)],
              ),
              title: const Text("Clear Listening History"),
              subtitle: const Text("Clear all of your music listening history"),
              minVerticalPadding: 8,
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.search_off, color: Colors.red)],
              ),
              title: const Text("Clear Search History"),
              subtitle: const Text("Clear all of your search history"),
              minVerticalPadding: 8,
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.delete, color: Colors.red)],
              ),
              title: const Text(
                "Delete Account Data",
              ),
              subtitle: const Text(
                  "Deletes all of your data from SounDroid's servers, then logs you out of the App"),
              minVerticalPadding: 8,
            ),
          ),
          const Divider(height: 1),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.logout)],
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
