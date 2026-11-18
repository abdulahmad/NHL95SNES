; Bank $C6. Files in ROM order.

org $C60000

incsrc "../data/gfx/FrameTileSource.asm"
incsrc "../data/gfx/FrameBankLayout.asm"
incsrc "../data/gfx/FrameOffsetX.asm"
incsrc "../data/gfx/FrameOffsetY.asm"
incsrc "../data/gfx/FrameOffsetXFlip.asm"
%FrameTilesC6()
incsrc "../data/gfx/VezinaPicMap.asm"
incsrc "../data/gfx/VezinaPicTiles.asm"
