# Growth Mentor — Architecture

## Stack
Next.js (App Router) · Supabase (Postgres) · Vercel deploy.

## Build Now vs Later
**Now:** Vision CRUD, Goal CRUD, Activity logging, Weekly Scorecard generation + scoring + history.
**Later:** Auth/RLS lock-down, AI auto-scoring, AI goal-structuring, trend charts, reminders.

## Key User Action Flow (Weekly Scorecard)
1. User opens app → sees Vision + active Goals (from DB)
2. User clicks "New Scorecard" → system pulls active goals + recent week's activities
3. For each goal, user enters a 1–10 progress score + optional note
4. On submit → Scorecard + Entries persist to DB
5. Overall weekly score = average of entry scores, stored server-side
6. Scorecard history list shows past weeks with trend (up/down/flat vs last week)

## Responsive Nav Shell
Persistent left sidebar on desktop (Vision, Goals, Activities, Scorecards), collapses to hamburger on mobile. Current section highlighted.

## Layer Plan
1. **Data layer** — Supabase tables, RLS permissive for demo, data-access module (`lib/data/`).
2. **App logic** — Server actions for CRUD + scorecard computation (`lib/actions/`).
3. **Smart features** — AI auto-scoring and goal structuring in `lib/ai/` (later sprint).

## Core Runs Without AI
Scorecard scoring is a plain average of user-entered 1–10 values, computed server-side. AI auto-scoring is an optional enhancement layered on top — disabled, the app still works fully.

## Repo Structure
```
app/                    # routes/pages per feature
  vision/
  goals/
  activities/
  scorecards/
components/             # shared UI
lib/data/               # ALL DB reads/writes
lib/actions/            # server actions
lib/ai/                 # AI module (later)
__tests__/              # beside code
```

## Module Map
| Module | Responsibility | Owns | Build Order |
|---|---|---|---|
| data | All DB access | visions, goals, activities, scorecards, scorecard_entries | 1st |
| vision | Vision CRUD UI + actions | visions table | 2nd |
| goals | Goal CRUD UI + actions | goals table | 2nd |
| activities | Activity logging | activities table | 3rd |
| scorecards | Weekly scorecard engine | scorecards, scorecard_entries | 3rd (core engine) |
| ai | Auto-scoring, goal structuring | AI fields on scorecards/goals | Last |
