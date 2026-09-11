# Growth Mentor — Security

## Secret Handling
- Supabase URL + anon key: public-safe, exposed to frontend via `NEXT_PUBLIC_` env vars.
- Supabase service role key: server-only, never in frontend code, never in client bundles.
- Any future AI API keys: server-only, stored in Vercel env, accessed only in `lib/ai/`.

## Permission Model
- **v1 (demo):** Permissive RLS — all tables readable/writable without auth. Seeded demo data renders for anonymous visitors.
- **Lock-down sprint:** Enable Supabase Auth (email). Replace permissive policies with owner-scoped: `auth.uid() = user_id` on every table. Anonymous users see nothing.
- Agent (later) inherits the logged-in user's permissions — never broader.

## Approved-Tools Rule
- AI may only call named, allow-listed tools (`suggest_score`, `draft_reflection`, `suggest_category`).
- No raw SQL execution, no arbitrary code execution, no external API calls beyond the configured AI provider.

## Audit Principle
- Every scorecard submission, goal status change, and (later) AI-suggested action is logged to `audit_logs` with actor, action, target, before/after values, timestamp.
- Audit logs are append-only; RLS restricts reads to the owning user after lock-down.
