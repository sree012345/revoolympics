# Approved Cursor Prompts

Version-controlled prompts for Cursor AI development sessions.

Store reviewed sprint prompts here after stakeholder approval.

## Usage

1. Copy approved prompt for the active sprint
2. Reference product rules in `docs/product/`
3. Do not bypass code review for generated changes

## Prompts

| Sprint | File |
|--------|------|
| F0.1 | Documented in sprint plan — product rules created |
| F0.2 | Documented in sprint plan — competition rules created |
| F0.4 | Repository structure sprint |
| F0.6 | Reusable templates in [cursor/](./cursor/) |

## Cursor prompt templates (F0.6)

| Template | Use |
|----------|-----|
| [flutter_feature_prompt.md](./cursor/flutter_feature_prompt.md) | New Flutter feature work |
| [unity_game_system_prompt.md](./cursor/unity_game_system_prompt.md) | Unity gameplay systems |
| [firebase_function_prompt.md](./cursor/firebase_function_prompt.md) | Cloud Functions |
| [firestore_rules_prompt.md](./cursor/firestore_rules_prompt.md) | Security rules |
| [bug_fix_prompt.md](./cursor/bug_fix_prompt.md) | Focused bug fixes |
| [refactoring_prompt.md](./cursor/refactoring_prompt.md) | Safe refactors |
| [code_review_prompt.md](./cursor/code_review_prompt.md) | AI-assisted review |

Add sprint-specific prompts as: `{sprint-id}-{short-name}.md`
