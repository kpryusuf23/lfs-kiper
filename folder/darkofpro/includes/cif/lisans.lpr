CathEvent OnConnect( $userName ) # Player event

	IF ( UserIsAdmin( $userName ) == 1 )
      		THEN
	    GlobalMsg ("^1".GetCurrentPlayerVar("NickName") ." ^7^Tadmin ^7Olarak Sunucuya Baðlandý!."); 
CmdLFS("/rcm ".GetCurrentPlayerVar("NickName") ." ^7^TAdmin ^7Giriþ Yaptý!");
CmdLFS("/rcm_all");
ELSE
ENDIF
					UserGroupFromFile( "yonetici", "./yonetici.txt" );
			IF( UserInGroup( "yonetici",$userName) )
THEN
	openGlobalButton( "kurucu_present",1,185,25,4,1,-1,35,"^T^1Kurucu: ".GetCurrentPlayerVar("NickName")."");
ELSE
ENDIF

EndCathEvent