#############################################################################
# Membership Administration  by Krayy
#############################################################################
# This addon performs various membership administration tasks and also handles
# member permissions.
#############################################################################
# Ver 1.0.1 - 05 March 2010 Initial release
#############################################################################

CatchEvent OnLapperStart()
	### Set up global var for GUI Tab & increase AG_MAX ####
	GlobalVar $AG_MEMBERSHIP;	$AG_MEMBERSHIP = $AG_MAX;
	$AG_MAX = $AG_MAX + 1;
	# Append comma separated string for menu item
	$GUI_ADMIN_ITEMS = $GUI_ADMIN_ITEMS . "Membership,";

	# Membership status Globals
	GlobalVar $MEMBERTYPE_UNKNOWN; 	$MEMBERTYPE_UNKNOWN	= -1; # Player has not been here before
	GlobalVar $MEMBERTYPE_VISITOR; 	$MEMBERTYPE_VISITOR	= 0; # Player is a visitor
	GlobalVar $MEMBERTYPE_GUEST; 	$MEMBERTYPE_GUEST	= 1; # Player is a vouched for guest
	GlobalVar $MEMBERTYPE_AFFILIATE;$MEMBERTYPE_AFFILIATE 	= 2; # Player is Affiliate Member and subject to review
	GlobalVar $MEMBERTYPE_FULL;		$MEMBERTYPE_FULL	= 3; # Player is a full member
	GlobalVar $MEMBERTYPE_ADMIN;	$MEMBERTYPE_ADMIN	= 4; # Player is an admin
	GlobalVar $MEMBERTYPE_MAX;		$MEMBERTYPE_MAX		= 5; # Used as a upper limit for iterators

	### Global vars for Membership names ####
	GlobalVar $MemberTypes;
	$MemberTypes[$MEMBERTYPE_VISITOR] = "Visitor";
	$MemberTypes[$MEMBERTYPE_GUEST] = "Guest";
	$MemberTypes[$MEMBERTYPE_AFFILIATE] = "Affiliate";
	$MemberTypes[$MEMBERTYPE_FULL] = "Full";
	$MemberTypes[$MEMBERTYPE_ADMIN] = "Admin";
	$MemberTypes[$MEMBERTYPE_MAX] = "MAX";

EndCatchEvent

CatchEvent OnMSO( $userName, $text ) # Player event
	$idxOfFirstSpace = indexOf( $text, " ");
	IF( $idxOfFirstSpace == -1 ) THEN
	  $command = $text;
	  $argv = "";
	ELSE
	  $command = subStr( $text,0,$idxOfFirstSpace );
	  $argv = trim( subStr( $text,$idxOfFirstSpace ) );
	ENDIF

	SWITCH( $command )
		CASE "!ma":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
				DoAdminMembership(0,0);
			ELSE
				privMsg( langEngine( "%{main_notadmin}%" ) );
			ENDIF
		BREAK;
	ENDSWITCH
EndCatchEvent

#############################################################################
# Membership Administration Dialog Box
#############################################################################
Sub DoAdminMembership($KeyFlags,$id)
	# Draw the main Admin Framework dialog box
	DrawAdminGUI($AG_MEMBERSHIP, "Membership Administration");

	$DialogPrefix = $AGPrefix . "Ma_";		# Dialog prefix...used in Close Regex
	$origT = $AGorigT+1;			# Top edge of main content window
	$origL = $AGorigL+1;	# Left edge of main content window
	$origR = $AGorigL+50;
	$rowHeight = 5;
	$NameLen = 30;


	# Set the header row
	openPrivButton ($DialogPrefix . "nick1",$origL,$origT,$NameLen,$rowHeight,1,-1,96,"^7Name");
	openPrivButton ($DialogPrefix . "status1",$origL+$NameLen,$origT,19,$rowHeight,1,-1,96,"^7MemberType");
	openPrivButton ($DialogPrefix . "nick2",$origR,$origT,$NameLen,$rowHeight,1,-1,96,"^7Name");
	openPrivButton ($DialogPrefix . "status2",$origR+$NameLen,$origT,19,$rowHeight,1,-1,96,"^7MemberType");

	$mList = GetListOfPlayers();
	$mCount = arrayCount( $mList );
	$plyNum=0;
	WHILE ($plyNum < $mCount)
		$uName = $mList[$plyNum];

		$IsOdd = $plyNum & 1;
		IF ($IsOdd == 0)	# Check if we are on left or right side
		THEN
			$origRow = $origT + $rowHeight + (Round($plyNum / 2,0) * $rowHeight);
			$origCol = $origL;
		ELSE
			$origCol = $origR;
		ENDIF
		$uUCID = GetPlayerVar($uName,"UCID");
		$uType = GetMemberType($uName);
		$uNick = GetPlayerVar($uName,"NickName");
		$PrefixTmp = $DialogPrefix . $uUCID . "_" . $plyNum . "_";
		DEBUG ("Prefix for " . $uNick . " is " . $PrefixTmp);
		IF ( UserIsAdmin( GetCurrentPlayerVar("UserName") ) == 1 )
		THEN
			openPrivButton ( $PrefixTmp . "nick",$origCol,$origRow,$NameLen,$rowHeight,1,-1,ISB_LEFT+ISB_DARK,GetPlayerVar($uName,"NickName"));
			openPrivButton ( $PrefixTmp . "status",$origCol+$NameLen,$origRow,16,$rowHeight,1,-1,ISB_LEFT+ISB_DARK,"^3" . $uType);
			openPrivButton ( $PrefixTmp . "plus",$origCol+46,$origRow,3,3,2,-1,ISB_DARK,"^2+",MemberTypeIncrease);
			openPrivButton ( $PrefixTmp . "minus",$origCol+46,$origRow+2,3,3,2,-1,ISB_DARK,"^1-",MemberTypeDecrease);
		ELSE
			openPrivButton ( $PrefixTmp . "nick",$origCol,$origRow,$NameLen,$rowHeight,1,-1,ISB_LEFT+ISB_DARK,GetPlayerVar($uName,"NickName"));
			openPrivButton ( $PrefixTmp . "status",$origCol+$NameLen,$origRow,20,$rowHeight,1,-1,ISB_LEFT+ISB_DARK,"^3" . $uType);
		ENDIF
		$plyNum=$plyNum+1;
	ENDWHILE
EndSub

Sub MemberTypeIncrease ( $KeyFlags, $id )
	$DialogPrefix = split( $id,"_",0 );
	$Ucid = ToNum(split( $id,"_",1 ));
	$plyNum = ToNum(split( $id,"_",2 ));
	$uName = GetPlayerVarByUcid($Ucid, "UserName");
	$mType = GetUserStoredNum($uName,"MemberType");
	DEBUG ("Current member type for " . $uName . " is " . $mType);
	IF ( $mType < ($MEMBERTYPE_MAX - 1) )
	THEN
		SetUserStoredValue($uName, "MemberType", $mType +1);
	ENDIF
	$StatusButton = $DialogPrefix . "_" . $Ucid . "_" . $plyNum . "_status";
	$uType = GetMemberType($uName);
	DEBUG ("Updating button " . $StatusButton);
	TextPrivButton( $StatusButton, "^3" . $uType);
EndSub

Sub MemberTypeDecrease ( $KeyFlags, $id )
	$DialogPrefix = split( $id,"_",0 );
	$Ucid = ToNum(split( $id,"_",1 ));
	$plyNum = ToNum(split( $id,"_",2 ));
	$uName = GetPlayerVarByUcid($Ucid, "UserName");
	$mType = GetUserStoredNum($uName,"MemberType");
	DEBUG ("Current member type for " . $uName . " is " . $mType);
	IF ( $mType > $MEMBERTYPE_VISITOR )
	THEN
		SetUserStoredValue($uName, "MemberType", $mType - 1);
	ENDIF
	$StatusButton = $DialogPrefix . "_" . $Ucid . "_" . $plyNum . "_status";
	$uType = GetMemberType($uName);
	DEBUG ("Updating button " . $StatusButton);
	TextPrivButton( $StatusButton, "^3" . $uType);
EndSub

Sub GetMemberType($userName)
	$mType = GetUserStoredNum($userName,"MemberType");
	IF ( $mType <= $MEMBERTYPE_UNKNOWN )
	THEN
		$mType = $MEMBERTYPE_VISITOR;
		SetUserStoredValue("MemberType", $MEMBERTYPE_VISITOR);
	ENDIF
	IF ( $mType >= $MEMBERTYPE_MAX )
	THEN
		$mType = $MEMBERTYPE_MAX - 1;
		SetUserStoredValue("MemberType", $mType);
	ENDIF
	$mName = $MemberTypes[$mType];
#	DEBUG ("Member type is: " . $mType . "," . $mName);
	return($mName);
EndSub

Sub LoginMember($userName)
	$NickName = GetPlayerVar($userName, "NickName");
	privMsg ("^7Hi there, ^8" . $NickName);
	globalMsg ($NickName . "^8 has logged in");
EndSub

Sub LoginNonMember($userName)
	$NickName = GetPlayerVar($userName, "NickName");
	IF ( GetUserStoredNum("MemberType") < $MEMBERTYPE_VISITOR )
	THEN
		SetUserStoredValue("MemberType", $MEMBERTYPE_VISITOR);
		privMsg ("^7Welcome ^8" . $NickName);
		globalMsg ($NickName . "^8, a new ^6Visitor^8 has logged in");
	ELSE
		privMsg ("^7Welcome back, ^8" . $NickName);
		globalMsg ($NickName . "^8, a returning ^6" . GetMemberType($userName) . "^8 has logged in");
	ENDIF
EndSub

Event OnConnect( $userName ) # Player event
	$NickName = GetCurrentPlayerVar("NickName");
	$Posabs = GetCurrentPlayerVar("PosAbs");
	$Groupqual = GetCurrentPlayerVar("GroupQual");

	IF ( GetUserStoredNum("MemberType") >= $MEMBERTYPE_AFFILIATE )
	THEN
		LoginMember($userName);
	ELSE
		openPrivButton( "welc",25,50,150,15,12,-1,ISB_NONE, langEngine("%{main_welc1}%", $NickName ) );
		openPrivButton( "pos",25,80,150,10,8,-1,ISB_NONE,langEngine("%{main_welc2}%",$Posabs,$Posqual,$Groupqual  ) );
		openPrivButton( "clos",78,120,20,10,10,-1,ISB_DARK,langEngine("%{main_accept}%"),OnConnectClose );
		openPrivButton( "ref",103,120,20,10,10,-1,ISB_DARK,langEngine("%{main_deny}%"),OnConnectCloseKick );
	ENDIF
EndEvent

Sub UserIsAdmin($userName)
	IF ( UserIsServerAdmin( $userName ) == 1 ||  GetPlayerVar($userName,"UCID") == 0 ||  UserInGroup( "superusers",$userName) == 1 || GetUserStoredNum("MemberType") == $MEMBERTYPE_ADMIN )
	THEN
		return(ToNum(1));
	ELSE
		return(ToNum(0));
	ENDIF
EndSub

Lang "EN"
	sponsor_1 = "^7Welcome {0} ^7to this ^1LFSLapper ^7powered server.%nl%^2Type ^7!help ^2after leaving garage for supported commands.";
	sponsor_2 = "^7If you are not yet a member of LFSNZ, you will need to abide by our rules.%nl%Respect other players, no crashing, and obey race flags%nl%Please follow these rules or you may be banned%nl%To join LFSNZ, go to http://www.lfsnz.com and sign up.";
	sponsor_accept = "Accept";
	sponsor_deny = "Deny";
EndLang
