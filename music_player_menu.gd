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

#func _ready()->void:
    #song_label.text="Author"
    #super._ready()

func update_song()->void:
    if not animinating:
        var song_list=SHADOW_SONGS if playing_shadow else NORMAL_SONGS
        song_index=posmod(song_index,song_list.size())
        var key=song_list[song_index]
        if ALTERED_NAMED.has(key):
            song_label.text=ALTERED_NAMED.get(key)
        else:
            song_label.text=key.capitalize()
        AudioManager.play_music(Globals.MUSIC[key],true)


func _on_next_song_pressed() -> void:
    song_index+=1
    update_song()


func _on_prevous_song_pressed() -> void:
    song_index-=1
    update_song()

func _reset_music()->void:
    song_index=0
    update_song()

func switch_cassette_sprite()->void:
    %Cassette.frame=1-%Cassette.frame

func start_cassette_switch()->void:
    animinating=true
    AudioManager.stop_music()
    $PositionRoot/Panel/AnimationPlayer.play(&"Filp")

func end_cassette_switch()->void:
    animinating=false
    playing_shadow=not playing_shadow
    song_index=0
    update_song()
