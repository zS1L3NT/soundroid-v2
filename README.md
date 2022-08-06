# SounDroid v2

![License](https://img.shields.io/github/license/zS1L3NT/dart-flutter-souondroid?style=for-the-badge) ![Languages](https://img.shields.io/github/languages/count/zS1L3NT/dart-flutter-souondroid?style=for-the-badge) ![Top Language](https://img.shields.io/github/languages/top/zS1L3NT/dart-flutter-souondroid?style=for-the-badge) ![Commit Activity](https://img.shields.io/github/commit-activity/y/zS1L3NT/dart-flutter-souondroid?style=for-the-badge) ![Last commit](https://img.shields.io/github/last-commit/zS1L3NT/dart-flutter-souondroid?style=for-the-badge)

SounDroid v2 is a rebuild of the original SounDroid v1 [here](https://github.com/zS1L3NT/andorid-soundroid-v1).<br>
The backend for SounDroid v2 is [here](https://github.com/zS1L3NT/web-express-soundroid).<br>

View the video demonstration of the application [here](https://youtu.be/74Z8wLyDtRU).

## Motivation

I need a deliverable for my MBAP (Mobile Application Development) submission and I wanted to rebuild my original SounDroid v1 application.

## Features

-   Music Playing
    -   Lyrics fetching (timed/non-timed)
    -   Music Controls
        -   Play & Pause
        -   Skip Forward & Backward
        -   Seek bar
        -   Volume control
        -   Repeat & Shuffle
        -   **Auto Pause when Offline**
    -   Queue Management
        -   Loop Off, Single and Queue
        -   Shuffle Off and On
        -   Add to Queue
        -   Reorder Queue
        -   Swipe to remove from Queue
    -   Floating Action Button
        -   Current Song's Thumbnail
        -   Playing Progress
    -   Music Session & Notification
        -   Play & Pause
        -   Skip Forward & Backward
        -   Seek bar
-   Playlists
    -   Modifying
        -   Title
        -   Cover (Gallery, Camera)
        -   Playlist Songs (Add, Remove, Reorder)
        -   Delete
    -   Downloading
        -   **Auto Pause when Offline**
    -   Playlist for Liked Songs
-   API Interactions
    -   Searching (Song, Album)
        -   Autocomplete
        -   Recent searches
        -   _Uses YouTube Music Scraper_
    -   Song Recommendations
        -   _Uses Spotify API_
        -   _Reads user's listening history_
-   Accounts & Authentication
    -   Login with Google or Email
    -   Register with Google or Email
    -   Forgot Password with backlinking
    -   Email Verification with backlinking
    -   Update user information
    -   Connect/Disconnect from Google
    -   Delete user data
        -   Listening History
        -   Search History
        -   All Data

## Usage

```
$ flutter pub get
$ flutter run
```

## Built with

-   Flutter
    -   Flutter SDK
        -   [![build_runner](https://img.shields.io/badge/build_runner-%5E2.1.11-blue?style=flat-square)](https://pub.dev/packages/build_runner)
        -   [![flutter](https://img.shields.io/badge/flutter-sdk-blue?style=flat-square)](https://flutter.dev/)
        -   [![flutter_lints](https://img.shields.io/badge/flutter_lints-%5E1.0.0-blue?style=flat-square)](https://pub.dev/packages/flutter_lints)
        -   [![provider](https://img.shields.io/badge/provider-%5E6.0.2-blue?style=flat-square)](https://pub.dev/packages/provider)
    -   Audio
        -   [![audio_session](https://img.shields.io/badge/audio_session-%5E0.1.7-blue?style=flat-square)](https://pub.dev/packages/audio_session)
        -   [![just_audio](https://img.shields.io/badge/just_audio-%5E0.9.24-blue?style=flat-square)](https://pub.dev/packages/just_audio)
        -   [![just_audio_background](https://img.shields.io/badge/just_audio_background-%5E0.0.1--beta.5-blue?style=flat-square)](https://pub.dev/packages/just_audio_background)
        -   [![perfect_volume_control](https://img.shields.io/badge/perfect_volume_control-%5E1.0.5-blue?style=flat-square)](https://pub.dev/packages/perfect_volume_control)
    -   Firebase
        -   [![cloud_firestore](https://img.shields.io/badge/cloud_firestore-%5E3.1.17-blue?style=flat-square)](https://pub.dev/packages/cloud_firestore)
        -   [![firebase_auth](https://img.shields.io/badge/firebase_auth-%5E3.4.0-blue?style=flat-square)](https://pub.dev/packages/firebase_auth)
        -   [![firebase_core](https://img.shields.io/badge/firebase_core-%5E1.15.0-blue?style=flat-square)](https://pub.dev/packages/firebase_core)
        -   [![firebase_storage](https://img.shields.io/badge/firebase_storage-%5E10.2.18-blue?style=flat-square)](https://pub.dev/packages/firebase_storage)
        -   [![google_sign_in](https://img.shields.io/badge/google_sign_in-%5E5.3.3-blue?style=flat-square)](https://pub.dev/packages/google_sign_in)
    -   API
        -   [![cached_network_image](https://img.shields.io/badge/cached_network_image-%5E3.2.0-blue?style=flat-square)](https://pub.dev/packages/cached_network_image)
        -   [![connectivity_plus](https://img.shields.io/badge/connectivity_plus-%5E2.3.5-blue?style=flat-square)](https://pub.dev/packages/connectivity_plus)
        -   [![hive](https://img.shields.io/badge/hive-%5E2.2.1-blue?style=flat-square)](https://pub.dev/packages/hive)
        -   [![hive_flutter](https://img.shields.io/badge/hive_flutter-%5E1.1.0-blue?style=flat-square)](https://pub.dev/packages/hive_flutter)
        -   [![hive_generator](https://img.shields.io/badge/hive_generator-%5E1.1.3-blue?style=flat-square)](https://pub.dev/packages/hive_generator)
        -   [![http](https://img.shields.io/badge/http-%5E0.13.4-blue?style=flat-square)](https://pub.dev/packages/http)
        -   [![json_annotation](https://img.shields.io/badge/json_annotation-%5E4.5.0-blue?style=flat-square)](https://pub.dev/packages/json_annotation)
        -   [![json_serializable](https://img.shields.io/badge/json_serializable-%5E6.2.0-blue?style=flat-square)](https://pub.dev/packages/json_serializable)
        -   [![palette_generator](https://img.shields.io/badge/palette_generator-%5E0.3.3-blue?style=flat-square)](https://pub.dev/packages/palette_generator)
        -   [![shimmer](https://img.shields.io/badge/shimmer-%5E2.0.0-blue?style=flat-square)](https://pub.dev/packages/shimmer)
    -   Miscellaneous
        -   [![auto_size_text](https://img.shields.io/badge/auto_size_text-%5E3.0.0-blue?style=flat-square)](https://pub.dev/packages/auto_size_text)
        -   [![awesome_notifications](https://img.shields.io/badge/awesome_notifications-%5E0.6.21-blue?style=flat-square)](https://pub.dev/packages/awesome_notifications)
        -   [![copy_with_extension](https://img.shields.io/badge/copy_with_extension-%5E4.0.0-blue?style=flat-square)](https://pub.dev/packages/copy_with_extension)
        -   [![copy_with_extension_gen](https://img.shields.io/badge/copy_with_extension_gen-%5E4.0.0-blue?style=flat-square)](https://pub.dev/packages/copy_with_extension_gen)
        -   [![diffutil_dart](https://img.shields.io/badge/diffutil_dart-%5E3.0.0-blue?style=flat-square)](https://pub.dev/packages/diffutil_dart)
        -   [![equatable](https://img.shields.io/badge/equatable-%5E2.0.3-blue?style=flat-square)](https://pub.dev/packages/equatable)
        -   [![flutter_launcher_icons](https://img.shields.io/badge/flutter_launcher_icons-%5E0.9.2-blue?style=flat-square)](https://pub.dev/packages/flutter_launcher_icons)
        -   [![flutter_native_splash](https://img.shields.io/badge/flutter_native_splash-%5E2.1.6-blue?style=flat-square)](https://pub.dev/packages/flutter_native_splash)
        -   [![flutter_settings_screens](https://img.shields.io/badge/flutter_settings_screens-%5E0.3.2--null--safety-blue?style=flat-square)](https://pub.dev/packages/flutter_settings_screens)
        -   [![great_list_view](https://img.shields.io/badge/great_list_view-%5E0.1.4-blue?style=flat-square)](https://pub.dev/packages/great_list_view)
        -   [![image_cropper](https://img.shields.io/badge/image_cropper-%5E2.0.3-blue?style=flat-square)](https://pub.dev/packages/image_cropper)
        -   [![image_picker](https://img.shields.io/badge/image_picker-%5E0.8.5%2B3-blue?style=flat-square)](https://pub.dev/packages/image_picker)
        -   [![marquee](https://img.shields.io/badge/marquee-%5E2.2.1-blue?style=flat-square)](https://pub.dev/packages/marquee)
        -   [![path_provider](https://img.shields.io/badge/path_provider-%5E2.0.11-blue?style=flat-square)](https://pub.dev/packages/path_provider)
        -   [![rxdart](https://img.shields.io/badge/rxdart-%5E0.27.4-blue?style=flat-square)](https://pub.dev/packages/rxdart)
        -   [![uni_links](https://img.shields.io/badge/uni_links-%5E0.5.1-blue?style=flat-square)](https://pub.dev/packages/uni_links)