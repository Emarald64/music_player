# Pronoun Palace Music Player

> [!IMPORTANT]
> You need to buy Pronoun Palace to use this mod. It's a great game. Get it [here](https://store.steampowered.com/app/3618850/Pronoun_Palace/)

Adds a music player to the extras menu allowing you to easilly listen to this game's increadible soundtrack

Credit to Rosa D’Vorah for making the cassette sprites

[Demo Video](https://youtu.be/Y2NHza-pziE)

## How to install

1. Create a `mods` folder next to the game's executable
2. Download `music_player.zip` from the [releases page](https://github.com/Emarald64/music_player/releases)
3. Extract `music_player.zip` into the mods folder you created

The folder structure should look similar to this
```
Pronoun Palace
| pronoun_palace.exe
| mods
| | music_player
| | | mod.json
| | | music_player.pck
```

## How to run in editor and package

1. Decompile the game using [gdsdecomp](https://github.com/GDRETools/gdsdecomp)
2. Create a `mods` folder in the decompiled game and clone this repo into it
3. Create a `mod_packs` folder and a `music_player` folder inside of that
4. Make a file named `mod.json` and copy the following into it
```
{
    "id": "music_player",
}
```
> ![NOTE]
> Pronoun Palace uses Godot version 4.7 which as of now is the beta version. Make sure are using the right version of the editor
5. Install godotsteam from the godot asset store
6. Make whatever changes you want
7. Open `mods/music_player/mod_packer.gd` and press File->Run which should create the file music_player.pck in the root of the project
8. Zip the new pck file and the mod.json in this repository together
