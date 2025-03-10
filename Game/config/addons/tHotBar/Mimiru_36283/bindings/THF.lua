return T{
    Default = T{
    },
    Palettes = T{
        { Name="Base", Bindings = T{
            ["4"] = {
                ActionType              = 'Spell',
                Id                      = 338,
                Macro                   = T{
                    "/ma \"Utsusemi: Ichi\" <me>",
                },
                Label                   = "Ichi",
                Image                   = "spells2/nin/ichi.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^7"] = {
                ActionType              = 'Ability',
                Id                      = 557,
                Macro                   = T{
                    "/target <stnpc>",
                    "/ja \"Mug\" <t>",
                },
                Label                   = "Mug",
                Image                   = "abilities2/thf/mug.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["5"] = {
                ActionType              = 'Spell',
                Id                      = 339,
                Macro                   = T{
                    "/ma \"Utsusemi: Ni\" <me>",
                },
                Label                   = "Ni",
                Image                   = "spells2/nin/ni.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^8"] = {
                ActionType              = 'Ability',
                Id                      = 554,
                Macro                   = T{
                    "/ja \"Flee\" <me>",
                },
                Label                   = "Flee",
                Image                   = "abilities2/thf/flee.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^9"] = {
                ActionType              = 'Command',
                Macro                   = T{
                    "/tt custom \"Slime time\" 12m",
                },
                Label                   = "Slime",
                Image                   = "misc/timer.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^0"] = {
                ActionType              = 'Ability',
                Id                      = 533,
                Macro                   = T{
                    "/ja \"Perfect Dodge\" <me>",
                },
                Label                   = "PD",
                Image                   = "abilities2/thf/pd.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["0"] = {
                ActionType              = 'Ability',
                Id                      = 547,
                Macro                   = T{
                    "/ja \"Provoke\" <t>",
                },
                Label                   = "Provoke",
                Image                   = "abilities/35.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["7"] = {
                ActionType              = 'Command',
                Macro                   = T{
                    "/equip ammo \"Bloody Bolt\"",
                    "/echo Bloody Bolt",
                },
                Label                   = "Bloody",
                Image                   = "misc/gear.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["8"] = {
                ActionType              = 'Command',
                Macro                   = T{
                    "/equip ammo \"Acid Bolt\"",
                    "/echo Acid Bolt",
                },
                Label                   = "Acid",
                Image                   = "misc/gear.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["1"] = {
                ActionType              = 'Weaponskill',
                Id                      = 25,
                Macro                   = T{
                    "/ws \"Evisceration\" <t>",
                },
                Label                   = "Evisceration",
                Image                   = "ITEM:21565",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = false,
            },
            ["!9"] = {
                ActionType              = 'Item',
                Id                      = 4157,
                Macro                   = T{
                    "/item \"Poison Potion\" <me>",
                },
                Label                   = "Poison Potion",
                Image                   = "ITEM:4157",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["9"] = {
                ActionType              = 'Command',
                Macro                   = T{
                    "/equip ammo \"Sleep Bolt\"",
                    "/echo Sleep Bolt",
                },
                Label                   = "Sleep",
                Image                   = "misc/gear.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^3"] = {
                ActionType              = 'Command',
                Macro                   = T{
                    "/ja \"Sneak Attack\" <me>",
                    "/wait 1",
                    "/ja \"Trick Attack\" <me>",
                },
                Label                   = "SATA",
                Image                   = "abilities2/thf/sata.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^2"] = {
                ActionType              = 'Ability',
                Id                      = 588,
                Macro                   = T{
                    "/ja \"Trick Attack\" <me>",
                },
                Label                   = "TA",
                Image                   = "abilities2/thf/ta.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^1"] = {
                ActionType              = 'Ability',
                Id                      = 556,
                Macro                   = T{
                    "/ja \"Sneak Attack\" <me>",
                },
                Label                   = "SA",
                Image                   = "abilities2/thf/sa.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["!1"] = {
                ActionType              = 'Ability',
                Id                      = 833,
                Macro                   = T{
                    "/ja \"Bully\" <t>",
                },
                Label                   = "Bully",
                Image                   = "abilities2/thf/bully.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["!2"] = {
                ActionType              = 'Ability',
                Id                      = 596,
                Macro                   = T{
                    "/ja \"Accomplice\" <stpc>",
                },
                Label                   = "Accomp",
                Image                   = "abilities2/thf/accomp.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["3"] = {
                ActionType              = 'Command',
                Macro                   = T{
                    "/ra <t>",
                },
                Label                   = "Range",
                Image                   = "misc/bow.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^4"] = {
                ActionType              = 'Ability',
                Id                      = 555,
                Macro                   = T{
                    "/ja \"Hide\" <me>",
                },
                Label                   = "Hide",
                Image                   = "abilities2/thf/hide.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["2"] = {
                ActionType              = 'Weaponskill',
                Id                      = 24,
                Macro                   = T{
                    "/ws \"Shark Bite\" <t>",
                },
                Label                   = "Shark Bite",
                Image                   = "ITEM:18020",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["!0"] = {
                ActionType              = 'Spell',
                Id                      = 354,
                Macro                   = T{
                    "/ma \"Tonko: Ni\" <me>",
                },
                Label                   = "Tonko",
                Image                   = "spells2/nin/tonko.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["!3"] = {
                ActionType              = 'Ability',
                Id                      = 748,
                Macro                   = T{
                    "/ja \"Collaborator\" <stpc>",
                },
                Label                   = "Collab",
                Image                   = "abilities2/thf/collab.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
            ["^6"] = {
                ActionType              = 'Ability',
                Id                      = 553,
                Macro                   = T{
                    "/target <stnpc>",
                    "/ja \"Steal\" <t>",
                },
                Label                   = "Steal",
                Image                   = "abilities2/thf/steal.png",
                ShowCost                = true,
                ShowCross               = true,
                ShowFade                = true,
                ShowRecast              = true,
                ShowName                = true,
                ShowTrigger             = true,
                ShowSkillchainIcon      = true,
                ShowSkillchainAnimation = true,
                ShowHotkey              = true,
            },
        } },
    },
};