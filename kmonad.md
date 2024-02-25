# kmonad

## Homerow modifiers with a navigation layer

Implementations:
* [MacBookPro12,1](MacBookPro12,1/homerow-mods.kbd)
* [Oryx Pro (oryp10)](archive/pop-os/homerow-mods.kbd)

Dual-function keys are set up to allow rollovers during normal typing as well as
autorepeat. The feel is very similar---perhaps identical---to dual-function keys
in QMK/Oryx with "permissive hold" enabled. This layout retains *almost* all of
the functionality of a regular keyboard; the only major difference is autorepeat
on dual-function keys requires a tap-hold instead of a normal hold.

```
.-------.-----.-----.-----.-----.-----.-----.-----.-----.-----.-----.-----.-----.-----.
|       |     |     |     |     |     |     | home|  up | end |     |     |     |     |
|  tab  |  q  |  w  |  e  |  r  |  t  |  y  |  u  |  i  |  o  |  p  |  [  |  ]  |  \  |
|       |     |     |     |     |     |     |     |     |     |     |     |     |     |
.---------.-----.-----.-----.-----.-----.-----.-----.-----.-----.-----.-----.---------.
|         |super| alt |ctrl |shift|     |     | left| down|right|     |     |         |
|   esc   |  a  |  s  |  d  |  f  |  g  |  h  |  j  |  k  |  l  |  ;  |  '  | return  |
|         |super| alt |ctrl |shift|     |     |shift|ctrl | alt |super|     |         |
.-----------.-----.-----.-----.-----.-----.-----.-----.-----.-----.-----.-------------.
|           |     |     |     |     |     |     | pgup| pgdn|     |     |             |
|   shift   |  z  |  x  |  c  |  v  |  b  |  n  |  m  |  ,  |  .  |  /  |    shift    |
|           |     |     |     |     |     |     |     |     |     |     |             |
'-----------'-----'-----.-----------------------------.-----'-----'-----'-------------'
                        |                             |
                        |            space            |
                        | nav layer                   |
                        '-----------------------------'

  Legend:
                                            .-----.
    Normal key value ("j") ------------.    | left| <--- Indicates value, if any,
                                       '--> |  j  |      in nav layer ("left arrow")
    Indicates dual-function key,       .--> |shift|
    value/action when held ("shift") --'    '-----'
```

Autorepeat for dual-function keys is supported by holding *immediately* after a
tap. This works because each tap briefly suspends the key's dual-function
behavior such that holding the key will eventually cause the OS's autorepeat
feature to kick in.

**Caveats:** the following three-key combos do *not* work:

MacBookPro12,1:
```
Left hand mods:           Right hand mods:
a f ] (cmd+shift+])       j ; a (cmd+shift+a)
s f ] (opt+shift+])       j ; s (cmd+shift+s)
d f ] (ctrl+shift+])      j ; d (cmd+shift+d)
                          j ; f (cmd+shift+f)
                          j ; g (cmd+shift+g)
```

Oryx Pro (oryp10):
```
Left hand mods:           Right hand mods:
a d 7 (super+ctrl+7)      k l r (ctrl+alt+r)
a d / (super+ctrl+/)      k ; ` (super+ctrl+`)
a f h (super+shift+h)     k ; q (super+ctrl+q)
s d [ (ctrl+alt+[)        k ; g (super+ctrl+g)
s f , (alt+shift+,)       k ; z (super+ctrl+z)
d f . (ctrl+shift+.)      l ; r (super+alt+r)
```
