
Accounts.onCreateUser (options, user) ->
	# if user.services.google
	# console.log options
	# console.log user
	if user.profile
		user.profile.profile_picture = user.services.google.picture;
	else
		user.profile = {}
		user.profile.picture = user.services.google.picture
		user.profile.name = user.services.google.name
		user.profile.email = user.services.google.email


	user


