Player createPlayer()
{
    return new Player();
}

class Player
{
    Vector wpos, pos, movedir;

    int fallTimer    = 10, moveTimer    = 10;
    int fallTimerMax = 10, moveTimerMax = 10;

    boolean canJump = true;

    Player()
    {
        this.wpos = new Vector(App.PLAYER_START_CHUNK.x, App.PLAYER_START_CHUNK.y);
        this.pos = new Vector(App.PLAYER_START_POS.x, App.PLAYER_START_POS.y);
        this.movedir = new Vector(0, 0);
    }

    void frame()
    {
        if (this.fallTimer <= 0) { this.fall(); }
        else { this.fallTimer -= 1; }
        this.movex(this.movedir.x);
        this.render();
    }

    void fall()
    {
        if (this.pos.y + 1 < App.CHUNK_SIZE.y)
        {
            if (World.chunks[this.wpos.x][this.wpos.y].blocks[this.pos.x][this.pos.y+1].solid == false)
            {
                this.pos.y += 1;
            }
            else
            {
                this.canJump = true;
            }
        }
        else
        {
            if (this.wpos.y + 1 < App.WORLD_SIZE.y)
            {
                this.pos.y = 0;
                this.wpos.y += 1;
            }
            else
            {
                this.canJump = true;
            }
        }
        this.fallTimer = this.fallTimerMax;
    }

    void jump()
    {
        if (this.canJump) {
            if (this.pos.y - 1 >= 0)
            {
                if (World.chunks[this.wpos.x][this.wpos.y].blocks[this.pos.x][this.pos.y-1].solid == false)
                {
                    this.pos.y -= 1;
                    this.canJump = false;
                    this.fallTimer = this.fallTimerMax;
                }
            }
            else
            {
                if (this.wpos.y - 1 >= 0)
                {
                    this.pos.y = App.CHUNK_SIZE.y;
                    this.wpos.y -= 1;
                    this.canJump = false;
                    this.fallTimer = this.fallTimerMax;
                }
            }
        }
    }

    void render()
    {
        fill(0); stroke(0);
        rect(
            this.pos.x*App.BLOCK_SIZE.x, this.pos.y*App.BLOCK_SIZE.y,
            App.BLOCK_SIZE.x, App.BLOCK_SIZE.y
        );
    }

    void movex(int dir)
    {
        if (this.moveTimer <= 0) {
            // In Chunk
            if (this.pos.x + dir >= 0 && this.pos.x + dir < App.CHUNK_SIZE.x) {
                if (World.chunks[this.wpos.x][this.wpos.y].blocks[this.pos.x+dir][this.pos.y].solid == false)
                {
                    this.pos.x += dir;
                    this.moveTimer = this.moveTimerMax;
                }
            }
            // Change Chunks
            else if (this.pos.x + dir < 0)
            {
                if (this.wpos.x - 1 >= 0) {
                    this.pos.x = App.CHUNK_SIZE.x-1;
                    this.wpos.x -= 1;
                    this.moveTimer = this.moveTimerMax;
                }
            }
            else if (this.pos.x + dir >= App.CHUNK_SIZE.x)
            {
                if (this.wpos.x + 1 < App.WORLD_SIZE.x) {
                    this.pos.x = 0;
                    this.wpos.x += 1;
                    this.moveTimer = this.moveTimerMax;
                }
            }
        }
        else
        {
            this.moveTimer -= 1;
        }
    }
}