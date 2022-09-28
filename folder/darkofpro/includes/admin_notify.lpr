# Admin notify V1.00	01-11-15	- Initial release	#
#################################################################

CatchEvent OnLapperStart()
	OnLapperStart_Admin_Notify();
EndCatchEvent

CatchEvent OnConnect( $userName )
	OnConnect_Admin_Notify();
EndCatchEvent

CatchEvent OnDisConnect( $userName, $reason )
	OnDisConnect_Admin_Notify();
	$userName = GetCurrentPlayerVar( "UserName" );
	UserGroupFromFile( "admin", "./admin.txt" );
        UserGroupFromFile( "moderator", "./moderator.txt" );
EndCatchEvent

Sub OnLapperStart_Admin_Notify()
	### Declare global variables ###
	GlobalVar $admins_present;
	GlobalVar $admin_status;
	GlobalVar $admin_name;
	GlobalVar $admin_time_online;
        GlobalVar $moderator_name;
	### End ###

	### Give global variables a value to start with ###
	$admins_present=0;
	### End ###
EndSub

Sub OnConnect_Admin_Notify()
	### Set userName variable and load the nicknames of admins specified in admin.txt moderator.txt###
	$userName = GetCurrentPlayerVar( "UserName" );
	UserGroupFromFile( "admin", "./admin.txt" );
        UserGroupFromFile( "moderator", "./moderator.txt" ); 
	### End ###

	### Check if connecting player is an admin, if so, raise number by one ###
	IF( UserInGroup( "admin", $userName ) == 1 )
	THEN
		$admins_present=$admins_present+1;
		$moderators_present=$moderators_present+1;
		$admin_name = GetCurrentPlayerVar( "NickName" );
		$moderator_name = GetCurrentPlayerVar( "NickName" );
		$admin_time_online = getLapperVar( "ShortTime" );
		$moderator_time_online = getLapperVar( "ShortTime" );
	ENDIF
	### End ###

	Admin_status( $KeyFlags );
EndSub

Sub OnDisConnect_Admin_Notify()
	### Check if discconnecting player is an admin, if so, lower number by one ###
	IF( UserInGroup( "admin", $userName ) == 1 )
	THEN
		$admins_present=$admins_present-1;
                $moderator=$moderator-1;
	ENDIF
	### End ###

	Admin_status( $KeyFlags );
EndSub

Sub Admin_status ( $KeyFlags )
	### Check how many admins are online , if value above 0 ,status is 'online' , otherwise status is 'offline' and last name and time are removed ###
	IF ( $admins_present > 0 )
        THEN
		$admin_status="^2Aktif";
		$moderator_status="^2Oyunda";
	ELSE
		$admin_status="^1Aktif";
		$moderator_status="^1Kapali";
		$admin_name="^3(Dýsarda)";
		$moderator_name="^3(-N.A.-)";
		$admin_time_online="^3(dýsarda)";
		$moderator_time_online="^3(-N.A.-)";
	ENDIF
	### End ###

	### Display button ###
         GlobalButton( "clock",123,0,32,5,1,-1,36,"^T^2Kurucu:^7");
        GlobalButton( "admins_present",1,190,35,9,1,-1,35,"^T^1 Admin: " . $admin_name . " ");  
        ### End ###

EndSub

# Clock V1.00	30-10-15	- Initial release	#
#########################################################

CatchEvent OnConnect( $userName ) # Player even
	OnConnect_Clock();
EndCatchEvent

Sub OnConnect_Clock() # Player event
	Clock_tick( $KeyFlags );
EndSub

Sub Clock_tick( $KeyFlags )
	### Display button ###
	
	### End ###

	HostDelayedCommand( 1, Clock_tick );
EndSub