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

# GAME ----
signal game_pause(state : bool)

# ---- UI

