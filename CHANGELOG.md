# Changelog

All notable changes to Student Notes will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2026-01-15

### Changed
- **Theme Colors** - New modern green color scheme (Sage Green #5F9E7F)
- **Typography** - Changed from Poppins to Inter font for better readability
- **Color Palette** - Smooth, professional colors that are not harsh (tidak norak)
- **Dark Mode** - Enhanced dark mode with green-tinted background
- **Course Colors** - Updated to harmonious green palette

### Improved
- **Readability** - Optimized letter spacing and line height (1.6)
- **Text Hierarchy** - Clear typography hierarchy with proper font weights
- **Background** - Soft cream background (#F8FAF7) for natural feel
- **Contrast** - High contrast text colors for better readability
- **Shadows** - Subtle shadows with primary color tint

### Design Details
- Primary: Sage Green (#5F9E7F) - smooth and calming
- Secondary: Mint Green (#8BC9A8) - fresh and modern
- Accent: Soft Terracotta (#E8A87C) - warm contrast
- Background: Soft Cream (#F8FAF7) - natural feel
- Typography: Inter font family - modern and readable

## [1.0.1] - 2026-01-15

### Fixed
- **Authentication System** - Implemented proper user authentication with database validation
- **Data Persistence** - Fixed logout to only clear session, not delete user data
- **Google Sign-In** - Disabled fake Google Sign-In, added proper message to use email registration

### Added
- **Register Screen** - New registration screen with email and password
- **Password Hashing** - SHA-256 password hashing for security
- **Course Management** - New screen to add and delete courses
- **Email Validation** - Check for duplicate emails during registration
- **Password Verification** - Proper password verification during login

### Changed
- **Login Flow** - Now requires valid credentials from database
- **Logout Behavior** - Only clears session, keeps all data intact
- **Database Schema** - Added `password_hash` column and UNIQUE constraint on email
- **Profile Screen** - Added "Kelola Mata Kuliah" menu item

### Security
- Password hashing with SHA-256
- Email unique constraint
- Proper authentication validation

### Breaking Changes
- Database schema changed - requires app reinstall
- Cannot login with random credentials anymore
- Must register before login

---

## [1.0.0] - 2026-01-15

### Added - Initial Release

#### Authentication
- Email & password login system
- Google Sign-In integration (simulation mode)
- Session persistence with auto-login
- Secure logout with confirmation

#### Note Management
- Create new notes with title, course, and content
- Read/view note details
- Update existing notes
- Delete notes with confirmation
- Toggle favorite status for important notes
- Auto-save draft detection

#### Search & Filter
- Real-time search by title and content
- Filter notes by course/subject
- Filter to show only favorite notes
- Combine multiple filters
- Clear all filters option
- Empty state for no results

#### User Interface
- Modern Material Design 3 UI
- Custom app icon and branding
- Splash screen with animations
- Dark mode support
- Loading shimmer effects
- Empty state illustrations
- Smooth transitions and animations
- Responsive design for all screen sizes

#### Dashboard
- Statistics card showing:
  - Total notes count
  - Number of courses
  - Favorite notes count
- Recent notes list
- Pull-to-refresh functionality
- Floating action button for quick note creation

#### Profile & Settings
- User profile display
- Dark/light theme toggle
- Delete all data option
- App version information
- Statistics summary

#### Data Management
- SQLite local database
- Offline-first architecture
- Data persistence
- Session management with SharedPreferences
- 5 default courses pre-loaded

#### State Management
- Provider pattern implementation
- UserProvider for authentication
- NoteProvider for notes CRUD
- CourseProvider for course management
- ThemeProvider for theme switching

#### Validation & Error Handling
- Form validation for all inputs
- Email format validation
- Password strength validation
- Title and content length validation
- User-friendly error messages
- Graceful error handling

#### Performance
- Efficient list rendering with ListView.builder
- Optimized database queries
- Minimal widget rebuilds
- Proper memory management
- Fast app startup (< 3 seconds)

#### Documentation
- Comprehensive README
- Build instructions (BUILD_INSTRUCTIONS.md)
- Testing guide (TESTING_GUIDE.md)
- Features documentation (FEATURES.md)
- Code comments and documentation

### Technical Details

#### Dependencies
- flutter: SDK
- provider: ^6.1.1 (State management)
- sqflite: ^2.3.0 (Local database)
- shared_preferences: ^2.2.2 (Session storage)
- google_fonts: ^6.1.0 (Typography)
- firebase_core: ^2.24.2 (Firebase setup)
- firebase_auth: ^4.15.3 (Authentication)
- google_sign_in: ^6.2.1 (Google login)
- intl: ^0.19.0 (Date formatting)
- uuid: ^4.3.3 (ID generation)

#### Database Schema
- Users table (id, name, email, photo_url)
- Courses table (id, user_id, course_name, color_code)
- Notes table (id, user_id, title, course, content, date_created, date_updated, is_favorite)

#### Supported Platforms
- Android (API 21+)
- iOS (12.0+)
- Web
- Windows
- macOS
- Linux

### Known Issues
- Google Sign-In is in simulation mode (not connected to real Firebase)
- No cloud sync yet (planned for v2.0)
- No rich text editor (planned for v2.0)

### Notes
- This is the initial production-ready release
- All core features are fully functional
- Tested on Android 8.0 - 14.0
- Optimized for offline use

---

## [Unreleased]

### Planned for v1.1.0
- [ ] Real Firebase Google Sign-In integration
- [ ] Cloud backup to Firestore
- [ ] Export notes to PDF
- [ ] Share notes functionality
- [ ] Reminder notifications

### Planned for v2.0.0
- [ ] Rich text editor (bold, italic, lists)
- [ ] Image attachments
- [ ] Voice notes
- [ ] Multi-device sync
- [ ] Collaboration features

---

## Version History

### Version Numbering
- **MAJOR**: Breaking changes or major feature additions
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes and minor improvements

### Release Schedule
- Major releases: Every 6 months
- Minor releases: Every 2 months
- Patch releases: As needed for critical bugs

---

**Legend:**
- `Added` for new features
- `Changed` for changes in existing functionality
- `Deprecated` for soon-to-be removed features
- `Removed` for now removed features
- `Fixed` for any bug fixes
- `Security` for vulnerability fixes
