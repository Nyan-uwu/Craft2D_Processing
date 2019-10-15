void keyPressed()
{
    switch(str(key).toLowerCase())
    {
        case "a":
            Player.movedir.x = -1;
            break;
        case "d":
            Player.movedir.x = 1;
            break;
        case " ":
            Player.jump();
            break;
        case "w":
            Player.jump();
            break;
    }
}

void keyReleased()
{
    switch(str(key).toLowerCase())
    {
        case "a":
            if (Player.movedir.x == -1)
            {
                Player.movedir.x = 0;
            }
            break;
        case "d":
            if (Player.movedir.x == 1)
            {
                Player.movedir.x = 0;
            }
            break;
    }
}