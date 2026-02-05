# 🚀 RoumianSpace Mobile Application

**Presented by:** Ghady Chouity & Chloe Khoury

---


## 🌟 Overview

Stay updated on SpaceX launches, missions, and news with this feature-rich mobile application. Explore stunning images and videos, track launches, learn about rockets and ships, meet crew members, and interact with **Cosmo** - an intelligent AI chatbot assistant that answers your space-related questions. Built with Flutter for Android, iOS, Web, and Desktop platforms.

---

## Demnstration Video: https://drive.google.com/file/d/1aHF3TCI6FaUMtUL3t-AHUh0AkkZ1cGuT/view?usp=sharing

---

## ✨ Features

### 🔐 Authentication & User Management
- **Firebase Authentication** with email/password
- **User Registration** and secure login
- **Password Recovery** functionality
- **Profile Management** with customizable profile pictures
- **Secure Token Storage** for session management

### 🏠 Home Dashboard
- Browse **Rockets** with detailed specifications
- View **Launch Pads** with location and operational status
- Interactive **Carousel Sliders** for featured content
- **Shimmer Loading Effects** for smooth UX
- **Cached Images** for optimal performance

### 🏢 Company Information
- Comprehensive **SpaceX company overview**
- Headquarters, founder, and founding details
- Employee count and company valuation
- Direct links to **official social media** channels
- Company history and achievements

### 🚢 Ships & Fleet
- Detailed information on **SpaceX ships and vessels**
- **Active status indicators** and mission assignments
- **Search and filter** capabilities
- High-resolution images with zoom functionality
- Historical mission data

### 👨‍🚀 Crew Members
- **Astronaut profiles** with biographies
- Mission assignments and agency affiliations
- Launch participation history
- Crew status and current assignments

### 🤖 AI-Powered Chatbot (Cosmo)
- **Intelligent Space Assistant** powered by advanced AI
- **Wolfram Alpha Integration** for computational answers
- **Hugging Face DeepSeek-V3** for conversational AI
- **Python Flask Backend** microservice architecture
- Real-time answers to space, astronomy, and mission questions
- Friendly personality with space-themed emojis 🚀✨
- Short, mobile-optimized responses (2-3 sentences)
- Natural language understanding for complex queries

### 💾 Saved Items
- **Dual Database System**: SQLite for mobile, Sembast for web
- Bookmark favorite rockets, launches, and ships
- Quick access to saved content
- Persistent storage across sessions
- Cross-platform compatibility

### 🎵 Audio Experience
- **Space-themed audio** with just_audio
- Background soundscapes and ambient music
- Audio playback controls
- Immersive exploration experience

### 🎯 Onboarding
- Interactive onboarding screens for new users
- Feature highlights and navigation guide
- Custom animated splash screen
- First-time user tutorial


---

## 🛠 Technologies

### Frontend (Flutter)

#### Core Framework
- **Flutter SDK** (>=3.3.2 <4.0.0)
- **Dart** programming language

#### Backend Services
- **Firebase Core** (2.30.0) - Backend infrastructure
- **Firebase Auth** (4.19.2) - User authentication
- **Cloud Firestore** (4.17.2) - Cloud database
- **Firebase Storage** (11.7.4) - File storage

#### API & Networking
- **Dio** (5.4.3) - HTTP client
- **Retrofit** (4.1.0) - Type-safe API client
- **HTTP** (1.1.0) - HTTP requests for chatbot
- **SpaceX API v4** - Real-time SpaceX data

#### State Management
- **Flutter BLoC** (8.1.5) - Business logic component
- **GetIt** (7.6.7) - Dependency injection
- **Dartz** (0.10.1) - Functional programming

#### Local Storage
- **SQLite** (2.3.3) - Mobile database
- **Sembast** (3.5.0) - Cross-platform NoSQL DB
- **Sembast Web** (2.1.0) - Web storage support
- **SharedPreferences** (2.2.3) - Key-value storage
- **Flutter Secure Storage** (4.2.1) - Encrypted storage

#### Audio & Media
- **Just Audio** (0.9.44) - Audio playback
- **Image Picker** (1.1.0) - Photo selection
- **URL Launcher** (6.2.6) - External links
- **Path Provider** (2.1.2) - File system paths

#### UI/UX Libraries
- **Cached Network Image** (3.3.1) - Image caching
- **Shimmer** (3.0.0) - Loading animations
- **Carousel Slider** (5.0.0) - Image carousels
- **Animated Text Kit** (4.2.0) - Text animations
- **Rive** (0.13.4) - Advanced animations
- **Font Awesome Flutter** (10.7.0) - Icons
- **Gradient Borders** (1.0.0) - UI styling

#### Utilities
- **Permission Handler** (11.3.1) - Runtime permissions
- **Fluttertoast** (8.2.5) - Toast notifications

### Backend (Python)

- **Flask** - Lightweight web framework
- **OpenAI SDK** - Hugging Face API client
- **Wolfram Alpha API** - Computational knowledge
- **Hugging Face Router** - AI model access
- **DeepSeek-V3 Model** - Conversational AI



---

## 📦 Installation

### Prerequisites
- **Flutter SDK** (3.3.2 or higher)
- **Dart SDK** (included with Flutter)
- **Python 3.8+** (for backend chatbot)
- **Android Studio** / **VS Code** with Flutter plugins
- **Xcode** (for iOS development on macOS)
- **Node.js** (for web development)

### Frontend Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ghadz/Programmation-des-terminaux-mobiles-Project
   cd Programmation-des-terminaux-mobiles-Project
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Run**
   ```bash
   flutter run -d chrome --web-browser-flag "--disable-web-security"
   ```

---

## 📁 Project Structure

```
spacex_mobile_app/
├── android/               # Android native code
├── ios/                   # iOS native code
├── web/                   # Web specific files
├── windows/               # Windows desktop files
├── linux/                 # Linux desktop files
├── macos/                 # macOS desktop files
│
├── assets/                # Static assets
│   ├── images/           # Image files
│   ├── fonts/            # Custom fonts
│   ├── splash/           # Splash screen assets
│   ├── app_icon/         # App icon files
│   └── Audios/           # Audio files for playback
│
├── lib/                   # Main application code
│   ├── core/             # Core utilities
│   ├── features/         # Feature modules
│   │   ├── chatbot/      # AI Chatbot feature
│   │   ├── home/         # Home dashboard
│   │   ├── ships/        # Ships catalog
│   │   └── ...           # Other features
│   ├── firebase_options.dart
│   ├── main.dart         # App entry point
│   └── spacex_app.dart   # App configuration
│
├── test/                  # Unit and widget tests
├── pubspec.yaml          # Flutter dependencies
├── README.md             # This file
└── report.docx           # Project report
```

---

## 🌐 API Integration

### SpaceX API v4

Base URL: `https://api.spacexdata.com/v4/`

**Endpoints used:**
- `/company` - Company information
- `/rockets` - Rocket details
- `/launchpads` - Launch pad information
- `/ships` - SpaceX ships data
- `/crew` - Crew member profiles
- `/launches` - Launch data

### Wolfram Alpha API

Used for computational and factual queries in the chatbot.

**Example Query:**
```
https://api.wolframalpha.com/v1/result?i=distance+to+mars&appid=YOUR_API_KEY
```

### Custom Backend API

**Endpoint:** `POST http://localhost:5000/chat`

**Request:**
```json
{
  "message": "What is the speed of light?"
}
```

**Response:**
```json
{
  "response": "The speed of light is approximately 299,792 kilometers per second! 🚀 That's about 186,282 miles per second. ✨"
}
```
          
---

## 👥 Authors

**Ghady Chouity** - ULFG2  
**Chloe Khoury** - ULFG2

---


---

## 📞 Support

For support, email chloekhoury@proton.me or open an issue in the repository.

---

## 🌟 Star History

If you find this project useful, please consider giving it a star! ⭐

---

<p align="center">
  <strong>Made with ❤️ and ☕ to Dr Aoude</strong><br>
  <em>Powered by AI 🤖 | Exploring Space 🚀 | Built with Flutter 💙</em>
</p>
