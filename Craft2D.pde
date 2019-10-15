World World;
Player Player;
// Temp
int tVar;
int tVary;
// Temp
void setup()
{
    size(901, 1001);
    background(0); textAlign(CENTER); text("Generating...", width/2, height/2); // Loading Text

    Vector WINDOW_SIZE = new Vector(width-1, height-101);

    Vector WORLD_SIZE = new Vector(20, 20);
    Vector CHUNK_SIZE = new Vector(20, 20);
    Vector BLOCK_SIZE = new Vector(floor(WINDOW_SIZE.x/CHUNK_SIZE.x), floor(WINDOW_SIZE.x/CHUNK_SIZE.x));

    color[] COLS = {
        color(0, 0, 0),       // Void
        color(135, 206, 235), // Skyblue
        color(115, 115, 115), // Rock 1
        color(130, 130, 130), // Rock 2
        color(100, 100, 100), // Rock 3
        color(126, 200, 80 ), // Grass
        color(97 , 63 , 16 ), // Dirt 1
        color(107, 73 , 26 ), // Dirt 2
        color(87 , 53 , 6  ), // Dirt 3
        color(86 , 47 , 14 ), // Wood
        color(30 , 147, 45 ), // Leaf 1
        color(77 , 168, 59 )  // Leaf 2
    };

    Vector PLAYER_START_CHUNK = new Vector(floor(WORLD_SIZE.x/2), App.D_CHUNK_HEIGHT);
    // Vector PLAYER_START_POS = new Vector(floor(CHUNK_SIZE.x/2), App.D_GRASS_HEIGHT -= 4);
    Vector PLAYER_START_POS = new Vector(2, 2);

    if (App.INIT(
        WINDOW_SIZE,
        WORLD_SIZE,
        CHUNK_SIZE,
        BLOCK_SIZE,
        COLS,
        PLAYER_START_CHUNK,
        PLAYER_START_POS
    )) {
        App.RUNNING = true;
    } else {
        exit();
    }
    
    World = createWorld();
    Player = createPlayer();

    // Temp
    tVar = 10;
    tVary = App.D_CHUNK_HEIGHT;
    // Temp

    frameRate(60);
}

void draw()
{
    if (App.RUNNING)
    {
        background(0);
        World.chunks[Player.wpos.x][Player.wpos.y].render();
        Player.frame();
    } 
    else
    {
        exit();
    }
}