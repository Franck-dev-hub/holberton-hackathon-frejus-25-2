# Hackathon Frejus 2025
## 📌 Paul
The SWE from Frejus has disappeared.
Your mission is to find him before something bad happens to him...
Small game created in Lua with LOVE2D, little sleep, and cursed code.

## 🚀 Getting Started
### ✅ Prerequisites
- You shouldn't be too stupid in general (quote from Franck).
- You must have LUA and LOVE2D installed.
- Not recommended for people who have had fingers amputated.


### 🛠️ Technologies Used & UML
![Lua](https://img.shields.io/badge/Code-Lua-000080?style=for-the-badge&logo=lua&logoColor=white)
![LÖVE2D](https://img.shields.io/badge/Engine-LÖVE2D-ff69b4?style=for-the-badge&logo=heart&logoColor=white)


```mermaid
direction LR
    class Main {
	    +screenW : number
	    +screenH : number
	    +love_load() void
	    +love_update(dt: number) void
	    +love_draw() void
	    +love_keypressed(key: string) void
    }

    class Player {
	    +player : object
	    +x : number
	    +y : number
	    +angle : number
	    +speed : number
	    +player_init() void
	    +player_move(direction: string) void
	    +player_rotate(angle: number) void
    }

    class Dungeon {
	    +dungeon : table
	    +dungeon_init() void
	    +dungeon_get_tile(x: number, y: number) any
	    +dungeon_is_walkable(x: number, y: number) boolean
    }

    class Raytracing {
	    +rayCount : number
	    +maxDist : number
	    +raytracing_init() void
	    +raytracing_draw() void
	    +castRay(angle: number) any
    }

    class Input {
	    +input_keypressed(key: string) void
    }

    class Screamer {
	    +screamer : object
	    +elapsedTime : number
	    +displayDuration : number
	    +showImage : boolean
	    +alpha : number
	    +lastTile : number
	    +images : table
	    +sounds : table
	    +screamer_init() void
	    +screamer_update(dt: number) void
	    +screamer_draw() void
    }

    Main o-- Player : owns
    Main o-- Dungeon : owns
    Main o-- Raytracing : owns
    Main o-- Screamer : owns
    Main ..> Input : handles
    Input ..> Player : calls
    Raytracing ..> Player : uses
    Raytracing ..> Dungeon : uses
    Screamer ..> Player : uses
    Screamer ..> Dungeon : uses
    Player ..> Dungeon : uses

	class Main:::Sky
	class Player:::Peach
	class Dungeon:::Rose
	class Raytracing:::Aqua
	class Input:::Aqua
	class Screamer:::Aqua

	classDef Sky :,stroke-width:1px, stroke-dasharray:none, stroke:#374D7C, fill:#E2EBFF, color:#374D7C
	classDef Rose :,stroke-width:1px, stroke-dasharray:none, stroke:#FF5978, fill:#FFDFE5, color:#8E2236
	classDef Peach :,stroke-width:1px, stroke-dasharray:none, stroke:#FBB35A, fill:#FFEFDB, color:#8F632D
	classDef Aqua :,stroke-width:1px, stroke-dasharray:none, stroke:#46EDC8, fill:#DEFFF8, color:#378E7A
```

### 📥 Installation and run
1. Clone the repository.
2. Create and activate a virtual environment (I advise using `uv`).
3. Install dependencies (you can use `requirements.txt`).
4. Run the application (you can use the provided `run.bat` file).
5. Use the graphical interface to configure.

## 💡 Usage
1. Install LÖVE2D
   Download the latest version from: https://love2d.org/

2. Check that the love command works in your terminal:
```bash 
love --version
```

3. Clone or download the project
```bash
git clone https://github.com/tonpseudo/ton-projet.git
cd your-project
```

4. Launch the game
```bash
love ./
```

## 📁 Project Structure
├── assets
│   ├── arrows
│   │   ├── east.png
│   │   ├── north.png
│   │   ├── south.png
│   │   └── west.png
│   ├── screamers
│   │   ├── screamer_1.png
│   │   ├── screamer_2.png
│   │   └── screamer_3.png
│   ├── sounds
│   │   ├── ambiant.mp3
│   │   ├── sound_1.mp3
│   │   ├── sound_2.mp3
│   │   └── sound_3.mp3
├── .gitignore
├── dungeon.lua
├── input.lua
├── main.lua
├── player.lua
├── raytracing.lua
├── README.md
└── screamer.lua

## ❓ Help
If you encounter issues, ensure:
- RTFM
- Dependencies are correctly installed.
- For additional help, refer to the source code or contact the authors.

## 👥 Authors
- **[Franck S.](https://github.com/Franck-dev-hub)**
- **[Cyril I.](https://github.com/Iglcyril)**
- **[Virginie L.](https://github.com/v-lmb)**

## 📝 Version History
- **v1.0**:
    - Initial Release

## 📜 License
- This project is licensed under GNU GPL v3.0 - see the LICENSE.txt file for details.

## 💖 Acknowledgments
- Made with LOVE
- The entire Holberton Frejus campus for their warm welcome and kindness.
- Rémi for his excellent organization and his voluntary and professional participation in the project.
- The beach, because.
- And us (quote from Franck)
