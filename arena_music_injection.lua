local name = "Arena Music Injection"

local RISEN_SHAGARU_ID = 2120
local RISEN_SHAGARU_HASH = 0xA15BC4B1

local MUSIC_NAMES = {
    -- ######## INPUT YOUR SONG NAMES HERE ########
    "[MHFG] Unkown P2",
    "[MHS2] Razewing Rathat & Zellard"
}

local MUSIC_HASHES = {
    -- ######## INPUT YOUR HASHES HERE ########
    3999990000,
    3999990001
}

local enabled = false
local music_idx = 0

-- During quest, update music using the active monster list, and choose according to music priority
local musicman = nil

-- During quest, update music using the active monster list, and choose according to music priority
local function overrideMusicOnUpdate(_args)
    if not musicman then 
        musicman = sdk.get_managed_singleton("snow.wwise.WwiseMusicManager")
    end
    if not musicman then 
        return sdk.PreHookResult.CALL_ORIGINAL
    end

    if enabled then
        musicman._SettingsData._OneAreaOverEmPriorityState:set_StateId(MUSIC_HASHES[music_idx])
        musicman._OneAreaPriorityChangeOver = true
    else
        musicman._SettingsData._OneAreaOverEmPriorityState:set_StateId(RISEN_SHAGARU_HASH)
        musicman._OneAreaPriorityChangeOver = false
    end

    return sdk.PreHookResult.CALL_ORIGINAL
end

sdk.hook(
    sdk.find_type_definition("snow.wwise.WwiseMusicManager"):get_method("updateOneAreaQuestMusic"),
    overrideMusicOnUpdate,
    nil
)

-- GUI
re.on_draw_ui(
    function()
        if imgui.tree_node(name) then
            _, enabled = imgui.checkbox("Enabled", enabled)
            _, music_idx = imgui.combo("Choose music", music_idx, MUSIC_NAMES)
            imgui.tree_pop()
        end
    end
)
