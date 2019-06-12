local MINIMUM_PASSWORD_LENGTH = 6

local function isPasswordValid(password)
	return string.len(password) >= MINIMUM_PASSWORD_LENGTH
end

-- create an account
addCommandHandler('register', function (player, command, username, password) 
	if not username or not password then
		return outputChatBox('SYNTAX: /' .. command .. ' [username] [password]', player, 255, 255, 255)
	end

	-- check if user exists
	if getAccount(username) then
		return	outputChatBox('A player already exists with that name, try again.', player, 255, 100, 100)
	end

	-- validate password
	if not isPasswordValid(password) then
		return	outputChatBox('The password supplied was not valid.', player, 255, 100, 100)
	end

	-- hash password

	passwordHash(password, 'bcrypt', {}, function(hashedPassword) 
		-- create the account
		local account = addAccount(username, hashedPassword)
		setAccountData(account, 'hashed_password', hashedPassword)

		-- return success
		outputChatBox('Your account has been created! You may now login with /accountLogin', player, 100, 255, 100)
	end)

end, false, false)

-- login to account
addCommandHandler( 'accountLogin', function(player, command, username, password)
	if not username or not password then
		return outputChatBox('SYNTAX: /' .. command .. ' [username] [password]', player, 255, 255, 255)
	end

	local account = getAccount(username)

	if not account then
		return outputChatBox('Incorrect username/password.', player, 255, 255, 255)
	end

	local hashedPassword = getAccountData(account, 'hashed_password')

	passwordVerify(password, hashedPassword, function(isValid)
		if not isValid then
			return outputChatBox('Incorrect username/password.', player, 255, 255, 255)
		end

		if logIn(player, account, hashedPassword) then
			outputChatBox('You have successfully logged in!', player, 100, 255, 100)
		end

		return outputChatBox('An unkown error occured while attempting to authenticate.', player, 255, 100, 100)
	end)

end, false, false)

-- logout of account

addCommandHandler('accountLogout', function(player)
	logOut(player)
end)