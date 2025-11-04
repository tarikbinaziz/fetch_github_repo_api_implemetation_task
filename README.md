# github_repos_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

# Directory Structure

github_repos_app/
├─ android/
├─ ios/
├─ lib/
│  ├─ main.dart
│  ├─ app_binding.dart
│  ├─ routes.dart
│  ├─ services/
│  │  └─ api_service.dart
│  ├─ models/
│  │  ├─ user_model.dart
│  │  └─ repo_model.dart
│  ├─ controllers/
│  │  ├─ auth_controller.dart   // username + user fetch
│  │  └─ repos_controller.dart  // repos fetch + filtering + view mode
│  ├─ pages/
│  │  ├─ login_page.dart
│  │  ├─ home_page.dart
│  │  └─ repo_detail_page.dart
│  └─ widgets/
│     ├─ repo_list_tile.dart
│     └─ repo_grid_tile.dart
├─ pubspec.yaml
└─ README.md




তোমার মূল কাজটা সংক্ষেপে ছিল 👇

✅ একটি Flutter অ্যাপ বানানো, যেখানে GitHub API ব্যবহার করে কোনো GitHub username দিয়ে তার repos দেখানো হবে
✅ User প্রথম পেজে username লিখবে → তারপর homepage এ যাবে
✅ Home page এ repos list দেখাবে + list view / grid view toggle
✅ Filter/sort option দিতে হবে (date, name, stars ইত্যাদি)
✅ Repo-তে ট্যাপ করলে details page খুলবে
✅ Light/Dark theme toggle থাকতে হবে
✅ API call করতে হবে Dio দিয়ে
✅ GetX দিয়ে state management করতে হবে
✅ Proper error handling, clean UI, good code structure
✅ Git commit step by step করতে হবে
✅ APK বানিয়ে দিতে হবে + GitHub repo submit করতে হবে

এটাই পুরো assignment-এর core summary ✅


✅ Phase 1 – Project Setup

Create a new Flutter project (latest stable version)

Initialize Git & make the first commit (project setup)

Add required dependencies:

dio

get (GetX state management)

get_storage (for theme persistence)

flutter_screenutil (optional but good for responsive UI)

intl (for date formatting)

Setup folder structure (app, data, modules, widgets, etc.)

✅ Phase 2 – Theme & Routing

Implement light/dark theme toggle using GetX + GetStorage

Add AppRoutes (LoginPage → HomePage → RepoDetailsPage)

Make Theme toggle available globally (AppBar Icon/Button)

✅ Phase 3 – API Service Layer

Create Dio client with:

Base URL

Timeout handling

Error interceptor

API endpoints:

GET /users/{username}

GET /users/{username}/repos

Create Models:

UserModel

RepoModel

✅ Phase 4 – First Page (Enter Username)

Build UI with:

TextField input for GitHub username

Continue button

Validate user input (empty, invalid)

On submit:

Call /users/{username}

If user exists → navigate to HomePage

If error → show error dialog/snackbar

✅ Phase 5 – Home Page (Repositories List)

Fetch repos via /users/{username}/repos

Display basic user info at top

Repository list:

Default: ListView

Toggle: GridView

Add filter/sort options:

By Name

By Stars

By Date

(Sort ascending/descending)

Add pull-to-refresh

✅ Phase 6 – Repo Details Page

On tap of repo → navigate to details page

Show:

Repo name, description

Stars, forks, watchers count

Created date, updated date

Language

Open in browser button

✅ Phase 7 – Error & Loading Handling

Add shimmer/loading skeleton or progress indicator

Show proper UI for:

No internet

User not found

No repositories found

API error rate limit (403)

Retry button for failed API calls

✅ Phase 8 – Finalization

Add app icon & splash screen (optional but nice)

Build release APK

Push full code to GitHub

Share Repo + APK link