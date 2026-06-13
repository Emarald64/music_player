extends Mod

func _ready()->void:
    print("music mod added to tree")
    get_tree().scene_changed.connect(_scene_changed)
    var current_scene=get_tree().current_scene
    if current_scene is MainMenu:
        add_music_menu(current_scene)

func _scene_changed()->void:
    var scene=get_tree().current_scene
    if scene is MainMenu:
        add_music_menu(scene)

func add_music_menu(main_menu:MainMenu)->void:
    var hud=main_menu.get_node("HUD")
    var music_player_menu=load("res://mods/music_player/music_player_menu.tscn").instantiate()
    hud.add_child(music_player_menu)
    var music_player_button=preload("res://source/ui/menu/buttons/menu_label_button_small.tscn").instantiate()
    music_player_button.text="Music"
    music_player_button.use_string_key=false
    music_player_button.opens_menu=music_player_menu
    hud.get_node("ExtrasMenu").add_child(music_player_button)
    print("added music menu")
