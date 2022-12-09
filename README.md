# SounDroid v2

![License](https://img.shields.io/github/license/zS1L3NT/soundroid-v2?style=for-the-badge) ![Languages](https://img.shields.io/github/languages/count/zS1L3NT/soundroid-v2?style=for-the-badge) ![Top Language](https://img.shields.io/github/languages/top/zS1L3NT/soundroid-v2?style=for-the-badge) ![Commit Activity](https://img.shields.io/github/commit-activity/y/zS1L3NT/soundroid-v2?style=for-the-badge) ![Last commit](https://img.shields.io/github/last-commit/zS1L3NT/soundroid-v2?style=for-the-badge)

SounDroid v2 is a rebuild of the original [SounDroid v1](https://github.com/zS1L3NT/soundroid-v1).

View the video demonstration of the application [here](https://youtu.be/74Z8wLyDtRU).

## Motivation

I need a deliverable for my MBAP (Mobile Application Development) submission and I wanted to rebuild my original SounDroid v1 application.

## Subrepositories

### [`dart-flutter-soundroid`](dart-flutter-soundroid)

The Flutter Application

### [`web-express-soundroid-v2`](web-express-soundroid-v2)

The Express Backend for converting YouTube Videos to MP3

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

### Setup the Firebase Project

Instructions are listed in [Firebase-Setup.md](Firebase-Setup.md).

### Setup the Express Backend

Copy the `.env.example` file to `.env` then fill in the correct project credentials

```
$ npm i
$ npm run dev
```

### Setup the Flutter App

Copy the `env.example.dart` file to `env.dart` then fill in the correct project credentials

```
$ flutter pub get
$ flutter run
```

## Built with

-   Flutter
    -   Flutter SDK
        -   [![build_runner](https://img.shields.io/badge/build__runner-%5E2.1.11-blue?style=flat-square)](https://pub.dev/packages/build_runner/versions/2.1.11)
        -   [![flutter](https://img.shields.io/badge/flutter-sdk-blue?style=flat-square)](https://flutter.dev/)
        -   [![flutter_lints](https://img.shields.io/badge/flutter__lints-%5E1.0.0-blue?style=flat-square)](https://pub.dev/packages/flutter_lints/versions/1.0.0)
        -   [![provider](https://img.shields.io/badge/provider-%5E6.0.2-blue?style=flat-square)](https://pub.dev/packages/provider/versions/6.0.2)
    -   Audio
        -   [![audio_session](https://img.shields.io/badge/audio__session-%5E0.1.7-blue?style=flat-square)](https://pub.dev/packages/audio_session/versions/0.1.7)
        -   [![just_audio](https://img.shields.io/badge/just__audio-%5E0.9.24-blue?style=flat-square)](https://pub.dev/packages/just_audio/versions/0.9.24)
        -   [![just_audio_background](https://img.shields.io/badge/just__audio__background-%5E0.0.1--beta.5-blue?style=flat-square)](https://pub.dev/packages/just_audio_background/versions/0.0.1-beta.5)
        -   [![perfect_volume_control](https://img.shields.io/badge/perfect__volume__control-%5E1.0.5-blue?style=flat-square)](https://pub.dev/packages/perfect_volume_control/versions/1.0.5)
    -   Firebase
        -   [![cloud_firestore](https://img.shields.io/badge/cloud__firestore-%5E3.1.17-blue?style=flat-square)](https://pub.dev/packages/cloud_firestore/versions/3.1.17)
        -   [![firebase_auth](https://img.shields.io/badge/firebase__auth-%5E3.4.0-blue?style=flat-square)](https://pub.dev/packages/firebase_auth/versions/3.4.0)
        -   [![firebase_core](https://img.shields.io/badge/firebase__core-%5E1.15.0-blue?style=flat-square)](https://pub.dev/packages/firebase_core/versions/1.15.0)
        -   [![firebase_storage](https://img.shields.io/badge/firebase__storage-%5E10.2.18-blue?style=flat-square)](https://pub.dev/packages/firebase_storage/versions/10.2.18)
        -   [![google_sign_in](https://img.shields.io/badge/google__sign__in-%5E5.3.3-blue?style=flat-square)](https://pub.dev/packages/google_sign_in/versions/5.3.3)
    -   API
        -   [![cached_network_image](https://img.shields.io/badge/cached__network__image-%5E3.2.0-blue?style=flat-square)](https://pub.dev/packages/cached_network_image/versions/3.2.0)
        -   [![connectivity_plus](https://img.shields.io/badge/connectivity__plus-%5E2.3.5-blue?style=flat-square)](https://pub.dev/packages/connectivity_plus/versions/2.3.5)
        -   [![hive](https://img.shields.io/badge/hive-%5E2.2.1-blue?style=flat-square)](https://pub.dev/packages/hive/versions/2.2.1)
        -   [![hive_flutter](https://img.shields.io/badge/hive__flutter-%5E1.1.0-blue?style=flat-square)](https://pub.dev/packages/hive_flutter/versions/1.1.0)
        -   [![hive_generator](https://img.shields.io/badge/hive__generator-%5E1.1.3-blue?style=flat-square)](https://pub.dev/packages/hive_generator/versions/1.1.3)
        -   [![http](https://img.shields.io/badge/http-%5E0.13.4-blue?style=flat-square)](https://pub.dev/packages/http/versions/0.13.4)
        -   [![json_annotation](https://img.shields.io/badge/json__annotation-%5E4.5.0-blue?style=flat-square)](https://pub.dev/packages/json_annotation/versions/4.5.0)
        -   [![json_serializable](https://img.shields.io/badge/json__serializable-%5E6.2.0-blue?style=flat-square)](https://pub.dev/packages/json_serializable/versions/6.2.0)
        -   [![palette_generator](https://img.shields.io/badge/palette__generator-%5E0.3.3-blue?style=flat-square)](https://pub.dev/packages/palette_generator/versions/0.3.3)
        -   [![shimmer](https://img.shields.io/badge/shimmer-%5E2.0.0-blue?style=flat-square)](https://pub.dev/packages/shimmer/versions/2.0.0)
    -   Miscellaneous
        -   [![auto_size_text](https://img.shields.io/badge/auto__size__text-%5E3.0.0-blue?style=flat-square)](https://pub.dev/packages/auto_size_text/versions/3.0.0)
        -   [![awesome_notifications](https://img.shields.io/badge/awesome__notifications-%5E0.6.21-blue?style=flat-square)](https://pub.dev/packages/awesome_notifications/versions/0.6.21)
        -   [![copy_with_extension](https://img.shields.io/badge/copy__with__extension-%5E4.0.0-blue?style=flat-square)](https://pub.dev/packages/copy_with_extension/versions/4.0.0)
        -   [![copy_with_extension_gen](https://img.shields.io/badge/copy__with__extension__gen-%5E4.0.0-blue?style=flat-square)](https://pub.dev/packages/copy_with_extension_gen/versions/4.0.0)
        -   [![diffutil_dart](https://img.shields.io/badge/diffutil__dart-%5E3.0.0-blue?style=flat-square)](https://pub.dev/packages/diffutil_dart/versions/3.0.0)
        -   [![equatable](https://img.shields.io/badge/equatable-%5E2.0.3-blue?style=flat-square)](https://pub.dev/packages/equatable/versions/2.0.3)
        -   [![flutter_bloc](https://img.shields.io/badge/flutter__bloc-%5E8.0.1-blue?style=flat-square)](https://pub.dev/packages/flutter_bloc/versions/8.0.1)
        -   [![flutter_launcher_icons](https://img.shields.io/badge/flutter__launcher__icons-%5E0.9.2-blue?style=flat-square)](https://pub.dev/packages/flutter_launcher_icons/versions/0.9.2)
        -   [![flutter_native_splash](https://img.shields.io/badge/flutter__native__splash-%5E2.1.6-blue?style=flat-square)](https://pub.dev/packages/flutter_native_splash/versions/2.1.6)
        -   [![flutter_settings_screens](https://img.shields.io/badge/flutter__settings__screens-%5E0.3.2--null--safety-blue?style=flat-square)](https://pub.dev/packages/flutter_settings_screens/versions/0.3.2-null-safety)
        -   [![great_list_view](https://img.shields.io/badge/great__list__view-%5E0.1.4-blue?style=flat-square)](https://pub.dev/packages/great_list_view/versions/0.1.4)
        -   [![image_cropper](https://img.shields.io/badge/image__cropper-%5E2.0.3-blue?style=flat-square)](https://pub.dev/packages/image_cropper/versions/2.0.3)
        -   [![image_picker](https://img.shields.io/badge/image__picker-%5E0.8.5%2B3-blue?style=flat-square)](https://pub.dev/packages/image_picker/versions/0.8.5+3)
        -   [![marquee](https://img.shields.io/badge/marquee-%5E2.2.1-blue?style=flat-square)](https://pub.dev/packages/marquee/versions/2.2.1)
        -   [![path_provider](https://img.shields.io/badge/path__provider-%5E2.0.11-blue?style=flat-square)](https://pub.dev/packages/path_provider/versions/2.0.11)
        -   [![rxdart](https://img.shields.io/badge/rxdart-%5E0.27.4-blue?style=flat-square)](https://pub.dev/packages/rxdart/versions/0.27.4)
        -   [![uni_links](https://img.shields.io/badge/uni__links-%5E0.5.1-blue?style=flat-square)](https://pub.dev/packages/uni_links/versions/0.5.1)
-   Express
    -   TypeScript
        -   [![@types/express](https://img.shields.io/badge/%40types%2Fexpress-%5E4.17.13-red?style=flat-square)](https://npmjs.com/package/@types/express/v/4.17.13)
        -   [![@types/node](https://img.shields.io/badge/%40types%2Fnode-%5E17.0.34-red?style=flat-square)](https://npmjs.com/package/@types/node/v/17.0.34)
        -   [![@types/sharp](https://img.shields.io/badge/%40types%2Fsharp-%5E0.30.4-red?style=flat-square)](https://npmjs.com/package/@types/sharp/v/0.30.4)
        -   [![@types/spotify-web-api-node](https://img.shields.io/badge/%40types%2Fspotify--web--api--node-%5E5.0.7-red?style=flat-square)](https://npmjs.com/package/@types/spotify-web-api-node/v/5.0.7)
        -   [![@types/string-similarity](https://img.shields.io/badge/%40types%2Fstring--similarity-%5E4.0.0-red?style=flat-square)](https://npmjs.com/package/@types/string-similarity/v/4.0.0)
        -   [![ts-node-dev](https://img.shields.io/badge/ts--node--dev-%5E2.0.0-red?style=flat-square)](https://npmjs.com/package/ts-node-dev/v/2.0.0)
        -   [![typescript](https://img.shields.io/badge/typescript-%5E4.6.4-red?style=flat-square)](https://npmjs.com/package/typescript/v/4.6.4)
    -   Firebase
        -   [![firebase-admin](https://img.shields.io/badge/firebase--admin-%5E10.2.0-red?style=flat-square)](https://npmjs.com/package/firebase-admin/v/10.2.0)
        -   [![google-it](https://img.shields.io/badge/google--it-%5E1.6.3-red?style=flat-square)](https://npmjs.com/package/google-it/v/1.6.3)
    -   YouTube APIs
        -   [![ytdl-core](https://img.shields.io/badge/ytdl--core-%5E4.11.2-red?style=flat-square)](https://npmjs.com/package/ytdl-core/v/4.11.2)
        -   [![ytmusic-api](https://img.shields.io/badge/ytmusic--api-%5E3.0.0-red?style=flat-square)](https://npmjs.com/package/ytmusic-api/v/3.0.0)
    -   Miscellaneous
        -   [![axios](https://img.shields.io/badge/axios-%5E0.27.2-red?style=flat-square)](https://npmjs.com/package/axios/v/0.27.2)
        -   [![colors](https://img.shields.io/badge/colors-%5E1.4.0-red?style=flat-square)](https://npmjs.com/package/colors/v/1.4.0)
        -   [![dotenv](https://img.shields.io/badge/dotenv-%5E16.0.1-red?style=flat-square)](https://npmjs.com/package/dotenv/v/16.0.1)
        -   [![express](https://img.shields.io/badge/express-%5E4.18.1-red?style=flat-square)](https://npmjs.com/package/express/v/4.18.1)
        -   [![no-try](https://img.shields.io/badge/no--try-%5E3.1.0-red?style=flat-square)](https://npmjs.com/package/no-try/v/3.1.0)
        -   [![sharp](https://img.shields.io/badge/sharp-%5E0.30.6-red?style=flat-square)](https://npmjs.com/package/sharp/v/0.30.6)
        -   [![spotify-web-api-node](https://img.shields.io/badge/spotify--web--api--node-%5E5.0.2-red?style=flat-square)](https://npmjs.com/package/spotify-web-api-node/v/5.0.2)
        -   [![string-similarity](https://img.shields.io/badge/string--similarity-%5E4.0.4-red?style=flat-square)](https://npmjs.com/package/string-similarity/v/4.0.4)
        -   [![tracer](https://img.shields.io/badge/tracer-%5E1.1.5-red?style=flat-square)](https://npmjs.com/package/tracer/v/1.1.5)
        -   [![ts-node-dev](https://img.shields.io/badge/ts--node--dev-%5E2.0.0-red?style=flat-square)](https://npmjs.com/package/ts-node-dev/v/2.0.0)
        -   [![typescript](https://img.shields.io/badge/typescript-%5E4.6.4-red?style=flat-square)](https://npmjs.com/package/typescript/v/4.6.4)
        -   [![validate-any](https://img.shields.io/badge/validate--any-%5E1.3.2-red?style=flat-square)](https://npmjs.com/package/validate-any/v/1.3.2)