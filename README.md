# SMRISS GGSSS Bathinda – Smart School Mobile App

A production-ready Flutter mobile application crafted for **Shaheed Major Ravi Inder Singh Sandhu Govt Girls Sen Sec Smart School, Mall Road, Bathinda (SMRISS GGSSS Mall Road Bathinda)**.

Converted from Google Stitch Project: [14328680377818032678](https://stitch.withgoogle.com/projects/14328680377818032678)

---

## 🔗 1. Web Links Integration (`UrlLauncherService`)

All buttons trigger direct web browsing using the `url_launcher` package:

| Button | Target URL | Handler |
| :--- | :--- | :--- |
| **Syllabus** | `http://pseb.ac.in` | [`UrlLauncherService.openSyllabus()`](lib/services/url_launcher_service.dart) |
| **Website** | `https://sites.google.com/d/14otVaOV3vycbNa-kyiS3X0WMluJ52dJ9/p/1ANxLnwTt0fDeWaMN4WS_UCE6j49T5nl_/edit` | [`UrlLauncherService.openWebsite()`](lib/services/url_launcher_service.dart) |
| **Messages & Notifications** | `https://docs.google.com/document/d/1Xl2OLmhVYVTWOzIjISUMj6vMDlduUc0oNvg73fuJBfA/edit?tab=t.0` | [`UrlLauncherService.openMessagesAndNotifications()`](lib/services/url_launcher_service.dart) |
| **Timetable** | `https://docs.google.com/spreadsheets/d/1abuFliE2_pCgSKHB_HUQEvHSAvRTfX33h5k9_onDiAA/edit?gid=0#gid=0` | [`UrlLauncherService.openTimetable()`](lib/services/url_launcher_service.dart) |

---

## 📐 2. Wireframe & Navigation Flow

1. **Gallery Button**:
   - Opens the dedicated **[Gallery Wireframe Screen](lib/screens/gallery_screen.dart)** (`GalleryScreen`).
   - Features album filters (*Smart Labs, Sports & Athletics, Eco-Club & Greenery, Cultural & Heritage, Campus Infrastructure*), interactive photo grid, and high-resolution zoom/preview dialog.

2. **Activity Button**:
   - Opens the dedicated **[Activity Wireframe Screen](lib/screens/activities_screen.dart)** (`ActivitiesScreen`).
   - Features category filter chips (*All Initiatives, Nasha Mukt, BIS Club, Eco Club, Cultural*), dynamic coordinator details, dates, and participation action triggers.

3. **School Profile (Principal Sir's Picture Layout)**:
   - Located in **[Institutional Profile Screen](lib/screens/institutional_profile_screen.dart)** (`InstitutionalProfileScreen`).
   - Embeds the official picture of Principal Sir: `assets/images/principal.jpeg`.
   - Layout features:
     - **S. Kulwinder Singh Sandhu**, State Awardee, Principal & Head of Institution.
     - Verified state awardee badge & contact email: `contact.principal@smriss.edu`.
     - Official Quote Callout: *"Under his brilliant leadership, the school campus has transformed into a highly disciplined, positive, and vibrant space where education thrives effortlessly for every single student."*
     - School metrics: 2,450+ Students, 32 Smart Classrooms, 85+ Faculty, 6 Labs, ESTD 1954.

4. **Bottom Navigation Bar**:
   - Functional 5-tab institutional navigation (`CustomBottomNavBar`):
     - 🏠 **Home** (Index 0) -> `HomeDashboardScreen`
     - 🏆 **Activities** (Index 1) -> `ActivitiesScreen` (Activity Wireframe)
     - 🖼️ **Gallery** (Index 2) -> `GalleryScreen` (Gallery Wireframe)
     - 🏛️ **Profile** (Index 3) -> `InstitutionalProfileScreen` (Principal Sir & School Profile)
     - ⚙️ **Settings** (Index 4) -> `SettingsScreen` (Preferences & Sign Out)

---

## 🔒 3. Core App Logic & Search Functionality

### Strict Authentication Guard (`AuthGate`)
- Embedded in [`lib/main.dart`](lib/main.dart) using a reactive `StreamBuilder<User?>` on `FirebaseAuth.instance.authStateChanges()`.
- **The main Homepage of the app WILL NOT open unless the user successfully logs in via Gmail/Google Sign-In** using our attached `google-services.json` file (`package: com.school.myapp`, project: `myschoolapp-21a8b`).
- If unauthenticated, the app locks down and only displays the Welcome / Login screens.
- Signing out from the Settings tab immediately revokes session access and returns to the Login Screen.

### Functional Search Bar & Mic (Voice Search)
- Implemented in [`lib/services/search_service.dart`](lib/services/search_service.dart) and [`lib/widgets/search_delegate_view.dart`](lib/widgets/search_delegate_view.dart).
- **Text Search**: Real-time query matching across syllabus, timetable, notices, school leadership (Principal Sir), clubs, and facilities.
- **Voice Search (Mic)**: Clicking the Mic icon launches the `VoiceSearchModal` with animated waveform soundwaves, voice command prompts, and speech recognition triggers.
- Selecting any search result instantly routes the user to that wireframe screen or launches the respective Google Doc / Google Sheet / PSEB link!

---

## 🚀 How to Run & Compile

```bash
cd c:\Users\hp\Downloads\SchoolAppProject
flutter pub get
flutter run
```

To run on Web / Chrome:
```bash
flutter run -d chrome
```
