-- create database connection
local db

-- connect to the database
addEventHandler('onResourceStart', resourceRoot, function() 
	db = dbConnect('sqlite', ':/global.db')
end)

-- return the database connection
function getConnection()
	return db
end