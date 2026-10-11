# Task Breakdown: [feature / epic]

**Parent spec:**
**Feature spec:**
**Inventory:** `inventory.md` in this folder, if the feature changes existing code. Otherwise "none".
**Owner:**

> One rule governs this document: **if a task can't be verified on its own, it's two tasks.**
> Everything else here is bookkeeping.

## Tasks

### [ID]-01: [objective]

- **Status:** Not started | In flight | Done | Blocked, and on what
- **Objective:** one sentence. What is true when this is done that wasn't before.
- **Implements:** FR1, FR3 *(from the spec)*
- **Satisfies:** AC1, AC2 *(from the feature spec)*
- **Depends on:** none
- **Effort:** S | M | L
- **Risk:** Low | Medium | High, and why, if not low.
- **Needs a human:** Yes | No, decisions requiring judgement, taste, or authority this task
  can't have.
- **Out of scope for this task:** things that belong to a sibling task and must not be done here
  opportunistically.

**Brief** *(what an agent needs to start without exploring)*

- **Read:** `path/to/file::function`, one per line, and inventory rows by number. Name
  functions, not line numbers: line numbers are wrong by the time the task before this one has
  landed.
- **Touch:** the files this task may change, and any it may create. Anything else is out of scope.
- **Prove:** the command that runs only this task's tests, and the pattern that shows pass or fail.
- **Model:** small | mid | top. Defaults from Effort (S mid, M top); set it only when the task is
  harder or easier than its size, and say why.

**Done when:**
- [ ] Every listed AC has a test that asserts it.
- [ ] No files touched outside **Touch**.
- [ ] Decision log updated if anything non-obvious was chosen.
- [ ] **Status** set to Done, with the commit.

---

### [ID]-02: [objective]

*(repeat)*

---

## Dependency order

```
[ID]-01
   |
   +--> [ID]-02 ---+
   |               |
   +--> [ID]-03 ---+--> [ID]-04
```

## Sizing guidance

- **S:** one sitting, one concern, obvious when it's done.
- **M:** a day, might touch two areas, still one clear objective.
- **L:** **this is not a task.** Break it down. "L" exists on this template only so you can
  recognise it and delete it.

## Traps

- A task that says "and" in its objective is two tasks.
- A task with no ACs is not a task, it's a hope.
- A task nobody can verify without the author present will be marked done and will not be done.
- Tasks that only make sense in sequence hide their dependencies. Draw the graph.
- A brief that says "see the module" is not a brief. It is an instruction to explore, and
  exploring is where the tokens go.
- A task whose Read list is longer than about eight entries is probably two tasks, or the
  inventory hasn't been done.
