# Segment prompt

Paste this into a new agent session. One segment per prompt. Do not edit this prompt.

```text
Read START_HERE.md, SEGMENT_AGENT.md and CONTRIBUTING.md before you write any asm. SEGMENT_AGENT.md is the queue and the history. Take the first segment in the ROM map that is still incbin. That file is the only segment this session.

NHL '95 SNES is NHL '94 SNES plus the NHL 95 Genesis features. Names follow the lineage in the Current rules section of SEGMENT_AGENT.md: code that matches NHL94SNES takes its name (94S names already carry 93S, 94G, 93G and 92G), 95 features take the NHL95Genesis name, else a name from what the code does. Match by purpose, not identical code; the earlier game's name wins.

1. Run ./build.sh first. It must print MATCH before you change anything. If it does not, stop and report.
2. Disassemble the segment's bytes (start from NHL94SNES tools/disasm65816.py, adapted to HiROM: banks $C0-$CF, code runs from the $80-$8F FastROM mirror at $8000-$FFFF and from $C0-$CF) and put the text into src/<segment>.asm in place of its incbin. Keep the org.
3. Trace the code: follow M/X (rep/sep/php/plp), D and DB. Turn unresolved db into instructions where code is reached, and into labeled data, dw/dl pointer tables, strings or incbin assets where it is data.
4. Name everything in the segment: routines, local labels (92 style), RAM variables, constants, tables. Follow the style rules. Labels another segment uses that are still incbin get an equate in this segment's stub only; labels this segment uses from other segments get an equate in src/stubinc/<segment>_stub.asm.
5. Run ./build.sh after each batch of edits. It must print MATCH. Then sh tools/verify_segment.sh <segment> must print MATCH (segment built on its own from its stub).
6. In SEGMENT_AGENT.md mark the row matched with the range and the main names; add a History line; set Current segment to the next row. Update docs/HANDOFF.md. Commit and push to main.

Stop after 5 failed builds in a row. Report the file, the first differing ROM offset, the built byte, the retail byte, and the line you wrote. Do not continue.
```
