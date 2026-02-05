A Flutter app showcasing SpaceX launches, rockets, and company info. Works on Android, iOS, and Web with a responsive and interactive UI.
Presented by: 
    -Ghady Chouity
    -Chloe Khoury
Features

Browse upcoming & past launches

View rocket details

Login & forgot password functionality

Carousel sliders for featured content

Responsive design for web and mobile

Get dependencies:

flutter pub get

Run the app:
for the chat bot to work on web we need to disable web security
Web:  flutter run -d chrome --web-browser-flag "--disable-web-security"

I couldn't run the mobile version for jdk problems but the app should work fine
Mobile: Connect a device/emulator → flutter run

Notes

Login may require Firebase setup (email/password authentication).

Enable Developer Mode on Windows for plugin support.

Some packages may need upgrading for latest Flutter SDK.

Project Structure
lib/       # App code
android/   # Android native
ios/       # iOS native
web/       # Web files
pubspec.yaml # Dependencies

References

Flutter Docs

SpaceX API

wolframe alfa API

