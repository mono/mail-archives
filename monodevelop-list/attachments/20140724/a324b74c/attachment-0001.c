/* ----------------------------------------------------- */ 
/*                  Prisoner's Dilemma Code                     */ 
/*                                                              */ 
/*   Idea from Scientific American, June 1995 (vol.272, no.6)   */ 
/*         Adapted by Alexander Mieczyslaw Kasprzyk             */ 
/* ------------------------------------------------------------ */


/* adjust these constants to experiment */


define size        150     /* size of the square board */
define scale       2       /* scale factor when drawing the board to the window */


define chance      -32700  /* chance of defecting (between -32767 and 32767) */
define advantage   185     /* advantage for cheating */
                            /* also try 115, 135, 155, 177, 190, 201 */

/* two macros to make reading from the arrays easier */
define GetValue( array, x, y )       *(array + (size+1)*y + x)
define SetValue( array, x, y, val )  *(array + (size+1)*y + x) = val


void main( void ) 
{
    WindowPtr   theWindow;   /* the window */
    Rect        theRect;     /* rectangle for window and cell drawing */
    short       c [2] [2];   /* colour matrix */
    long        bc [size+2]; /* array of dealing with edges of map */
    long        i;           /* a counter */
    long        j;           /* a counter */
    long        k;           /* a counter */
    long        l;           /* a counter */
    short       pm [2] [2];  /* payoff matrix */
    short       pa;          /* local cell score (for comparing neighbours) */
    short       hp;          /* finding largest score in neighbourhood */
    short       *payoff;     /* cell scores */
    Boolean     *s;          /* current cell status (0=cooperator,1=defector) */
    Boolean     *sn;         /* cell status for next generation */
    
    InitGraf( &qd.thePort );   /* initialize toolboxes */
    InitWindows();
    GetDateTime( (unsigned long*)&qd.randSeed );
    
    /* initialize the arrays */
    if( !(payoff = (short *)NewPtr( sizeof(short)*(size+1)*(size+1) )) )
        ExitToShell();
    if( !(s = (Boolean *)NewPtr( sizeof(Boolean)*(size+1)*(size+1) )) )
        ExitToShell();
    if( !(sn = (Boolean *)NewPtr( sizeof(Boolean)*(size+1)*(size+1) )) )
        ExitToShell();
    
                             /* set up payoff matrix */
    pm [0] [0] = 100;        /* score for cooperating with a cooperator */
    pm [0] [1] = 0;          /* score for cooperating with a defector */
    pm [1] [0] = advantage;  /* score for defecting against a cooperator */
    pm [1] [1] = 0;          /* score for defecting against a defector */
    
                             /* set up colour matrix */
    c [0] [0] = blueColor;   /* is a cooperator; was a cooperator */
    c [1] [1] = redColor;    /* is a defector; was a defector */
    c [0] [1] = greenColor;  /* is a cooperator; was a defector */
    c [1] [0] = yellowColor; /* is a defector; was a cooperator */
    
    SetRect( &theRect, 40, 40, 40+size*scale, 40+size*scale );  /* create new window */
    theWindow = NewWindow( 0L, &theRect, "\p", true, dBoxProc, (WindowPtr)-1L, false, 0L );
    SetPort( theWindow );
    
    for( i = 1; i<=size; i++ )          /* initalize board */
        for( j =1; j<=size; j++ )
        {
            if( Random() < chance )     /* randomize grid with defectors and cooperators */
                SetValue( s, i, j, 1 ); /* cell is a defector */
            else
                SetValue( s, i, j, 0 ); /* cell is a cooperator */
        }
    
    for( i = 1; i<=size; i++ )    /* set up boundary conditions */
        bc [i] = i;               /* no problem if 'i' between 1 and 'n' */
    bc [0] = size;                /* redirect neighbours of edges */
    bc [size+1] = 1;
    
    while( !Button() )            /* begin iterating untill mouse pressed and held down */
    {
        /* calculate payoffs for each player on the board */
        for( i=1; i<=size; i++ )
            for( j=1; j<=size; j++ )
            {
                pa = 0;
                /* work out the total payoff from each of the player's neighbours */
                for( k = -1; k<=1; k++ )
                    for( l = -1; l<=1; l++ )
                        pa += pm [GetValue( s, i, j )] [GetValue( s, bc[i+k], bc[j+l] )];
                SetValue( payoff, i, j, pa );
            }
        
        /* find largest payoff in each area and calculate new strategies */
        for( i = 1; i<=size; i++ )
            for( j = 1; j<=size; j++ )
            {
                hp = GetValue( payoff, i, j );
                SetValue( sn, i, j, GetValue( s, i, j ) );
                for( k = -1; k<=1; k++ )
                    for( l = -1; l<=1; l++ )
                        if( GetValue( payoff, bc[i+k], bc[j+l] ) > hp )
                        {
                            hp = GetValue( payoff, bc[i+k], bc[j+l] );
                            SetValue( sn, i, j, GetValue( s, bc[i+k], bc[j+l] ) );
                        }
            }
        
        /* draw player's strategies/colour to window */
        for( i = 1; i<=size; i++ )
            for( j = 1; j<=size; j++ )
            {
                ForeColor( c[GetValue( sn, i, j )] [GetValue( s, i, j )] );
                SetRect( &theRect, (i-1)*scale, (j-1)*scale, i*scale, j*scale );
                PaintRect( &theRect );
                SetValue( s, i, j, GetValue( sn, i, j ) );
            }
    } 
}
