const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const app = express();
const port = process.env.PORT || 3000;
const Room = require('./models/room');

var server = http.createServer(app);
var io = require('socket.io')(server);

app.use(express.json());
const DB = 'mongodb+srv://abhinav:flutter01@cluster0.vamnoat.mongodb.net/?retryWrites=true&w=majority'

io.on("connection", (socket)=>{
    console.log('socket.io connected!');

socket.on('createRoom', async ({username})=>{
  console.log(username);
  try {
    // room is created
    let room = new Room();
    let player = {
      socketID: socket.id,
      username,
      playerType: "X",
    };
    room.players.push(player);
    room.turn = player;
    room = await room.save();
    console.log(room);
    const roomId = room._id.toString();

    socket.join(roomId);
    // io -> send data to everyone
    // socket -> sending data to yourself
    io.to(roomId).emit("createRoomSuccess", room);
  } catch (e) {
    console.log(e);
  }
});

socket.on('joinRoom', async({username,roomId})=>{
  console.log(username, roomId);
  try{
    if(!roomId.match(/^[0-9a-fA-F]{24}$/)){
      socket.emit("errorOccurred", "Please check the room ID");
      return;
    }
    let room = await Room.findById(roomId);

    if(room.isJoin){
      let player = {
        username,
        socketID: socket.id,
        playerType: 'O'
      }
      socket.join(roomId);
      room.players.push(player);
      room.isJoin =false;
      room = await room.save();
      io.to(roomId).emit("joinRoomSuccess", room);
      io.to(roomId).emit('updatePlayers', room.players);
      io.to(roomId).emit("updateRoom",room);
    }
    else{
      socket.emit(
        "errorOccurred", 'The Game is in progress, please try after some time'
      )
    }
  }
  catch(e){
    console.log('not joined',e)

  }
});

socket.on("tap", async ({ index, roomId }) => {
  try {
    let room = await Room.findById(roomId);

    let choice = room.turn.playerType; // x or o
    if (room.turnIndex == 0) {
      room.turn = room.players[1];
      room.turnIndex = 1;
    } else {
      room.turn = room.players[0];
      room.turnIndex = 0;
    }
    room = await room.save();
    io.to(roomId).emit("tapped", {
      index,
      choice,
      room,
    });
  } catch (e) {
    console.log(e);
  }
});

socket.on("winner", async ({ winnerSocketId, roomId }) => {
  try {
    let room = await Room.findById(roomId);
    let player = room.players.find(
      (playerr) => playerr.socketID == winnerSocketId
    );
    player.points += 1;
    room = await room.save();

    if (player.points >= room.maxRounds) {
      io.to(roomId).emit("endGame", player);
    } else {
      io.to(roomId).emit("pointIncrease", player);
    }
  } catch (e) {
    console.log(e);
  }
});
});

mongoose.connect(DB).then(()=>{
    console.log("Connection successful!");
}).catch((e)=> {console.log(e);
})

server.listen(port,"0.0.0.0", ()=>{
    console.log(`Server is runing on port ${port}`)
});