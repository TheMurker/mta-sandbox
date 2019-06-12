-- a player has joined the game
addEventHandler('onPlayerJoin', root, function ()
	
	-- spawn the player
	spawnPlayer(source, 0,0,5)

	-- fade the camera in
	fadeCamera(source, true)

	-- set the camera target to the player
	setCameraTarget(source, source)

end)