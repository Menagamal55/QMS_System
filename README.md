# 🏦 QMS - Smart Queue Management System

A production-ready, real-time banking queue management application built with **Flutter**. This system leverages modern software engineering practices to eliminate physical waiting lines through digital ticketing and real-time monitoring.

---

## 👩‍💻 Developed By
**Menna Gamal**
*Flutter Developer | Software Architecture Enthusiast*

---

## 📺 Project Demo
> **Experience the flow and UI/UX of the system:**
> [🎥 Watch the Full Demo Video](https://github.com/Menagamal55/QMS_System/issues/1#issue-4272545372)

---

## 🏗️ Architecture: Clean Architecture
This project is built following the **Uncle Bob's Clean Architecture** principles. It is decoupled into three independent layers to ensure high maintainability, scalability, and ease of testing:

1.  **Data Layer**: Responsible for API communication (Dio), Data Models (JSON Serialization), and Repository implementations.
2.  **Domain Layer**: The core business logic containing Entities, UseCases, and Repository Interfaces (The "Brain" of the app).
3.  **Presentation Layer**: User Interface screens managed by the **BLoC/Cubit** pattern for predictable state management.

---

## ✨ Key Features

### 🔹 Customer Experience
* **Secure Auth**: Personalized Login/Register with JWT token handling.
* **Smart Onboarding**: Seamless introduction to the digital queueing process.
* **Service Selection**: Choose from various banking services (Withdrawal, Deposit, etc.).
* **Virtual Ticket**: Instant remote ticket booking with unique IDs (e.g., B104).
* **Live Tracking**: Real-time updates on your position in the queue.
* **Smart Notifications**: Push notifications to alert users when their turn is near or called.

### 🔹 Staff & Admin Flow
* **Staff Dashboard**: A central hub to monitor active queues and customer flow.
* **Call Next System**: One-tap action to call the next customer in line.
* **Advanced Analytics**: Visualized data (Charts) showing peak hours and service efficiency.
* **Real-time Sync**: Instant status updates across all connected devices using background services.

---

## 🛠️ Tech Stack
* **State Management**: [Flutter BLoC](https://pub.dev/packages/flutter_bloc) (Event-driven).
* **Networking**: [Dio](https://pub.dev/packages/dio) with custom **Interceptors** for automated Token Injection.
* **Local Storage**: [Shared Preferences](https://pub.dev/packages/shared_preferences) with a custom `CacheHelper`.
* **Dependency Injection**: [Get_it](https://pub.dev/packages/get_it) for service location.
* **Functional Programming**: [Dartz](https://pub.dev/packages/dartz) (Either Left/Right) for robust error handling.
* **UI Components**: Custom themes, Responsive layouts, and Data Visualization (Charts).

---

## 📂 Project Structure
```text
lib/
 ├── core/              # Global utilities, network clients, errors, and themes
 ├── features/          # Feature-based modules (Following Clean Arch)
 │    ├── auth/         # Login & Registration
 │    ├── customer/     # Booking & Ticket Tracking
 │    ├── staff/        # Staff actions & Queue Management
 │    ├── dashboard/    # Analytics & Data Visualization (Charts)
 │    └── notifications/# Local & Push Notification services
 └── main.dart          # App entry point & Dependency Injection setup
