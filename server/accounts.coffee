



Accounts.onCreateUser (options, user) ->
	# if user.services.google
	# console.log options
	# console.log user
	if user.profile
		origin = user.services.google
		target = user.profile 
		allow_fields = ["email","family_name","gender","given_name","locale","name","picture","verified_email"]
		((key)-> target[key]=origin[key])(one_key) for one_key in Object.keys(origin) when one_key in allow_fields
		
	else
		user.profile = {}
		origin = user.services.google
		target = user.profile 
		allow_fields = ["email","family_name","gender","given_name","locale","name","picture","verified_email"]
		((key)-> target[key]=origin[key])(one_key) for one_key in Object.keys(origin) when one_key in allow_fields
		
	user


