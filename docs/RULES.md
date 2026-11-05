# Rules (95S)

The rules for this repo's part of the alignment, then the learned rules. Read before every unit. Any tool adds a learned
rule in the same commit as the fix that confirmed it, newest last: `- YYYY-MM-DD <area>: <rule>. (<evidence>)`.

## Who decides what (all games)

| Category | Decided by |
|---|---|
| Name of a routine several games share | the earliest game that has it (92G is the root); a fix goes to the earliest repo first, then down the lineage |
| Name of a feature new in year N | that year's Genesis game (94G for 94S and 94PC, 95G for 95S and 95PC) |
| Name of a platform-only job | the earlier repo on that platform (94S for 95S, 94PC for 95PC), else what the code does |
| Same name, different job | the earlier meaning keeps the name |
| Top folder or file | the same-year Genesis file |
| RAM order | the merged order (92G, 93G, 94G, 93S, 94S, then 95G, 96G) |
| Data, assets, banks | the earlier repo on the same platform |
| Order inside a file | ROM order (the report re-sorts for display) |
| History | `docs/name_map.csv` only, never source comments |

## This repo

- Code base: 95S is a separate engine, not 94S code (the unpacker, transfer queues and sound driver differ). A 94S or 95G name
  needs the same job, read from both bodies; bytes rarely match.
- Folders: `src/routines/<95G group>/<95G file key>/<Routine>.asm`, one routine per file, mirroring NHL95Genesis: `engine/`
  (`collide`, `faceoff`, `fourway`, `goal`, `input`, `lines`, `logic`, `middle`, `pause`, `penalty`, `players`, `playoff`,
  `replay`, `setup`, `skate`, `video`), `front/` (`awards`, `create`, `crowd`, `injury`, `records`, `scout`, `season`,
  `shootout`, `stats`, `summary`, `title`, `trade`), and the 95G top files as folders directly under `src/routines/` (`main`,
  `hockey`, `control`, `display`, `graphics`, `schedule`, `sram`, `teamdata`, `frames`, `credits`). Decided 2026-11-03 for
  now; the owner may revisit it after comparing 94G/94S with 95G, so moves stay scripted from `docs/routines95s.csv`.
- Placement, in order: the 95G file of the routine's 95G partner; for an SNES-only engine job (NMI/IRQ, DMA and HDMA queues,
  the unpacker, SPC upload, map-set loaders) the 94S folder for that job: `sound/`, `decompress/` and `main/` sit directly
  under `src/routines/`, while `video` and `middle` are 95G keys under `engine/`; else the folder most of its callers are in; else Unsure, placed by the owner.
- Names: the pipeline names every routine, and alignment with the related repos overrides the names already in 95S, including
  earlier contributors' (owner, 2026-11-03). A routine with a 95G partner takes the 95G name; an SNES job with no 95G partner
  takes the 94S name when the job matches; else the current 95S name stays if it says what the code does; unsure keeps its
  current name and goes under Unsure. Every rename is a `docs/name_map.csv` row with the old name and the evidence. When 95G
  and 94S use one name for different code, the SNES-only job keeps 94S's (VBlank).
- Comments: a source comment may name another game only to say what 95S lacks or shares (a stub where 94S prints, a
  table as 94S's); name history stays in `docs/name_map.csv`. `check_comments.py` checks layout only, not this.
- Data and banks follow 94S: one asset per file under `src/data/{tables,gfx,sound,text}/`, `src/banks/bCx_<content>.asm` in
  ROM order.

## Learned
- 2026-11-03 branch: all work goes onto `claude/project-thread-ggw7zu` and nothing merges to `main` yet; push there without asking once the checks pass, and stop only at the plan's review checkpoints. (owner)
- 2026-11-03 placement: a `#Label` operand (task and hook pointers) is a reference; without it 64 routines looked unreferenced. Engine services (interrupts, transfers, fades, sprites, print, work buffers, math, pads, tasks) are placed as whole families by job, not by callers, which scatter them over the screens that use them. (inventory95.py, 97 UNSURE to 0)
- 2026-11-03 names: 95S is mostly its own design; of about 1,000 routines without a 95G name, readers found 32 sure partners. Screens built differently (season, records, create, setup UI, sprite and task systems) keep their 95S names; a loop in 95G that 95S does one row at a time is not the same routine. (phase 4 namer pass)
- 2026-11-03 names: every rename writes `old_name` in `docs/name_map.csv` and repoints the report's known pair, or the pairing gate loses the pair. (phase 4)
- 2026-11-03 RAM: a RAM equate may differ from a code label only in case (fadein and FadeIn, as in 94S); asar names are case-sensitive and an equate has no file. (deep dive, rename95.py)
- 2026-11-03 placement: a 94S name gives a 95S routine its name, not its folder, unless the job is SNES-only; DrawPeriodStats had taken 94S's `period/` folder. (phase 6 review)
- 2026-11-03 names: a shared name that differs from the earliest game's (93S / 94S waitxsr where 93G and 94G have waitx) is fixed in the earliest repo that differs, then down the lineage. (phase 6 review; done in 93S and 94S)
- 2026-11-04 contributing: CONTRIBUTING.md must not contradict History: lineage lives only in the name history file, never in source comments. (CONTRIBUTING rewrite vs RULES History row)
- 2026-11-05 names: CreditsList is 93G CreditsPages (same title-screen credit pages as 95G, packed pointers). File kept CreditsList.asm (rename lens, no move). (owner)
