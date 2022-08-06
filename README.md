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