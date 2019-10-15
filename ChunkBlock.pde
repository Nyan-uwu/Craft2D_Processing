public World createWorld() { return new World(); }

class World
{
    Chunk[][] chunks;

    World()
    {
        this.chunks = new Chunk[App.WORLD_SIZE.x][App.WORLD_SIZE.y];
        for (int i = 0; i < App.WORLD_SIZE.x; i++)
        {
            for (int j = 0; j < App.WORLD_SIZE.y; j++)
            {
                this.chunks[i][j] = new Chunk(new Vector(i, j));
            }
        }
    }
}

class Chunk
{
    Vector wpos;
    Block[][] blocks;
    Boolean isGenerated = false;

    Chunk(Vector WPOS)
    {
        this.wpos = WPOS;
    }

    void generate()
    {
        this.blocks = new Block[App.CHUNK_SIZE.x][App.CHUNK_SIZE.y];
        if (this.wpos.y < App.D_CHUNK_HEIGHT)
        { // Air
            for (int i = 0; i < App.CHUNK_SIZE.x; i++)
            {
                for (int j = 0; j < App.CHUNK_SIZE.y; j++)
                {
                    this.blocks[i][j] = new Block(new Vector(i, j), 1);
                }
            }
        }
        else if (this.wpos.y == App.D_CHUNK_HEIGHT)
        { // WOLRD GEN
            int tGrassHeight = App.D_GRASS_HEIGHT;
            for (int i = 0; i < App.CHUNK_SIZE.x; i++)
            {
                tGrassHeight += floor(random(-1, 2));
                if (tGrassHeight > App.D_GRASS_HEIGHT+3) tGrassHeight -= 1;
                if (tGrassHeight < App.D_GRASS_HEIGHT-3) tGrassHeight += 1;
                int tDirtHeight = floor(random(3, 5));
                for (int j = 0; j < App.CHUNK_SIZE.y; j++)
                {
                    // Basic Hill Generation
                    if (j <  tGrassHeight) { this.blocks[i][j] = new Block(new Vector(i, j), 1); }
                    else if (j == tGrassHeight) { this.blocks[i][j] = new Block(new Vector(i, j), 5 ); }
                    else if (j >  tGrassHeight && j < tGrassHeight+tDirtHeight) { this.blocks[i][j] = new Block(new Vector(i, j), floor(random(6, 9))); }
                    else if (j >= tGrassHeight+tDirtHeight) {
                        this.blocks[i][j] = new Block(new Vector(i, j), floor(random(0, 10)) == 0 ? 9 : floor(random(2, 5)));
                    }
                }
            }
        }
        else
        {
            for (int i = 0; i < App.CHUNK_SIZE.x; i++)
            {
                for (int j = 0; j < App.CHUNK_SIZE.y; j++)
                {
                    this.blocks[i][j] = new Block(new Vector(i, j), floor(random(2, 5)));
                }
            }
        }
        this.isGenerated = true;
    }

    void render()
    {
        if (this.isGenerated) {
            for (int i = 0; i < this.blocks.length; i++)
            {
                for (int j = 0; j < this.blocks[i].length; j++)
                {
                    this.blocks[i][j].render();
                }
            }
        } else {
            this.generate();
            this.render();
        }
    }
}

class Block
{
    Vector pos;
    int id;
    color col;
    Boolean solid;

    Block(Vector pos, int id)
    {
        this.pos = pos;
        this.id = id;
        try
        { this.col = App.COLOURS[this.id]; }
        catch(ArrayIndexOutOfBoundsException ex)
        { this.col = App.COLOURS[0]; }

        if (this.id == 1)
        { this.solid = false; }
        else
        { this.solid = true; }
    }

    void render()
    {
        switch(this.id)
        {
            default:
                fill(this.col); stroke(0, 100);
                rect(
                    this.pos.x*App.BLOCK_SIZE.x, this.pos.y*App.BLOCK_SIZE.y,
                    App.BLOCK_SIZE.x, App.BLOCK_SIZE.y
                );
                break;
        }
    }
}