# Growth Mentor — Test Plan

## v1 Success Scenario (Manual)
1. Open app (no login) → sidebar shows Vision, Goals, Activities, Scorecards
2. Vision page → see seeded 10-year Vision; edit title → persists on refresh
3. Goals page → see seeded goals across categories; create a new long-term goal (category: health) → appears in list
4. Activities page → log an activity against the new goal → persists
5. Scorecards page → click "New Scorecard" → see one row per active goal
6. Enter scores (e.g., 8, 6, 9) + notes → submit
7. See overall score (avg = 7.7) + trend (first scorecard: "baseline")
8. Create a second scorecard for next week with different scores → trend shows up/down/flat
9. Scorecard history list shows both weeks with scores

## Empty States
- No Vision set → Vision page shows prompt to create one
- No Goals → Goals page shows "Create your first goal" with category picker
- No Activities → Activities page shows "Log your first activity"
- No Scorecards → Scorecards page shows "Start your first weekly scorecard"

## Error States
- Supabase unreachable → error boundary shows retry button
- Scorecard submit with zero entries → validation error: "Add at least one goal before submitting"
- Duplicate week_start_date → error: "Scorecard already exists for this week"

## Loading States
- All list pages show skeleton rows while fetching
- Scorecard submit shows spinner, disables button

## Permission Check (Post Lock-Down)
- Unauthenticated → redirect to login
- User A logs in → cannot see User B's goals/scorecards
