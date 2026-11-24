# NHL 95 SNES: the manual's features and the code behind them

The manual's feature list is a lead; the code is what shows the feature is there. Pages are the archive.org scan
(SNESManuals), PDF p.N. Written 2026-11-24.

## New in 95 (manual PDF p.2)

| Manual line | Code |
| --- | --- |
| 1993-94 rosters and ratings | not confirmed in code |
| Season play | not confirmed in code |
| Practice mode | `PracticeOptions` (src/data/tables/) |
| Player creation | `CreatePlayer` (src/routines/front/create/) |
| League leaders | `LeagueLeadersScreen` (src/routines/front/stats/) |
| Player trades | `CheckTrade` (src/routines/front/trade/) |
| Accumulated stats | not confirmed in code |
| Battery backup | `CartHeader` (src/data/tables/ExtHeader.asm) |

## Other features

- Practice: "up to two skaters (plus goalie) per side" (PDF p.5). Code: `PracticeOptions` has Home Players and
  Visitor Players rows.
- Shootout: not listed in this manual, but the code has one (`ShootoutWonBy`, src/routines/front/shootout/).
- Penalty shots for a penalty on the breakaway man (PDF p.9): `PenShotChk` (src/routines/front/shootout/).
- Manual goalie control (PDF p.3): not confirmed in code here.
- Super Multitap: not in this manual, but the code has it: `Multi5Init`, `Multi5ConnectCheck` (src/routines/engine/middle/).
- One-timers (PDF p.8): `PassReceiverOneTimer` (src/routines/engine/logic/).
