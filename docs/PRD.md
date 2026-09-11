# Growth Mentor — PRD

## Problem
Most goal trackers optimize for incremental progress, keeping users in safe, linear cycles. Growth Mentor anchors every goal to a 10-year Vision, forcing exponential (10x) thinking. The core engine is a weekly scorecard that rates real progress across goals, health, soft skills, and education — replacing an expensive human coach.

## Target User
The builder and their students. Individuals pursuing intentional, exponential personal growth who need a structured weekly accountability loop.

## Core Objects
- **Vision** — 10-year north-star statement (the system's primary constraint)
- **Goal** — short-term or long-term, categorized: health, soft_skills, education, career
- **Activity** — a logged action toward a goal (the raw input)
- **Weekly Scorecard** — one per week; aggregates per-goal progress scores + overall score + reflection
- **Scorecard Entry** — one line per active goal inside a scorecard (score 1–10, notes)

## MVP (v1) — Checklist
- [ ] Create/edit a Vision statement
- [ ] Create/edit Goals (short/long, categorized, linked to Vision)
- [ ] Log Activities against goals
- [ ] Generate a weekly Scorecard: one entry per active goal, rate 1–10, add notes
- [ ] See overall weekly score + trend
- [ ] View scorecard history
- [ ] Seed demo data so app renders for anonymous visitors

## Non-Goals (v1)
- No login/auth (demo-first; lock-down is later sprint)
- No human-in-the-loop coaching check-ins
- No notifications/reminders
- No social/sharing
- No mobile app (responsive web only)

## Success Criteria
A user opens the app, sees their 10-year Vision, reviews last week's scorecard, logs new activities, creates this week's scorecard, rates each active goal 1–10, and sees their overall weekly score with a trend indicator — all without signing in.
