# File Size and Complexity Limits

Review signals for Revo Olympics code. Exceeding a **hard review threshold** requires refactor or explicit review justification in the pull request.

## Dart (Flutter)

| File type | Target | Hard review threshold |
|-----------|--------|----------------------|
| Widget | 200 lines | 300 lines |
| Screen | 250 lines | 400 lines |
| Controller / state | 250 lines | 400 lines |
| Repository | 250 lines | 400 lines |
| Model | 200 lines | 300 lines |
| Service | 300 lines | 500 lines |
| Test file | 400 lines | 700 lines |

## Unity C#

| File type | Target | Hard review threshold |
|-----------|--------|----------------------|
| MonoBehaviour | 250 lines | 400 lines |
| Plain service | 300 lines | 500 lines |
| Data model | 200 lines | 300 lines |
| Editor script | 350 lines | 600 lines |
| Test file | 400 lines | 700 lines |

## TypeScript (Cloud Functions)

| File type | Target | Hard review threshold |
|-----------|--------|----------------------|
| Function handler | 150 lines | 250 lines |
| Service | 300 lines | 500 lines |
| Repository | 250 lines | 400 lines |
| Model / schema | 200 lines | 300 lines |
| Test file | 400 lines | 700 lines |

## Method / function complexity

- Target length: under 40 lines
- Mandatory review: above ~60 lines
- Maximum nesting depth: 3 levels
- Prefer fewer than 6 parameters; use parameter objects when needed
- One responsibility per function

## When to refactor

- Multiple unrelated classes in one file
- UI, business logic, and persistence mixed
- Repeated conditional logic or deep nesting
- Many constructor dependencies or boolean flags
- Protocol parsing mixed with game logic

## Prohibited splitting

Do not create one-line wrappers, meaningless interfaces, or micro-classes solely to pass line counts.

## Cursor rule

See `.cursor/rules/11-file-size-and-complexity-rules.mdc`.
