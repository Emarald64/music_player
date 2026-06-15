extends MenuPanel

var song_index:=0
var playing_shadow:=false
var animinating:=false
const NORMAL_SONGS:Array[StringName]=[&"AUTHOR",&"PREFACE",&"HEADLINE",&"RETCON",&"TYPEFACE",&"DROPCAP",&"PATHOS",&"ASTERISK",&"BODY_PARAGRAPH",&"LOGOS",&"WAXSTAMP",&"ETHOS",&"INTERROBANG",&"MX"]
const SHADOW_SONGS:Array[StringName]=[&"I_WONDER_IF",&"FAILURE_TO_THRIVE",&"IF_YOU_WANT",&"THEY_FOUND_TOMORROW",&"THERE_HE_GOES",&"IT_DID_IT",&"WHAT_WAS_SHE",&"TO_STAY_DEAD",&"WE_WERE_THERE",&"DEATH_OF_THE"]
const ALTERED_NAMED={
    &"DROPCAP":"Drop Cap",
    &"WAXSTAMP":"Wax Stamp",
    &"MX":"MX",
    &"IF_YOU_WANT":"If You Wanna"
}

@onready var song_label=%"Current Song"

func _ready()->void:
    var clickmask=BitMap.new()
    clickmask.create_from_image_alpha(%"Eject Button".texture_pressed.get_image())
    %"Eject Button".texture_click_mask=clickmask
    super._ready()

func update_song()->void:
    if not animinating:
        var song_list=SHADOW_SONGS if playing_shadow else NORMAL_SONGS
        song_index=posmod(song_index,song_list.size())
        var key=song_list[song_index]
        if ALTERED_NAMED.has(key):
            song_label.text=ALTERED_NAMED.get(key)
        else:
            song_label.text=key.capitalize()
        if song_label.text.length()<12:
            song_label.add_theme_font_size_override("font_size",18)
        elif song_label.text.length()<18:
            song_label.add_theme_font_size_override("font_size",15)
        else:
            song_label.add_theme_font_size_override("font_size",10)
        AudioManager.play_music(Globals.MUSIC[key],true)

func _on_next_song_pressed() -> void:
    song_index+=1
    AudioManager.play_sound(Sounds.UI.DIFFICULTY,1.5)
    update_song()

func _on_prevous_song_pressed() -> void:
    song_index-=1
    AudioManager.play_sound(Sounds.UI.DIFFICULTY,.5)
    update_song()

func _reset_music()->void:
    AudioManager.play_sound(Sounds.UI.DIFFICULTY,1)
    if playing_shadow:
        start_cassette_switch()
    else:
        song_index=0
        update_song()

func switch_cassette_sprite()->void:
    %Cassette.frame=1-%Cassette.frame

func start_cassette_switch()->void:
    if not animating:
        AudioManager.play_sound(Sounds.UI.DIFFICULTY_HARDEST)
        animinating=true
        AudioManager.stop_music()
        $PositionRoot/Panel/AnimationPlayer.play(&"Flip to A" if playing_shadow else &"Flip to B")
        %"Eject Button".disabled=true

func end_cassette_switch()->void:
    AudioManager.play_sound(Sounds.UI.SHADOW_OFF)
    animinating=false
    playing_shadow=not playing_shadow
    song_index=0
    %"Eject Button".disabled=false
    update_song()

func _input(event: InputEvent) -> void:
    #print(event)
    if animinating and event is InputEventMouseButton and not event.pressed and event.button_index==1:
        print("skipping")
        $PositionRoot/Panel/AnimationPlayer.advance(1)

func play_flip_sound()->void:
    AudioManager.play_sound(preload("res://sounds/toss.wav"))
