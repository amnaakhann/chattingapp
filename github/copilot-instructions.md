# AI Copilot Rules — Multi-User Chat Application

## Overview
This project is a **Multi-User Chat Application** built with **:contentReference[oaicite:0]{index=0}** and **:contentReference[oaicite:1]{index=1}**.  
The application includes authentication (Email/Password and Google Sign-In), real-time messaging, and Light/Dark theme support.

These rules define how AI Copilot should assist during development to ensure clean, secure, scalable, and maintainable code.

---

## General Principles
- Follow Flutter and Dart best practices at all times.
- Prefer **readability, simplicity, and maintainability** over clever or complex solutions.
- Generate code that is **production-ready**, not demo-level.
- Avoid unnecessary abstractions.
- Always explain non-trivial logic with concise comments.

---

## Flutter & Dart Guidelines
- Use **null-safety** correctly; avoid force unwraps (`!`) unless absolutely necessary.
- Prefer `const` constructors and widgets where possible.
- Break large widgets into **small, reusable widgets**.
- Keep UI code separate from business logic.
- Follow Flutter’s recommended folder structure.

---

## Authentication Rules (Firebase)
- Use **Firebase Authentication** for:
    - Email/Password login and registration
    - Google Sign-In
- Never hardcode API keys, secrets, or credentials.
- Handle authentication errors gracefully and display user-friendly messages.
- Always check authentication state before accessing protected screens.
- Ensure proper sign-out handling for all providers.

---

## Real-Time Chat Rules
- Use Firebase services for real-time message synchronization.
- Messages must:
    - Be timestamped
    - Include sender identification
- Ensure message listeners are properly disposed to avoid memory leaks.
- Avoid unnecessary real-time listeners when the screen is not active.
- Optimize queries to reduce bandwidth usage.

---

## State Management
- Use a **clear and consistent state management approach**.
- Avoid calling `setState` excessively.
- Keep business logic out of UI widgets.
- Ensure state updates are predictable and traceable.

---

## UI / UX Rules
- Support **Light and Dark themes** using `ThemeData`.
- Do not hardcode colors; always use theme-based colors.
- Ensure text contrast meets accessibility standards.
- UI should be responsive across different screen sizes.
- Avoid UI jank and unnecessary rebuilds.

---

## Error Handling & Logging
- Handle all async errors explicitly.
- Avoid silent failures.
- Log errors in a structured and meaningful way.
- Never expose internal error messages directly to end users.

---

## Performance Guidelines
- Minimize widget rebuilds.
- Use lazy loading where applicable.
- Dispose controllers, streams, and listeners properly.
- Avoid heavy computations on the main thread.

---

## Security Rules
- Never store sensitive data in plain text.
- Validate user input before sending it to Firebase.
- Follow Firebase security rules best practices.
- Do not expose internal project structure or secrets in logs.

---

## Code Style & Documentation
- Follow Dart formatting conventions.
- Use meaningful variable, class, and method names.
- Add short documentation comments for complex functions.
- Keep files focused on a single responsibility.

---

## AI Copilot Constraints (Do & Don’t)

### Do
- Suggest clean, scalable Flutter solutions.
- Follow Firebase and Flutter official recommendations.
- Optimize for maintainability and clarity.

### Don’t
- Don’t generate deprecated Flutter or Firebase APIs.
- Don’t mix UI and business logic.
- Don’t assume libraries or packages without justification.
- Don’t produce insecure or hardcoded solutions.

---

## Environment
- IDE: Android Studio
- Framework: Flutter
- Language: Dart
- Backend: Firebase
- AI Model: Claude Sonnet 4.5

---

## Final Note
AI Copilot should act as a **senior Flutter developer**, prioritizing code quality, security, performance, and best practices tailored specifically for a real-time chat application.
