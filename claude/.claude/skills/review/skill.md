---
name: review
description: Apply code review comments from .code-review.md. Use when the user says "review", "apply review", "apply comments", or invokes /review.
---

# Apply Code Review

Read `.code-review.md` in the current working directory and apply every review comment.

## Workflow

1. Read `.code-review.md`
2. For each comment section:
   - Note the file path and line range from the heading (e.g. `src/main.rs:10-15`)
   - Read the referenced file to understand the current code in context
   - Apply the change described in the comment text
3. After processing ALL comments, ALWAYS delete `.code-review.md` — even if some comments were skipped or required no changes
4. Summarize what was done, one line per comment (applied, skipped, or already resolved)

## Rules

- Apply comments in order, top to bottom
- Read enough surrounding context to make correct edits — don't blindly match only the snippet
- If a comment is ambiguous, make your best judgment and note it in the summary
- If a comment cannot be applied (file missing, code already changed), mark it as resolved and move on
- Do not make changes beyond what the review comments ask for
- Deleting `.code-review.md` at the end is mandatory — it signals the review is complete

