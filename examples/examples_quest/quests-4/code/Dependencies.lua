function Apply(list, f, iter)
    iter = iter or ipairs
    for k, v in iter(list) do
        f(v, k)
    end
end

Apply({
        "Renderer",
        "Sprite",
        "System",
        "Texture",
        "Vector",
        "Keyboard",
        "Sound",
    },
    function(v) LoadLibrary(v) end)

Apply({
        "Animation.lua",
        "Map.lua",
        "Util.lua",
        "Entity.lua",
        "StateMachine.lua",
        "FollowPathState.lua",
        "MoveState.lua",
        "WaitState.lua",
        "CSRunAnim.lua",
        "CSHurt.lua",
        "CSMove.lua",
        "CSStandby.lua",
        "CSEnemyHurt.lua",
        "CSEnemyDie.lua",
        "JumpingNumbers.lua",
        "AnimEntityFx.lua",
        "Animation.lua",
        "NPCStandState.lua",
        "PlanStrollState.lua",
        "Tween.lua",
        "Actions.lua",
        "Trigger.lua",
        "Dice.lua",
        "StatDefs.lua",
        "PartyMemberDefs.lua",
        "Stats.lua",
        "EntityDefs.lua",
        "Character.lua",
        "Panel.lua",
        "ProgressBar.lua",
        "Selection.lua",
        "StateStack.lua",
        "Textbox.lua",
        "Scrollbar.lua",
        "ExploreState.lua",
        "Layout.lua",
        "InGameMenuState.lua",
        "FrontMenuState.lua",
        "World.lua",
        "ItemDB.lua",
        "ItemMenuState.lua",
        "Icons.lua",
        "Storyboard.lua",
        "StoryboardEvents.lua",
        "ScreenState.lua",
        "CaptionStyles.lua",
        "CaptionState.lua",
        "MapDB.lua",
        "GameOverState.lua",
        "TitleScreenState.lua",
        "Party.lua",
        "Actor.lua",
        "LevelFunction.lua",
        "ActorSummary.lua",
        "StatusMenuState.lua",
        "EquipMenuState.lua",
        "CombatState.lua",
        "EnemyDefs.lua",
        "EventQueue.lua",
        "CETurn.lua",
        "CEAttack.lua",
        "CEFlee.lua",
        "CEUseItem.lua",
        "CombatChoiceState.lua",
        "CombatTargetState.lua",
        "CombatFormula.lua",
        "XPSummaryState.lua",
        "LootSummaryState.lua",
        "ActorXPSummary.lua",
        "CombatTextFx.lua",
        "XPPopUp.lua",
        "OddmentTable.lua",
        "BrowseListState.lua",
        "CombatActions.lua",
        "SpellDB.lua",
        "CECastSpell.lua",
        "SpecialDB.lua",
        "CESlash.lua",
        "CESteal.lua",
        "ArenaState.lua",
        "ArenaCompleteState.lua",
        "map_town.lua"
    },
    function(v) Asset.Run(v) end)