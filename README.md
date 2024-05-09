# MHR Audio 010 Editor Utils

Useful 010 templates/scripts for Monster Hunter: Rise audio modding.

## Test

## `MHR_BNK.bt`

A template files that can be applied to extracted `.bnk.2.X64` files. Can either applied to
- A complete, valid `.bnk` files starts with a `BHKD` header section.
- Or alternatively, a list of `HIRC` items in the `HIRC` sections. 

The template currently can parse the following types of `HIRC` items:
|         Name          | Type ID |
| :-------------------: | :-----: |
|      `HIRCState`      | `0x01`  |
|  `HIRCMusicSegment`   | `0x0A`  |
|   `HIRCMusicTrack`    | `0x0B`  |
| `HIRCSwitchContainer` | `0x0C`  |
|  `HIRCSeqContainer`   | `0x0D`  |

The template will mark each `HIRC` item with alternate background colors. The UID of each item will be marked with black, and some common fields to edit will be marked with blue. 

# `seq_template.bnk` and `MHR_BNK_SEQ.1sc`

`seq_template.bnk` is a list of `HIRC` items that can be used to construct a BGM including both the intro and the looped component. `mhr-bnk-seq.1sc` is a script to help edit `seq_template.bnk`.

To use:
1. Duplicate and open `seq_template.bnk`;
2. Run the template `MHR_BNK.bt`;
3. Run the script `MHR_BNK_SEQ.1sc`. Input the WEM ID, loop data (in seconds) and volumn (in Db) as prompted. The script to edit the according fields, and also assign a _random_ UID to each item. The UID of the `HIRCSeqContainer` object will be printed.

## `MHR_BNK_SPECIAL01_INJECT.1sc`

A script used to inject a new BGM (with `seq_template.bnk`) into `natives/STM/Sound/Wwise/bgm_special01_ev_str.bnk.2.X64` and bind it to a state trigger.

To use:
1. Follow the steps in [the section above](#seq_templatebnk-and-mhr-bnk-seq1sc);
2. Open `natives/STM/Sound/Wwise/bgm_special01_ev_str.bnk.2.X64`;
3. Run the template `MHR_BNK.bt`;
4. Run the script `MHR_BNK_SPECIAL01_INJECT.1sc`. Input desired hash (which will be used to play the song with REFramework lua scripts, can be arbitrary as long as no collisions), the UID of the `HIRCSeqContainer` printed in the last step in [the section above](#seq_templatebnk-and-mhr-bnk-seq1sc), and select the duplicated `seq_template.bnk`. The script will append the edited `seq_template.bnk`, adjust the necessary values, and insert a trigger to two `HIRCSwitchContainer`.

## `arean_music_injection.lua`
A proof-of-concept REFramework lua script to play in custom song on arena type maps.

To use:
1. Open `arean_music_injection.lua`. Put the names of your songs and the hashes (what you inputed in the last step in [the previous section](#mhr-bnk-special01-tree1sc)) in `MUSIC_NAMES` and `MUSIC_HASHES`;
2. Put your edited `bgm_special01_ev_str_khk.pck.3.X64` and `bgm_special01_ev_str.bnk.2.X64` into the correct place in `natives`, and put your `arean_music_injection.lua` in `reframework/autorun/`;
3. Open the game, you should see a drop menu titled "Arena Music Injection" in REFramework - Script Generated UI, and enable / select the song to play on arena type maps.
