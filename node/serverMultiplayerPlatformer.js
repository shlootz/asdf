var users = {};

var spawning_positions = {
    position_1: {
        posX:150,
        posY:150
    },
    position_2: {
        posX:450,
        posY:150
    }
}

var rooms = new Array();
var roomsDictionary = {};

var app = require('http').createServer(function (req, res) {
	
})
   , io = require('socket.io').listen(app, {transports:['flashsocket', 'websocket', 'htmlfile', 'xhr-polling', 'jsonp-polling'], log:true})
   , fs = require('fs')

app.listen(8080, '0.0.0.0');

io.sockets.on('connection', function (socket) 
{
    socket.on("message",function(data)
    {

    //****************************************************************************************************
    //Connecting the client and getting the credentials.
    //****************************************************************************************************
        if(data["type"] == "onConnect")
        {
            users[socket.id] = 
            {
                socket:socket,
                nickname:data["data"]["nickname"],
                playing:false,
                room:"none",
                type:"host/joined"
            }

           var response =  {
                    type:'onConnect',
                    data:
                    {
                        message:'Welcome!',
                        data:socket.id
                    }
                 }

            users[socket.id]['socket'].emit("message", response);
        }
    //****************************************************************************************************

    //****************************************************************************************************
    //Client requesting players
    //****************************************************************************************************
        if(data["type"] == "onLookingForPlayers")
        {
            var newRoomQuery = anyEmptyRooms();
            var newRoom = new Object();

            if(newRoomQuery["found"] == true)
            {
                //join existing room
                console.log("JOINED EXISTING ROOM");
                newRoomQuery["room"]["available"] = false;
                newRoomQuery["room"]["players"]["player2"] = socket;

                 var response =  {
                    type:'onLookingForPlayers',
                    data:
                    {
                        message:'result',
                        data: newRoomQuery["room"]["id"]
                    }    
                 }

               //transmit to players that the room is ready 
               var hostSocket =  newRoomQuery["room"]["players"]["player1"];
               var guestSocket =  newRoomQuery["room"]["players"]["player2"];
               guestSocket.emit("message", response); 
               hostSocket.emit("message", response);
            }
            else
            {
                //create new room & keep waiting
                console.log("CREATE NEW ROOM");
                newRoom = createNewRoom(socket)
                rooms.push(newRoom);
                roomsDictionary[socket.id] = newRoom;
            }

        }
    //****************************************************************************************************

    //****************************************************************************************************
    //Client requesting init Battle paramaters (position, stats, etc)
    //****************************************************************************************************
        if(data["type"] == "onArenaInitRequest")
        {
            var requestRoom = data["data"]["room"];
            var p1 = roomsDictionary[requestRoom]["players"]["player1"];
            var p2 = roomsDictionary[requestRoom]["players"]["player2"];

            var response =  {
                    type:'onArenaInitRequest',
                    data:
                    {
                        player1:{
                             posX:spawning_positions["position_1"]["posX"],
                             posY:spawning_positions["position_1"]["posY"]
                        },
                        player2:{
                             posX:spawning_positions["position_2"]["posX"],
                             posY:spawning_positions["position_2"]["posY"]
                        }
                    }
                }    

             p1.emit("message", response);
             p2.emit("message", response);   
        }   
    //****************************************************************************************************

    //****************************************************************************************************
    //Updating inBattle
    //****************************************************************************************************
        if(data["type"] == "battle")
        {
            var enemyIndex = "1";
            var requestRoom = data["room"];
            var p = {};
            var velocity = data["velocity"];

            if(data["playerIndex"] == "1")
            {
                p  = roomsDictionary[requestRoom]["players"]["player2"];
            }
            else
            {
                 p  = roomsDictionary[requestRoom]["players"]["player1"];
            }

            var response =  {
                 type:'onEnemyMoving',
                 data: velocity
             }

            p.emit("message", response)
           
        }
    });
    //****************************************************************************************************

    socket.on('disconnect', function (socket) 
    {
        delete users[socket.id]
    });

});

function retrievePlayer(exception)
{
    var obj = {
        socket:{
            id:0
        },
    }

    for(var key in users)
    {
       if(users[key]["playing"] == false && key != exception)
       {
         obj = users[key];
         break;
       }
    }

    return obj;
}

function createNewRoom(player_1)
{
    roomID = player_1['id'];
    var newRoom = {
        id:roomID,
        players:{
            player1: player_1,
            player2: 'empty'
        },
        available:true
    }

    return newRoom;
}

function anyEmptyRooms()
{
    var response = {
        found:false,
        room:'none'
    }
    var found = false;

    if(rooms.length != 0)
    {
        //join already existing room
        for(var i=0; i<rooms.length; i++)
        {
            if(checkRoom(rooms[i]))
            {
                found = true;
                response["found"] = true;
                response["room"] = rooms[i];
                break;
            }
        }
    }

    return response

}

function checkRoom(room)
{
    var isAvailable = false;

    if(room["available"] == true)
    {
        isAvailable = true;
    }

    return isAvailable;
}


