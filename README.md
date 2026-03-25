# DeduzAí

> Track tax-deductible expenses year-round so you never miss a deduction at income tax time.

DeduzAí is a Flutter mobile app (iOS + Android) for Brazilian taxpayers to capture deductible expenses at the moment they occur. At declaration time (March–April), your annual summary is ready to export.

---

## Features

- **Manual expense entry** — Log expenses with category, amount, date, and description
- **OCR receipt scanning** — Point the camera at a receipt and let ML Kit extract the amount automatically
- **CNPJ auto-categorization** — Recognizes known vendors by CNPJ and pre-fills the deduction category
- **Receipt gallery** — Browse and view receipt images linked to each expense
- **Annual summary** — Totals broken down by deductible category with deduction cap indicators
- **PDF & CSV export** — Share your annual summary directly from the app
- **Smart reminders** — Local notifications nudge you to log expenses on business days

### Deductible categories

| Category | Description |
|---|---|
| Saúde | Medical, dental, hospital |
| Educação | Schools, courses (capped at R$ 3.561,50/yr) |
| Pensão alimentícia | Court-ordered alimony |
| Previdência privada | Private pension (PGBL) |
| Dependentes | Dependents |

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3 (Dart) |
| State management / DI | Riverpod (`flutter_riverpod` + `riverpod_annotation`) |
| Local database | Drift (SQLite ORM) |
| Domain models | Freezed (immutable, JSON-serializable) |
| Navigation | GoRouter |
| OCR | Google ML Kit Text Recognition |
| Export | `pdf` + `csv` packages |
| Notifications | `flutter_local_notifications` |

---

## Architecture

Feature-first Clean Architecture with Riverpod as the DI system.

```
lib/
├── app/              # App wiring: bootstrap, GoRouter, flavors, app shell
├── core/             # Shared: Drift DB, theme, domain models, utils
│   ├── database/     # Tables, DAOs, AppDatabase
│   ├── domain/       # Immutable models (Expense, Receipt, Category…)
│   └── theme/        # Colors, text styles, spacing
└── features/         # Feature modules
    ├── annual_summary/
    ├── expense_entry/
    ├── expense_list/
    ├── notifications/
    ├── receipt_gallery/
    └── settings/
```

**Data flow:**
```
Screen (ConsumerWidget) → Provider (Riverpod) → Domain Service → Repository → Drift DB
```

**Key decisions:**

- All money amounts stored as `int` (centavos) — no floating-point
- Soft deletes via `deletedAt` column; all queries filter `deleted_at IS NULL`
- Client-side UUIDs for offline-first support
- Receipt images stored as files in the app documents directory; only the path is saved in the DB
- Fully offline in V1 — no backend, no network required

---

## Getting Started

**Prerequisites:**

- Flutter SDK ≥ 3.11.3
- Dart SDK ≥ 3.x
- Xcode (iOS) or Android Studio (Android)

```bash
# Clone
git clone <repo-url>
cd deduzai

# Install dependencies
flutter pub get

# Run code generation (Freezed, Drift, Riverpod)
dart run build_runner build --delete-conflicting-outputs
```

---

## Development

### Run

```bash
# Dev flavor (mock OCR, logging enabled)
flutter run --target lib/main_dev.dart

# Staging flavor (real OCR, logging enabled)
flutter run --target lib/main_staging.dart

# Production flavor
flutter run --target lib/main_prod.dart
```

### Code generation

```bash
# One-shot
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs
```

### Analyze & test

```bash
flutter analyze

flutter test                          # All tests
flutter test test/widget_test.dart    # Single file
flutter test --name "pattern"         # By name pattern
```

---

## Flavors

| Flavor | Logging | OCR |
|---|---|---|
| `dev` | enabled | mock |
| `staging` | enabled | real (ML Kit) |
| `prod` | disabled | real (ML Kit) |

---

## Roadmap

| Version | Scope |
|---|---|
| **V1 (current)** | 100% local, offline-first, SQLite via Drift |
| **V2 (planned)** | Cloud sync, remote auth, multi-device support |

---

## License

Private — all rights reserved.
