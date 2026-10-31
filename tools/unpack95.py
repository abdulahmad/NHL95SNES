#!/usr/bin/env python3
"""unpack95.py: a model of the NHL '95 SNES unpacker ($C581E1 and the formats of its jump table at $C58219).

A packed set is: a word with the unpacked size, a word with the format (0, 2, 4, 6 or 8), then the stream. For each address
this prints the format, the sizes and the end of the stream (the address after its last byte), which is where the next item
starts. With --out DIR it also writes the unpacked bytes to DIR/<address>.bin (never under src/ or lst/).

  python3 tools/unpack95.py lst/nhl95snes.sfc C00000 C0027E [--out output/unpacked]

Formats 0, 2 and 4 read a command byte: below $80, that many plus one literal bytes follow; $80 and up, a copy of earlier
output, and a copy length of 0 ends the stream. Format 0 copies (command & $7F) + 1 bytes from the absolute output offset in the
next word. Formats 2 and 4 copy ((command & $7F) >> 2 or >> 3) + 1 bytes from (low 2 or 3 command bits : next byte) back.
Formats 6 and 8 read a flag byte for each 8 items. Flag clear: a count byte, then that many literal bytes (count 0 ends the
stream). Flag set: two bytes, a copy of (first byte >> 3 or >> 4) + 3 bytes from (low 3 or 4 bits : second byte) back.
"""
import sys, os

def unpack(rom, o):
    """Unpack the set at file offset o. Returns (format, size from the header, unpacked bytes, end offset exclusive)."""
    size = rom[o] | rom[o + 1] << 8; fmt = rom[o + 2] | rom[o + 3] << 8; out = bytearray()
    if fmt in (0, 2, 4):
        p = o + 3                                       # the unpacker's pointer sits one byte before each command
        while True:
            cmd = rom[p + 1]
            if cmd < 0x80:
                n = cmd + 1; out += rom[p + 2:p + 2 + n]; p += 1 + n
                continue
            if fmt == 0:
                n = cmd & 0x7F
                if n == 0: return fmt, size, out, p + 2
                src = rom[p + 2] | rom[p + 3] << 8; p += 3
            else:
                sh = 2 if fmt == 2 else 3; n = (cmd & 0x7F) >> sh
                if n == 0: return fmt, size, out, p + 2
                src = len(out) - (((cmd & ((1 << sh) - 1)) << 8) | rom[p + 2]); p += 2
            for k in range(n + 1): out.append(out[src + k])
    if fmt in (6, 8):
        p = o + 3; sh = 3 if fmt == 6 else 4
        while True:
            p += 1; flags = rom[p]
            for bit in range(8):
                if flags >> bit & 1:
                    b = rom[p + 1]; n = b >> sh
                    src = len(out) - (((b & ((1 << sh) - 1)) << 8) | rom[p + 2]); p += 2
                    for k in range(n + 3): out.append(out[src + k])
                else:
                    n = rom[p + 1]
                    if n == 0: return fmt, size, out, p + 2
                    out += rom[p + 2:p + 2 + n]; p += 1 + n
    raise ValueError(f'unknown format {fmt}')

def main():
    args = sys.argv[1:]
    if len(args) < 2: sys.exit(__doc__)
    outdir = None
    if '--out' in args:
        i = args.index('--out'); outdir = args[i + 1]; del args[i:i + 2]; os.makedirs(outdir, exist_ok=True)
    rom = open(args[0], 'rb').read()
    for a in args[1:]:
        a = int(a, 16); o = a & 0x3FFFFF                   # HiROM: banks $C0-$CF (or $40-$4F) map straight to the file
        fmt, size, out, end = unpack(rom, o)
        ok = 'OK' if len(out) == size else f'MISMATCH (unpacked ${len(out):04X})'
        print(f'${0xC00000 | o:06X}: format {fmt}, size ${size:04X} {ok}, end ${0xC00000 | end:06X} ({end - o} bytes packed)')
        if outdir: open(os.path.join(outdir, f'{0xC00000 | o:06X}.bin'), 'wb').write(out)

if __name__ == '__main__':
    main()
