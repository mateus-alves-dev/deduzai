# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**DeduzAí** — a Flutter mobile app (iOS + Android) for Brazilian taxpayers to track tax-deductible expenses year-round. Core idea: capture expenses at the moment they occur so users maximize deductions when filing their annual income tax return (Imposto de Renda, modelo completo).

## Build & Development Commands

```bash
# Run (dev flavor)
flutter run --target lib/main_dev.dart

# Run (staging/prod)
flutter run --target lib/main_staging.dart
flutter run --target lib/main_prod.dart

# Code generation (Freezed, Drift, Riverpod)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for codegen during development
dart run build_runner watch --delete-conflicting-outputs

# Analyze
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Run tests matching a name pattern
flutter test --name "App renders"
```

## Architecture

**Feature-first Clean Architecture** with Riverpod for state management and DI.

```
lib/
├── app/          # App wiring: bootstrap, router (GoRouter), flavors, app shell
├── core/         # Shared: database (Drift/SQLite), theme, domain models, utils
└── features/     # Feature modules, each with data/domain/presentation layers
```

**Data flow:** Screen (ConsumerWidget) → Provider (Riverpod) → Domain Service (pure Dart) → Repository → Drift DB (local)

### Key Technical Decisions

- **State management:** Riverpod (flutter_riverpod + riverpod_annotation). No get_it — Riverpod is the DI system.
- **Database:** Drift (SQLite ORM). Offline-first. In-memory DB for tests via `AppDatabase.forTesting()`.
- **Models:** Freezed for immutable domain models with JSON serialization.
- **Navigation:** GoRouter with ShellRoute for bottom nav. Camera route is fullscreen dialog outside shell.
- **Money:** All amounts stored as `int` (centavos) to avoid floating-point issues.
- **Soft deletes:** `deletedAt` column on expenses. All DAO queries filter `deleted_at IS NULL`.
- **Client-side UUIDs:** Expenses get UUIDs locally for offline-first support.
- **Receipt images:** Stored as files in app documents dir, only path in DB.
- **Three flavors:** dev, staging, prod — separate entrypoints (`main_dev.dart`, etc.)

## Domain Context

- **Deductible categories:** Saúde, Educação, Pensão alimentícia, Previdência privada, Dependentes
- **Tax calendar:** Brazilian fiscal year = calendar year. Declaration period is March–April.
- **LGPD compliance** — minimize CPF and sensitive data storage.
- Receipts retained minimum 5 years.
- Education deduction annual cap: R$ 3.561,50 (stored as config data, not hardcoded).

## Language Convention

UI strings: **Brazilian Portuguese**. Code, commits, docs: **English**.
