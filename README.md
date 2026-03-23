# Solid Waste Management – iOS App

An iOS application developed for the **Mangalore City Corporation** that enables citizens to track garbage collection trucks in real time, submit waste-related grievances, participate in awareness campaigns, and provide feedback on waste management services.

> **Note:** I built this application entirely on my own. The initial idea and concept came from a colleague's existing project that I was asked to reproduce and further develop as a learning and practice exercise.

---

## 📸 Screenshots

> *Screenshots will be added here soon.*

<!-- 
To add screenshots, place your image files in a `Screenshots/` folder and update the paths below.

| Login | Home (Map) | Campaigns |
|-------|-----------|-----------|
| ![Login](Screenshots/login.png) | ![Home](Screenshots/home.png) | ![Campaigns](Screenshots/campaigns.png) |

| Grievance | Feedback | OTP Verification |
|-----------|----------|-----------------|
| ![Grievance](Screenshots/grievance.png) | ![Feedback](Screenshots/feedback.png) | ![OTP](Screenshots/otp.png) |
-->

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| **Language** | Swift |
| **Platform** | iOS 13.0+ |
| **UI Framework** | UIKit (Storyboards + XIBs) |
| **Maps** | MapKit + CoreLocation |
| **Architecture** | MVC (Model-View-Controller) |
| **JSON Parsing** | SwiftyJSON (bundled) |
| **Networking** | URLSession + RESTful API |
| **Local Storage** | UserDefaults |
| **Notifications (UI)** | HRToast (bundled) |
| **Build Tool** | Xcode |

---

## 🏗️ Architecture & Project Structure

```
Solid Waste Management/
├── AppDelegate.swift           # App lifecycle
├── SceneDelegate.swift         # Scene lifecycle (iOS 13+)
│
├── LoginVC.swift               # Login screen with language selection
├── OTPVerificationVC.swift     # 6-digit OTP verification
├── HomeVC.swift                # Map view – real-time truck tracking
├── CampaignsVC.swift           # Campaigns feed (TableView)
├── GrievanceVC.swift           # Grievance submission form
├── FeedbackVC.swift            # Feedback submission form
│
├── CampaignTableViewCell.swift # Custom reusable cell for campaigns
│
├── Helper/
│   ├── Config.swift            # API configuration & UserDefaults helpers
│   ├── Constants.swift         # Network URLs & API endpoints
│   ├── Extension.swift         # UIKit extensions (navigation, styling, …)
│   ├── ValidationClass.swift   # Form validation (email, phone, passwords)
│   ├── CustomTextField.swift   # Custom validated text input component
│   ├── DropDownTextField.swift # Dropdown / picker text field
│   ├── SwiftyJSON.swift        # JSON parsing library
│   └── HRToast+UIView.swift    # Toast notifications
│
└── Assets.xcassets/            # App icon, images, colors (100+ assets)
```

### Screen Navigation Flow

```
LoginVC
  └─▶ OTPVerificationVC
          └─▶ Tab Bar
                ├── HomeVC        (Map – Truck Tracking)
                ├── CampaignsVC   (Awareness Campaigns)
                ├── GrievanceVC   (Submit Grievance)
                └── FeedbackVC    (Submit Feedback)
```

---

## 📋 Requirements

- Xcode 14 or later
- iOS 13.0+ deployment target
- Swift 5.x

---

## ⚙️ Setup & Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ballisingha/SolideWasteMangement.git
   cd SolideWasteMangement
   ```

2. **Open the project in Xcode**
   ```bash
   open "Solid Waste Management.xcodeproj"
   ```

3. **Select a simulator or connected device** and press **Run** (`⌘R`).

> The app runs against a demo API server by default (`DEMO` mode in `Config.swift`). No additional backend setup is required to explore the UI.

---

## 🔑 Permissions

| Permission | Reason |
|---|---|
| **Location Services** | Required to display the user's position and nearby truck locations on the map |

---

## 👤 About

Developed by **Guriqbal Singh Amroke**.

This project was built independently as a development exercise. The original concept was provided by a colleague as a reference implementation; all code in this repository was written from scratch by me as part of deepening my iOS development skills.

---

## 📄 License

This project is intended as a portfolio piece. Please contact the author before reusing any part of the code.
