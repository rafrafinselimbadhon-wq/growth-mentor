# Growth Mentor — Agentic Layer

## Draftable Actions (Low Risk — Auto)
| Action | Trigger | Output |
|---|---|---|
| Auto-score goal entry | Activities logged this week | Suggested 1–10 score (draft, user confirms) |
| Draft weekly reflection | Scorecard submitted | 2–3 sentence summary (user edits) |
| Tag activity category | Activity logged without category | Suggested category (auto-applied) |

## Executable After Approval (Medium Risk)
| Action | Trigger | Approval |
|---|---|---|
| Mark goal as completed | Scorecard entry ≥ 9 for 3 consecutive weeks | User confirms |
| Suggest new goal | Vision updated or gap detected | User accepts/declines |

## Human-Only Actions (Critical)
| Action | Reason |
|---|---|
| Delete a goal | Data loss |
| Delete a scorecard | Data loss |
| Delete a vision | Cascading data loss |

## Named Tools
- `suggest_score(goal_id, week_activities[])` — returns score 1–10
- `draft_reflection(scorecard_id)` — returns text
- `suggest_category(description)` — returns category enum

No raw `run_any` / `send_any` tools. Approved named tools only.

## Audit Log Fields
`id, actor, action, target_type, target_id, before_value, after_value, created_at`

## v1 vs Later
- **v1:** No agentic actions. All input is manual.
- **Later:** Draftable auto-scoring + reflection drafting. Approval actions after that.
