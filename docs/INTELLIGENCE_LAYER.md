# Growth Mentor — Intelligence Layer

## Messy Inputs
User types free-form: "I read 3 leadership books this week" or "felt tired, skipped gym twice." AI parses these into structured activities or scorecard notes.

## Auto-Structure Schema (JSON)
```json
{
  "goal_id": "uuid or null",
  "category": "education",
  "description": "Read 3 leadership books",
  "suggested_score": 8,
  "confidence": 0.85
}
```

## Events to Track
- `scorecard.created` — new scorecard submitted
- `scorecard.score_changed` — overall score delta vs last week
- `activity.logged` — new activity against a goal
- `goal.created` / `goal.completed`

## Scoring Rules (v1 — rule-based, no AI needed)
- **Per-goal entry score:** user enters 1–10 directly.
- **Overall weekly score:** `avg(entry.progress_score)` across all entries in the scorecard, rounded to 1 decimal.
- **Trend:** compare this week's overall_score to last week's → up / down / flat.
- **Category score:** `avg(entry.progress_score)` grouped by goal.category.

## What Gets Ranked
- Goals by recent scorecard performance (lowest-scoring goals surface first for attention).
- Categories by weekly trend (which track is declining).

## v1 vs Later
- **v1:** All scoring is user-entered + rule-based averages. No AI.
- **Later:** AI auto-suggests per-goal scores from logged activities; AI drafts weekly reflection; AI structures free-form goal input into categorized goals.
