-- Growth Mentor schema (demo-first, permissive RLS)

create table if not exists visions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  title text not null,
  description text,
  target_date date,
  created_at timestamptz not null default now()
);
alter table visions enable row level security;
drop policy if exists "visions_v1_read" on visions;
create policy "visions_v1_read" on visions for select using (true);
drop policy if exists "visions_v1_write" on visions;
create policy "visions_v1_write" on visions for all using (true) with check (true);

create table if not exists goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  vision_id uuid references visions(id) on delete cascade,
  title text not null,
  category text check (category in ('health','soft_skills','education','career')),
  timeframe text check (timeframe in ('short','long')),
  status text default 'active',
  target_date date,
  created_at timestamptz not null default now()
);
alter table goals enable row level security;
drop policy if exists "goals_v1_read" on goals;
create policy "goals_v1_read" on goals for select using (true);
drop policy if exists "goals_v1_write" on goals;
create policy "goals_v1_write" on goals for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  goal_id uuid references goals(id) on delete cascade,
  description text not null,
  logged_date date not null,
  created_at timestamptz not null default now()
);
alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists scorecards (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  week_start_date date not null,
  overall_score numeric,
  overall_score_source text,
  overall_score_confidence numeric,
  overall_score_review_status text default 'unreviewed',
  reflection text,
  created_at timestamptz not null default now()
);
alter table scorecards enable row level security;
drop policy if exists "scorecards_v1_read" on scorecards;
create policy "scorecards_v1_read" on scorecards for select using (true);
drop policy if exists "scorecards_v1_write" on scorecards;
create policy "scorecards_v1_write" on scorecards for all using (true) with check (true);

create table if not exists scorecard_entries (
  id uuid primary key default gen_random_uuid(),
  scorecard_id uuid references scorecards(id) on delete cascade,
  goal_id uuid references goals(id) on delete cascade,
  progress_score int not null check (progress_score between 1 and 10),
  notes text,
  ai_summary text,
  ai_summary_source text,
  ai_summary_confidence numeric,
  ai_summary_review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);
alter table scorecard_entries enable row level security;
drop policy if exists "scorecard_entries_v1_read" on scorecard_entries;
create policy "scorecard_entries_v1_read" on scorecard_entries for select using (true);
drop policy if exists "scorecard_entries_v1_write" on scorecard_entries;
create policy "scorecard_entries_v1_write" on scorecard_entries for all using (true) with check (true);

-- Seed: Vision
insert into visions (title, description, target_date)
select 'Become a Category-Defining Growth Leader', 'In 10 years I will have built and scaled a growth mentorship platform that helps 100,000 people achieve exponential personal growth across health, soft skills, education, and career.', '2035-01-01'
where not exists (select 1 from visions limit 1);

-- Seed: Goals
insert into goals (vision_id, title, category, timeframe, status, target_date)
select v.id, 'Run a half-marathon', 'health', 'short', 'active', '2025-06-01' from visions v where not exists (select 1 from goals limit 1);

insert into goals (vision_id, title, category, timeframe, status, target_date)
select v.id, 'Master public speaking', 'soft_skills', 'long', 'active', '2026-01-01' from visions v where not exists (select 1 from goals g where g.title = 'Master public speaking');

insert into goals (vision_id, title, category, timeframe, status, target_date)
select v.id, 'Complete advanced data science certification', 'education', 'short', 'active', '2025-09-01' from visions v where not exists (select 1 from goals g where g.title = 'Complete advanced data science certification');

insert into goals (vision_id, title, category, timeframe, status, target_date)
select v.id, 'Lead a team of 20+ in a growth-focused org', 'career', 'long', 'active', '2028-01-01' from visions v where not exists (select 1 from goals g where g.title = 'Lead a team of 20+ in a growth-focused org');

-- Seed: Activities
insert into activities (goal_id, description, logged_date)
select g.id, 'Ran 5km in 28 minutes', '2025-01-13' from goals g where g.title = 'Run a half-marathon' and not exists (select 1 from activities limit 1);

insert into activities (goal_id, description, logged_date)
select g.id, 'Delivered a 15-min presentation to 30 peers', '2025-01-15' from goals g where g.title = 'Master public speaking' and not exists (select 1 from activities a where a.description = 'Delivered a 15-min presentation to 30 peers');

insert into activities (goal_id, description, logged_date)
select g.id, 'Completed module 3 of data science course', '2025-01-14' from goals g where g.title = 'Complete advanced data science certification' and not exists (select 1 from activities a where a.description = 'Completed module 3 of data science course');

-- Seed: Scorecard (last week)
insert into scorecards (week_start_date, overall_score, overall_score_source, overall_score_confidence, overall_score_review_status, reflection)
select '2025-01-13', 7.5, 'manual', null, 'unreviewed', 'Solid week — health is on track but need more practice on public speaking.'
where not exists (select 1 from scorecards limit 1);

-- Seed: Scorecard entries
insert into scorecard_entries (scorecard_id, goal_id, progress_score, notes)
select sc.id, g.id, 8, 'Three runs this week, feeling strong.' from scorecards sc, goals g where sc.week_start_date = '2025-01-13' and g.title = 'Run a half-marathon' and not exists (select 1 from scorecard_entries limit 1);

insert into scorecard_entries (scorecard_id, goal_id, progress_score, notes)
select sc.id, g.id, 6, 'One presentation done but felt nervous.' from scorecards sc, goals g where sc.week_start_date = '2025-01-13' and g.title = 'Master public speaking' and not exists (select 1 from scorecard_entries se where se.notes = 'One presentation done but felt nervous.');

insert into scorecard_entries (scorecard_id, goal_id, progress_score, notes)
select sc.id, g.id, 9, 'Completed module 3 with full marks.' from scorecards sc, goals g where sc.week_start_date = '2025-01-13' and g.title = 'Complete advanced data science certification' and not exists (select 1 from scorecard_entries se where se.notes = 'Completed module 3 with full marks.');

insert into scorecard_entries (scorecard_id, goal_id, progress_score, notes)
select sc.id, g.id, 7, 'Mentored two junior team members.' from scorecards sc, goals g where sc.week_start_date = '2025-01-13' and g.title = 'Lead a team of 20+ in a growth-focused org' and not exists (select 1 from scorecard_entries se where se.notes = 'Mentored two junior team members.');