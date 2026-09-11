# Growth Mentor — Task Plan

## Sprint 1 — Foundation + Core CRUD (Demo-First)
**Goal:** App renders with seed data; user can manage Vision, Goals, Activities.
- [ ] Supabase schema + seed data (migration SQL)
- [ ] Data-access layer (`lib/data/`): queries for all 5 tables
- [ ] Vision page: list (single), create, edit
- [ ] Goals page: list by category, create, edit, status toggle
- [ ] Activities page: list, create, delete
- [ ] Responsive sidebar nav shell
- [ ] Five states handled: loading, empty, error, partial, ready
**Done:** Anonymous visitor sees seeded Vision + Goals + Activities; can create/edit/delete each — all persisted to Supabase.

## Sprint 2 — Weekly Scorecard Engine (v1 Functional Milestone)
**Goal:** The one core workflow works end-to-end.
- [ ] "New Scorecard" button → pulls active goals
- [ ] Scorecard entry form: one row per goal, 1–10 score + note
- [ ] On submit: persist scorecard + entries; compute overall_score server-side
- [ ] Scorecard list view (history) with overall score + trend vs last week
- [ ] Scorecard detail view (read entries)
- [ ] Category breakdown display
**Done:** User creates a weekly scorecard, rates each goal 1–10, sees overall score + trend — success scenario fully usable.

## Sprint 3 — Polish + Hardening
**Goal:** App feels production-ready for builder + students.
- [ ] Empty-state guidance copy on all pages
- [ ] Error boundaries + retry on data fetch failure
- [ ] Scorecard week validation (one per week_start_date)
- [ ] Goal status: archive (excludes from new scorecards)
- [ ] Responsive polish, keyboard nav
**Done:** No dead buttons, no seed-only screens, all CRUD + scorecard engine verified.

## Sprint 4 — Lock It Down (Auth + RLS)
**Goal:** Per-user data isolation.
- [ ] Supabase Auth (email/password)
- [ ] Login/signup pages
- [ ] Replace permissive RLS with `auth.uid() = user_id` on all tables
- [ ] Seed data tagged with demo user_id
- [ ] Redirect unauthenticated users to login
**Done:** Each user sees only their own data; anonymous access removed.

## Sprint 5 — AI Auto-Scoring + Reflection (Later)
**Goal:** Intelligence layer on top of the working core.
- [ ] `lib/ai/` module: suggest_score, draft_reflection, suggest_category
- [ ] AI-suggested score appears as draft next to manual input
- [ ] AI-drafted reflection on scorecard submit (editable)
- [ ] Store AI fields (value+source+confidence+review_status)
- [ ] Audit log for AI actions
**Done:** AI enhances but never replaces manual scoring; app still works with AI disabled.

## Gantt
```
S1: Foundation + CRUD      ████
S2: Scorecard Engine       ████
S3: Polish + Hardening     ████
S4: Lock Down (Auth/RLS)   ████
S5: AI Layer               ████
```
