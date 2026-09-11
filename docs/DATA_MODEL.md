# Growth Mentor — Data Model

## visions
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid nullable |
| title | text not null |
| description | text |
| target_date | date |
| created_at | timestamptz default now() |

One Vision has many Goals.

## goals
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid nullable |
| vision_id | uuid → visions.id |
| title | text not null |
| category | text (health, soft_skills, education, career) |
| timeframe | text (short, long) |
| status | text default 'active' |
| target_date | date |
| created_at | timestamptz default now() |

## activities
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid nullable |
| goal_id | uuid → goals.id |
| description | text not null |
| logged_date | date not null |
| created_at | timestamptz default now() |

## scorecards
| Field | Type |
|---|---|
| id | uuid pk |
| user_id | uuid nullable |
| week_start_date | date not null |
| overall_score | numeric |
| overall_score_source | text |
| overall_score_confidence | numeric |
| overall_score_review_status | text default 'unreviewed' |
| reflection | text |
| created_at | timestamptz default now() |

AI fields: overall_score (value+source+confidence+review_status) — AI auto-score in later sprint.

## scorecard_entries
| Field | Type |
|---|---|
| id | uuid pk |
| scorecard_id | uuid → scorecards.id |
| goal_id | uuid → goals.id |
| progress_score | int (1–10) not null |
| notes | text |
| ai_summary | text |
| ai_summary_source | text |
| ai_summary_confidence | numeric |
| ai_summary_review_status | text default 'unreviewed' |
| created_at | timestamptz default now() |

AI fields: ai_summary (value+source+confidence+review_status) — later sprint.

## RLS / Permissions
All tables: RLS enabled, permissive read/write policies for v1 demo. Lock-down sprint replaces with `auth.uid() = user_id` owner-scoped policies.
