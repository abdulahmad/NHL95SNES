#!/usr/bin/env python3
"""names95.py: the licensed names of the team database, kept out of the source (run by tools/prebuild.py before every build).

  python3 tools/names95.py            extract the names from the ROM, then write output/names/teamdata95s.asm
  python3 tools/names95.py --check    also check that every name packs back to the bytes in the ROM

src/data/teamdata95s.asm has placeholders where a player name or a team nickname goes (PackedName "P000XXXXX"); each
placeholder packs to as many bytes as the real name. This tool:
  1. reads lst/nhl95snes.sfc and writes Extracted/PlayerNames.txt (the 687 player names in ROM order, which is the order
     of the PackedName lines of the players) and Extracted/TeamNicknames.txt (the 26 team nicknames in ROM order);
  2. copies the source to output/names/teamdata95s.asm with each PackedName line replaced by the real name's packed
     bytes and each PackedText line (city, abbreviation, arena: not licensed) by the packed bytes of its own text.
bank $C3 includes the copy. A name is stored as 5-bit symbols, low bit first (UnpackText in the game): 0-25 a letter of the
current case (it starts upper case), $1A the end, $1B a space, $1C swaps the case, $1D / $1E / $1F a 3-bit index into
PackedTextSymbols (+0 / +8 / +16). The last byte is padded with 0 bits.
"""
import os, re, struct, sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
ROM_PATH = os.path.join(ROOT, 'lst', 'nhl95snes.sfc')
SRC = os.path.join(ROOT, 'src', 'data', 'teamdata95s.asm')
OUT = os.path.join(ROOT, 'output', 'names', 'teamdata95s.asm')
PLAYER_NAMES = os.path.join(ROOT, 'Extracted', 'PlayerNames.txt')
NICKNAMES = os.path.join(ROOT, 'Extracted', 'TeamNicknames.txt')

BANK_C3 = 0x30000                 # file offset of bank $C3 (HiROM: banks $C0-$CF map straight to the file)
PLAYER_LIST = 0x0038              # PlayerList in bank $C3: a word per player
PLAYERS = 687
TEAM_LIST = 0x0000                # TeamList in bank $C3: a word per team
TEAMS = 28
SYMBOLS_AT = 0x4C420              # PackedTextSymbols (file offset): the characters of codes $1D-$1F
FIRST_STRING = 0x53               # offset of a team record's first string (city)
NICKNAME_TEAMS = 26               # the two All Star teams and the EA record have no licensed nickname

def symbols(rom): return [chr(c) for c in rom[SYMBOLS_AT:SYMBOLS_AT + 24]]

def decode(rom, o):
    """Decode the packed text at file offset o: (text, end offset exclusive)."""
    sym = symbols(rom); bit = 0; base = 0x41; out = ''
    def rd(n):
        nonlocal bit
        v = 0
        for i in range(n):
            v |= (rom[o + (bit >> 3)] >> (bit & 7) & 1) << i; bit += 1
        return v
    while True:
        c = rd(5)
        if c < 0x1A: out += chr(c + base)
        elif c == 0x1A: return out, o + ((bit + 7) >> 3)
        elif c == 0x1B: out += ' '
        elif c == 0x1C: base = 0x61 if base == 0x41 else 0x41
        else: out += sym[rd(3) + 8 * (c - 0x1D)]

def pack(text, sym):
    """Pack text into bytes (the form decode reads)."""
    bits = []; base = 0x41
    def put(v, n): bits.extend(v >> i & 1 for i in range(n))
    for ch in text:
        if ch == ' ': put(0x1B, 5)
        elif ch.isascii() and ch.isalpha():
            want = 0x41 if ch.isupper() else 0x61
            if want != base: put(0x1C, 5); base = want
            put(ord(ch.upper()) - 0x41, 5)
        else:
            i = sym.index(ch); put(0x1D + i // 8, 5); put(i % 8, 3)
    put(0x1A, 5)
    while len(bits) % 8: bits.append(0)
    return bytes(sum(b << i for i, b in enumerate(bits[k:k + 8])) for k in range(0, len(bits), 8))

def extract(rom, check=False):
    """The player names (ROM order) and team nicknames (ROM order) of the ROM."""
    sym = symbols(rom)
    plist = struct.unpack(f'<{PLAYERS}H', rom[BANK_C3 + PLAYER_LIST:BANK_C3 + PLAYER_LIST + 2 * PLAYERS])
    players = []
    for a in sorted(p & 0x3FFF for p in plist):
        t, e = decode(rom, BANK_C3 + a + 8)               # a record: sweater, 7 rating bytes, the packed name
        if check and pack(t, sym) != rom[BANK_C3 + a + 8:e]: raise SystemExit(f'names95: player at ${a:04X} does not pack back')
        players.append(t)
    tlist = struct.unpack(f'<{TEAMS}H', rom[BANK_C3 + TEAM_LIST:BANK_C3 + TEAM_LIST + 2 * TEAMS])
    nicks = []
    for a in sorted(tlist)[2:]:                           # ASE and ASW come first in ROM order
        o = BANK_C3 + a + FIRST_STRING
        for _ in range(2): o = decode(rom, o)[1]          # city, abbreviation
        t, e = decode(rom, o)
        if check and pack(t, sym) != rom[o:e]: raise SystemExit(f'names95: nickname at ${a:04X} does not pack back')
        nicks.append(t)
    return players, nicks[:NICKNAME_TEAMS]

def write_lines(path, lines):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', newline='\n') as f: f.write('\n'.join(lines) + '\n')

def build(rom, players, nicks):
    sym = symbols(rom)
    pl, nk = iter(players), iter(nicks)
    pat = re.compile(r'^(\s*)(PackedName|PackedText)\s+"([^"]*)"\s*(;.*)?$')
    out = []
    for ln in open(SRC, encoding='utf-8').read().split('\n'):
        m = pat.match(ln)
        if not m: out.append(ln); continue
        indent, kind, text, _ = m.groups()
        if kind == 'PackedName':
            # the first name of the placeholder's kind: players come before the team nicknames in the ROM
            real = next(pl) if text.startswith('P') else next(nk)
            if len(pack(real, sym)) != len(pack(text, sym)): raise SystemExit(f'names95: placeholder "{text}" has another packed length than its name')
            text = real
        b = pack(text, sym)
        out.append(indent + 'db ' + ','.join(f'${x:02X}' for x in b))
    return out

def main():
    rom = open(ROM_PATH, 'rb').read()
    players, nicks = extract(rom, '--check' in sys.argv)
    write_lines(PLAYER_NAMES, players)
    write_lines(NICKNAMES, nicks)
    write_lines(OUT, build(rom, players, nicks))
    print(f'names95: {len(players)} player names, {len(nicks)} nicknames -> output/names/teamdata95s.asm')

if __name__ == '__main__': main()
