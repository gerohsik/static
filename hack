
<html>
<head>
<meta charset="UTF-8">
<title>Matrix Text Effect - pingpoli.de</title>
<script>
var tileSize = 20;
// a higher fade factor will make the characters fade quicker
var fadeFactor = 0.05;

var canvas;
var ctx;

var columns = [];
var maxStackHeight;

function init()
{
    canvas = document.getElementById( 'canvas' );
    ctx = canvas.getContext( '2d' );
    
    initMatrix();

    
    for ( let i = 0 ; i < 40; ++i ) {
        let message = "";
        for ( let i = 0 ; i < 50; ++i ) {
            message = message.concat(String.fromCharCode( 33+Math.floor(Math.random()*94) ));
        }
        draw(message);
    }

    // start the main loop
    tick(0, 0);
}

function initMatrix()
{
    maxStackHeight = Math.ceil(canvas.height/tileSize);

    // divide the canvas into columns
    for ( let i = 0 ; i < canvas.width/tileSize ; ++i )
    {
        var column = {};
        // save the x position of the column
        column.x = i*tileSize;
        // create a random stack height for the column
        column.stackHeight = 10+Math.random()*maxStackHeight;
        // add a counter to count the stack height
        column.stackCounter = 0;
        // add the column to the list
        columns.push( column );
    }
}

function draw(msg)
{
    // draw a semi transparent black rectangle on top of the scene to slowly fade older characters
    ctx.fillStyle = "rgba( 0 , 0 , 0 , "+fadeFactor+" )";
    ctx.fillRect( 0 , 0 , canvas.width , canvas.height );

    // pick a font slightly smaller than the tile size
    ctx.font = (tileSize-2)+"px monospace";
    ctx.fillStyle = "rgb( 0 , 255 , 0 )";

    var msgChars = msg.split('');
    var msgLen = msgChars.length;

    for ( let i = 0 ; i < columns.length ; ++i )
    {
        // pick a random ascii character (change the 94 to a higher number to include more characters)
        //var randomCharacter = String.fromCharCode( 33+Math.floor(Math.random()*94) );
        
        var printChar = msgChars[i % msgLen];
        
        ctx.fillText( printChar , columns[i].x , columns[i].stackCounter*tileSize+tileSize );

        // if the stack is at its height limit, pick a new random height and reset the counter
        if ( ++columns[i].stackCounter >= columns[i].stackHeight )
        {
            columns[i].stackHeight = 10+Math.random()*maxStackHeight;
            columns[i].stackCounter = 0;
        }
    }
}

// MAIN LOOP
function tick(msgIndex, msgCount)
{   
    var messages =  [ 
        "CAN YOU HACK IT?   CAN YOU HACK IT?   ",
        "CAN YOU HACK IT?   CAN YOU HACK IT?   ",
        "MARTECH   DSSP   PLATFORM   EHIP   ",                 
        "DSSP   PLATFORM   EHIP   MARTECH   ", 
        "PLATFORM   EHIP   MARTECH   DSSP   ",
        "EHIP   MARTECH   DSSP   PLATFORM   "
    ];
    var MSG_COUNT = 40;

    var message = "";
    if(msgCount==0) {
        msgIndex = msgIndex + 1;
        if(msgIndex>=messages.length) {
            msgIndex = 0;
        }
        msgCount = MSG_COUNT;
    } else {
        msgCount = msgCount - 1;
    }

    message =  messages[msgIndex];
    console.log(msgIndex + " | " + msgCount + " | " + message);
    draw(message);

    setTimeout( tick, 300, msgIndex, msgCount);
}
</script>
</head>
<body onload="init();" style="margin: 0; padding: 0; background-color: #000000;">
<canvas id="canvas" width="1280" height="720" style="display:block; margin:0 auto;"></canvas>
</body>
</html>
view rawmatrix-min.html hosted with ??? by GitHub
