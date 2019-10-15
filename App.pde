public static class App
{
    public static Boolean RUNNING = false;

    public static int D_GRASS_HEIGHT = 10;
    public static int D_CHUNK_HEIGHT = 5;

    public static Vector WINDOW_SIZE;

    public static Vector BLOCK_SIZE;
    public static Vector CHUNK_SIZE;
    public static Vector WORLD_SIZE;

    public static Vector PLAYER_START_CHUNK;
    public static Vector PLAYER_START_POS;

    public static color[] COLOURS;


    public static boolean INIT(
        Vector WINS,
        Vector WS,
        Vector CS,
        Vector BS,
        color[] COLS,
        Vector PSC,
        Vector PSP
    ) {
        try
        {
            WINDOW_SIZE = WINS;
            WORLD_SIZE  = WS;
            CHUNK_SIZE  = CS;
            BLOCK_SIZE  = BS;
            COLOURS     = COLS;
            PLAYER_START_CHUNK = PSC;
            PLAYER_START_POS = PSP;
        }
        catch (Exception ex) { return false; }
        finally { return true; }
    }
}