# Handles communication of all global events
# See style guide to understand the prefixes and modifiers

extends Node


# Tell Godot to ignore warnings of unused signals
#warning-ignore:unused_signal

# Style Guide ------------------
# prefixes: E (Entity) , P (Player) , G (Game), 
# modifiers: O (Objective), UI (User Interface), T (Trail)

# List of published signals

# ENTITIES ----
signal E_O_COLLECT_TRASH
signal E_O_COLLECT_RECYCLE

# GAME ----
# ---- UI
signal G_UI_UPDATE_COUNTS
# ---- MINIGAMES
signal G_UI_MG_LOCK_START
signal G_UI_MG_LOCK_END

# TRAILS ---- 
signal G_T_BEGIN_TRAIL
signal G_T_END_TRAIL
signal G_T_UPDATE_OBJECTIVE_COUNT(newCount)

