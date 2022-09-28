/*
You can use config var inEvent of Sub using this syntax
getConfigVar("NameOfVar")

To use $Host Var in your script type:
getConfigVar("Host")

This is case sensitive

List of All variable that can be used in player events or in other event if you have username
This can be retreived with function:
GetCurrentPlayerVar( idOfVar )
GetPlayerVar( username, idOfVar )

example:
$CurrNickName = GetCurrentPlayerVar( "NickName" );
$SpecificNickName = GetPlayerVar( "gai-luron","NickName" );

To have Complete user var readable look at docs/playersVar.txt

List of all variables that can be used in all events
This can be retreived with function:
getLapperVar( idOfVar )

example:
$CurrTrack = getLapperVar( "LongTrackName" );

RotateIn		-> Races remaining before Rotation
HostName		-> Current host Name
ShortTrackName		-> Track Name in Short format : SO6
LongTrackName		-> Track Name in long format : South City Chicane
ShortTime		-> Server Time in short format
LongTime		-> Server Time in long format
ShortDate		-> Date in short format
LongDate		-> Date in long format
CurrRotateCar		-> Current rotated Car
CurrRotateTrack		-> Current rotated Track
CurrLongRotateTrack	-> Current rotated Track
NextRotateCar		-> Next rotated Car
NextRotateTrack		-> Next rotated Track
NextLongRotateTrack	-> Next rotated Track
RequiredFlags		-> Flag(s) required on this server

Additionnal variable that can be used in OnAuthReached.

$auth			-> Authorization reached
*/

/*
Command block to run when a LFS Special event is triggered
Event EventId()
...
EndEvent

Command block used by backcall command like button or scheduled action or when received a command by player
Sub SubId()
...
EndSub

RegisterScheduleAction( "0 0 0 * * * *", SA_mid );
	You can register a subfunction to call when a time is reached
	Firts arg = cron format ss mm hh dayOfWeek dd MM YYYY
	dayOfWeek start at 0 = Sunday
	Second arg = Sub to call when player type this text

Command allowed on Event and Sub

cmdLFS("Command_text");
	Send a command to Lapper, see command.txt in LFS Doc

privMsg( "Message_text");
	Send a private message to the player that has triggered the event
privMsg( userName, "Message_text");
	Send a private message to specific player

openPrivButton( "help",25,28,150,10,5,-1,0,"^2Commands list" );
openPrivButton( "help",25,28,150,10,5,-1,0,"^2Commands list", backcall );
	Open a button for the current player
	1 - Unique id for this button
	2 - Left coordinate for this button ( 0-200 )
		$origL = (value between 0-200); - when this value is used, every next value can be made relative to this one (example: $origL + 5;)
	3 - Top coordinate for this button ( 0-200 )
		$origT = (value between 0-200); - when this value is used, every next value can be made relative to this one (example: $origT + 5;)
	4 - Width of the button ( 0-200 )
	5 - Heigth of the button ( 0-200 )
	6 - Space between line in multiline button
	7 - Duration in seconds for the button to be displayed (use -1 if you don't want an automatic close)
	8 - Format of the button, look at insim.txt for values
	9 - Button caption, for multiline, separate each line with &
	10 - Option name of the backcalled sub
	
Backcalled Sub receive the keyboardflag to have the key pressed when click
// CFlags byte : click flags

			1		// left click
			2		// right click
			4		// ctrl + click
			8		// shift + click
			
			if left click and right click, you receive 2 + 1 = 3

closePrivButton("welc&pos&clos&ref");
	Close one or more button(s), you specify ID of the button to close, multiple ID's have to be separated by a &

openGlobalButton( "bargr1",60,1,10,6,6,30,96,"Restart:" );
	Same as openPrivButton, but open button for all players connected

closeGlobalButton("welc&pos&clos&ref");
	Same as closePrivButton, but close button for all players connected

WriteLine( "My test");
	To display message on the Lapper console with carriage return
Write( "My test");
	To display message on the Lapper console without carriage return

There are another functions, look in config file

Codes that can be used on button format:

0 - transparent button
16 - light button
32 - dark button
64 - align text to left
128 - align text to right

If you want to make a light colored button with text aligned to the left, combine the codes to one new code, for example 16+64 = 80
*/

/*
To create colored text, use the following codes in front of the text you want to color:

^0 - black
^1 - red
^2 - green
^3 - yellow
^4 - blue
^5 - violet
^6 - cyan
^7 - white
^8 - no color

Other variables that could be used on expressions
&&			-> and
||			-> or
+			-> plus
-			-> minus
/			-> devide
*			-> multiply
^			-> pow
==			-> equal to
!=			-> not equal to
>			-> bigger then
<			-> smaller then
<=			-> smaller then and equal to
>=			-> bigger then and equal to
*/

#################
# Const include #
#################

include("./includes/consts.lpr");

########################################################################
# To make your own test, called when you type !test in chat LFS Window #
########################################################################
Sub MyTest()
	privMsg( GetCurrentPlayerVar("NickName") . " ^7is testing...");
EndSub

$AdminFile = "./admin.txt"; # Name of the file containing admin lfsname player

$StoredValueDbs = "storedvalue"; # Name of the database in which additional values are stored

$TrackInfoFile = "trackInfo.cfg"; # Path to the TrackInfoFile used to compare splits

$TCPmode = true; # Connection to LFS in UDP mode or TCP mode

$EnableRegisterWeb = true; # When set to "true" your LFS Server is displayed on the FRH Team website

# To receive a notification via mail when an error occur on Lapper
$adminEmail = "";
$smtpServer = "";
$loginMail = "";
$passMail = "";

$DateFormat = "dd/MM/yyyy";
$LongDateFormat = "dddd dd MMMM yyyy";
				# Date format used for the exported elp files
				# Look at C#-format for date/time, little help
				# HH = Hour in 0-23 format
				# hh = Hour in 0-12 format
				# mm = Minute
				# tt = PM or AM
				# dd = Day
				# MM = Month
				# yyyy = year with 4 digits

$MessageTime = 5000; # Time in milliseconds for a racecontrol message (started by: rcm_all) to be displayed on screen

#$PubStatIdk = "";	# Indentification code for a connection to PubStat.
			# To obtain a PubStatId go to www.lfsworld.net , select My LFSW Setting, tab Pubstat Access
			# Remove # before PubStatIdK to activate this option

$ShowPlayerControl = False; # Set option to "true" if you want to show the control configuration of players when leaving the pits.

##############
#FTP transfer#
##############
# Results files can also be transferred to an FTP server
# Define the following parameters to use this feature
# Remove # before line to activate it
# -------------------------------------------------------------------

#$FtpServer = "your ftp server"; # Name/IP-address of your FTP server
#$FtpLogin = "your login"; # Loginname for your FTP server
#$FtpPasswd = "your password"; # Password for your FTP server
#$FtpRemotePath = "your remote dir"; # Directorname

#############
#Default Car#
#############
# Default car to show, when no car is specified in command !top or !drf and when a player haven't used a car on this server
# You can combine several cars by using + (example: "XFG+XRG";)
# -------------------------------------------------------------------
# Values UF1,XFG,XRG,XRT,RB4,FXO,LX4,LX6,RAC,FZ5,MRT,XFR,UFR,FOX,FO8,FXR,XRR,FZR,BF1,FBM

$DefaultTopCar = "XFG+XRG";

###################################
#Event triggered when lapper start#
###################################
Sub DisplaySpeed( $userName )
	PrivMsg( langEngine( "%{main_speedtrap}%" , ToPlayerUnit( GetCurrentPlayerVar( "InstantSpeed" ) ),GetCurrentPlayerVar("UnitSpeed") ) );
EndSub

Sub ExitDisplaySpeed( $userName )
	PrivMsg( "Exiting of displaySpeed" );
EndSub

Event OnLapperStart()
GlobalMsg("^6Ca^Tner^TYıl^Tma^TzInS^Tim.^Tex^Te ^2Lis^Tans ba^Tşar^Tıyl^Ta do^Tğr^Tula^Tnd^Tı!!!");
GlobalMsg("^6Ca^Tner^TYıl^Tma^TzInS^Tim.^Tex^Te ^2Lis^Tans ba^Tşar^Tıyl^Ta do^Tğr^Tula^Tnd^Tı!!!");
GlobalMsg("^6Ca^Tner^TYıl^Tma^TzInS^Tim.^Tex^Te ^2Lis^Tans ba^Tşar^Tıyl^Ta do^Tğr^Tula^Tnd^Tı!!!");
GlobalMsg("^6Ca^Tner^TYıl^Tma^TzInS^Tim.^Tex^Te ^2Lis^Tans ba^Tşar^Tıyl^Ta do^Tğr^Tula^Tnd^Tı!!!");
GlobalMsg("^6Ca^Tner^TYıl^Tma^TzInS^Tim.^Tex^Te ^2Lis^Tans ba^Tşar^Tıyl^Ta do^Tğr^Tula^Tnd^Tı!!!");
GlobalMsg("^6Ca^Tner^TYıl^Tma^TzInS^Tim.^Tex^Te ^2Lis^Tans ba^Tşar^Tıyl^Ta do^Tğr^Tula^Tnd^Tı!!!");
GlobalMsg("^6^TLi^Tsans^Tı a^Tldı^Tğı si^Tte: ww^Tw.Re^TdHo^Tonig^Tan.T^TK");
#	RegisterScheduleAction( "0 0 0 * * * *", SA_mid );
#	RegisterScheduleAction( "0 0 0 * 1 1 *", SA_newyear );
	
#	RegisterNodeAction( "BL1" , 140 , DisplaySpeed,ExitDisplaySpeed );
#	RegisterNodeAction( "BL1R" , 245 , DisplaySpeed,ExitDisplaySpeed );
#	RegisterZoneAction( "BL1" , -60,106, 5 , DisplaySpeed,ExitDisplaySpeed );
EndEvent

Sub SA_mid() # Lapper Event
	globalRcm( langEngine( "%{main_midnight}%" ) );
EndSub

Sub SA_newyear() # Lapper Event
	globalRcm( langEngine( "%{main_newyear}%" ) );
EndSub

Event OnButtonFunction($userName, $SubT) # Player Event When Player push shift+I or Shift+B
#    DEBUG ("Button SubT for " . $userName . " is " . $SubT);
EndEvent

###################################
#Authorization Options ( license )#
###################################
#Authorization Options
#
#$Auth1 $Auth2 ... $Auth10 variable
#Syntax : $AuthX = "Label,Carname:Trackname:MinimumTime&Carname:Trackname:MinimumTime&...| Carname:Trackname:MinimumTime&Carname:Trackname:MinimumTime&... | ...";
#& -> And condition
#| -> Or condition
#
#$AuthAllowPlayer="Auth1|...|AuthX|@username1,username2,...,usernameN";
#or
#$AuthAllowPlayer="All";
#-------------------------------------------------------------------

#$Auth1 = "Bronze,XFG:BL1:1.45.00 | XRT:SO4:1.20.20";
#$Auth2 = "Silver,XFG:BL1:1.40.00 | XRT:SO4:1.20.20";
#$Auth3 = "Gold,XFG:BL1:1.35.00";

$AuthAllowPlayer = "All";

$AuthMinPlayer = 0;	# Minimum number of players on the server to auto enable authorization
			# If number of players is below value, alle players are allowed
			# If number of players is above value, only AuthAllowPlayer are allowed

Event OnAuthAllowed( $userName ) # Player event
	globalMsg( langEngine( "%{main_allowed}%", GetCurrentPlayerVar("NickName") ) );
Endevent

Event OnAuthNotAllowed( $userName ) # Player event
	cmdLFS("/spec "  . GetCurrentPlayerVar("NickName") );
	globalMsg( langEngine( "%{main_notallowed}%", GetCurrentPlayerVar("NickName") ));
Endevent

# Local viariable that can be used
# $auth -> Authorization reached

Event OnAuthReached( $userName,$level ) # Player event
	privMsg(langEngine( "%{main_gotlevel}%", $level ) );
EndEvent

##################
#Swearword filter#
##################
#Specify a list of swearwords seperated by ,
#Specify a file with swearwords, one word per line
#-------------------------------------------------------------------

$SwearWordsList = "fuck,asholes,bastard,idiot";
#$SwearWordsList = "&./swear.txt";
$SwearWordsMax = 2; # Maximum number of allowed swearwords per session

Event OnSwearWords1( $userName ) # Player event
	privMsg( langEngine( "%{main_swear11}%" ) );
	privMsg( langEngine( "%{main_swear12}%", GetCurrentPlayerVar("SwearWordsRem") ) );
EndEvent

Event OnSwearWords2( $userName )  # Player event
	privMsg( langEngine( "%{main_swear21}%" ) );
	cmdLFS( "/spec " . GetCurrentPlayerVar("NickName") );
EndEvent

###########
#Handicaps#
###########
#You can specify 3 levels of handicap : for car, for car and track, for user
#Priority Level low to hight : HandicapCars, HandicapCarsTracks, HandicapUser
#-------------------------------------------------------------------
#Handicap cars
#
#Syntax :
#
#$HandicapCars = "car:mass:irest,car:mass:irest,...,car:mass:irest";
#
#car : LFS short car name
#mass : mass handicap in kg
#irest : Air intake restriction in percent
#-------------------------------------------------------------------
#Handicap cars/tracks
#
#Syntax :
#
#$HandicapCarsTracks = "car/track:mass:irest,car/track:mass:irest,...,car/track:mass:irest";
#
#car : LFS short car name
#track : LFS short track name
#mass : mass handicap in kg
#irest : Air intake restriction in percent
#-------------------------------------------------------------------
#$HandicapUser		# a list of players and their handicap
#			# if you prefix with & , You can indicate a file name that contains a list of racers, one racer per line
#			# if you prefix with @, You can list username separated with ,
#
#Syntax :
#
#$HandicapUsers = "&./your_file";
#$HandicapUsers = "@userName:mass:irest,userName:mass:irest,...userName:mass:irest";
#
#$RefreshHandicapUsers	# allow Lapper to refresh HandicapUsers on each player leaving pits
			# Usefull if HandicapUsers is a file and is updated frequently by an external program
#-------------------------------------------------------------------

#$HandicapCars = "XFG:100:10,XRT:50:10";

#$HandicapCarsTracks = "XFG/BL1:100:10,XRT/AS1:50:10";

#$RefreshHandicapUsers = true;
#$HandicapUsers = "&./your_hand.flt";
#$HandicapUsers = "@Gai-Luron:100:20,gwendoline:100:30,_-ALUCARD-_,lagamel:50:10,lister88,c-quad,shimanofr,bruno7529,boby5,kevinb,edgar,berlioz,la tortue,neron59,eur-can,stff,2psbob,oliv76000";

Event OnToLowHandicap( $userName ) # Player event
	cmdLFS("/spec " . GetCurrentPlayerVar("NickName") );
	globalMsg( langEngine( "%{main_tolowhand1}%",GetCurrentPlayerVar("NickName") ));
	globalMsg( langEngine( "%{main_tolowhand2}%",GetCurrentPlayerVar( "H_Mass" ), GetCurrentPlayerVar("H_Tres")) );
EndEvent

#################
#Control Allowed#
#################
# Racer flags
# "Y" = Yes
# "N" = No
# "*"" = Yes or No
# Local variable
#-------------------------------------------------------------------

$SwapSide = "*";
$AutoGears = "*";
$Shifter = "*";
$HelpBrake = "*";
$AxisClutch = "*";
$AutoClutch = "*";
$Mouse = "*";
$KbNoHelp = "*";
$KbStabilised = "*";
$CustomView = "*";

Event OnNotMatchFlags( $userName ) # Player event
	privMsg(langEngine( "%{main_nomatchflag}%" )  );
	privMsg(langEngine( "%{main_yourflag}%" , GetCurrentPlayerVar("PlayerFlags") ) );
	privMsg(langEngine( "%{main_yourflag}%" , GetLapperVar( "RequiredFlags" ) ) );
	privMsg(langEngine( "%{main_spectated}%" ) );
	cmdLFS("/spec " . GetCurrentPlayerVar("UserName") );
EndEvent

##############
#Race Control#
##############
#Voting:
#
#$InRaceLapsVoteMinMax = Laps in between where votes are allowed in race
#$InRaceLapsVoteMinMax = 0-0 Votes are never allowed
#$InRaceLapsVoteMinMax = -5 Votes are allowed between lap 1 and 5
#$InRaceLapsVoteMinMax = 2- Votes are allowed between laps 2 and the end of the race
#$InRaceLapsVoteMinMax = - Votes are always allowed
#
#$VoteRestart = percentage of players that have to vote to restart a race. To let LFS admin this function, set it to -1
#OnVoteRestartChange = Command to do when player votes to restart
#OnVoteRestartReach = Command to execute when VoteRestart is reached
#OnVoteRestartZero = Command to execute when no nb of player reach zero

#$VoteQualify = percentage of players that have to vote to start a qualification. To let LFS admin this function, set it to -1
#OnVoteQualifyChange = same as restart but for qualify
#OnVoteQualifyReach = same as restart but for qualify
#OnVoteQualifyZero = same as restart but for qualify
#
#$VoteEnd = percentage of players that have to vote to end a race. To let LFS admin this function, set it to -1
#OnVoteEndChange = same as restart but for endrace
#OnVoteEndReach = same as restart but for endrace
#OnVoteEndyZero = same as restart but for endrace
#-------------------------------------------------------------------
#Local variable:
#
#$Vote - Number of players that have voted
#$Remain - Number of players remaining to vote
#$Need - Number of players needed for an action
#$VoteLifeSec = Number of seconds to keep the vote alive after voting
#-------------------------------------------------------------------
#Auto restart:
#
#$AutoRestartRaceSec = Second between the end of a race (last player finished) and an automatic restart
#
#Rotation only work if AutoRestartRaceSec is set
#EnableRotation =	Allow or disallow rotation for track and/or car
#			Values : true or false
#$RotateTracks = "tracks to rotate"; separated by ','
#$RotateCars = "cars to rotate"; separated by ',' Use LFS definition for car, if not set, no car rotation
#$RotateEveryNbRaces = Number of races to do before rotation;
#-------------------------------------------------------------------

$InRaceLapsVoteMinMax = "-";

$VoteRestart = -1;

Event OnVoteRestartChange($PlayerOnTrack, $Vote , $Need) # Lapper Event
	openGlobalButton( "bargr1",60,1,10,6,6,30,96,langEngine( "%{main_vote_restart1}%"));
	openGlobalButton( "bargr2",70,1,20,6,6,30,96,langEngine( "%{main_vote_restart2}%",$Vote,$PlayerOnTrack,$Need ) );
EndEvent

Event OnVoteRestartReach($PlayerOnTrack, $Vote , $Need) # Lapper Event
	closeGlobalButton( "bargr1&bargr2" );
EndEvent

Event OnVoteRestartZero() # Lapper Event
	closeGlobalButton( "bargr1&bargr2" );
EndEvent

$VoteQualify = -1;

Event OnVoteQualifyChange($PlayerOnTrack, $Vote , $Need) # Lapper Event
	openGlobalButton( "bargq1",90,1,10,6,6,30,96,langEngine( "%{main_vote_qualify1}%") );
	openGlobalButton( "bargq2",100,1,20,6,6,30,96,langEngine( "%{main_vote_qualify2}%",$Vote,$PlayerOnTrack,$Need ));
EndEvent

Event OnVoteQualifyReach($PlayerOnTrack, $Vote , $Need) # Lapper Event
	closeGlobalButton("bargq1&bargq2" );
EndEvent

Event OnVoteQualifyZero() # Lapper Event
	closeGlobalButton("bargq1&bargq2" );
EndEvent

$VoteEnd = -1;

Event OnVoteEndChange($PlayerOnTrack, $Vote , $Need) # Lapper Event
	openGlobalButton( "barge1",120,1,10,6,6,30,96,langEngine( "%{main_vote_end1}%") );
	openGlobalButton( "barge2",130,1,20,6,6,30,96,langEngine( "%{main_vote_end2}%",$Vote,$PlayerOnTrack,$Need ) );
EndEvent

Event OnVoteEndReach($PlayerOnTrack, $Vote , $Need) # Lapper Event
 	closeGlobalButton( "barge1&barge2" );
EndEvent

Event OnVoteEndZero() # Lapper Event
 	closeGlobalButton( "barge1&barge2" );
EndEvent

$VoteLifeSec = 30;

$AutoRestartRaceSec = 0;
$AutoRestartOnFirstFinished = false;

$EnableRotation = false;
$RotateTracks = "SO6R,BL1,FE3";
$RotateEveryNbRaces = 4;
$RotateCars = "XFG+UF1,TBO,XFR+UFR";

Event OnRotateCar() # Lapper Event
 	globalMsg(langEngine( "%{main_car_changed}%",getLapperVar( "CurrRotateCar" )));
EndEvent

Event OnRotateTrack() # Lapper Event
 	globalMsg(langEngine( "%{main_track_changed1}%") );
	globalMsg(langEngine( "%{main_track_changed2}%", getLapperVar( "CurrLongRotateTrack" )));
EndEvent

#################################################
#Connect messages when a player joins the server#
#################################################

Event OnConnect( $userName ) # Player event

	IF ( UserIsAdmin( $userName ) == 1 )
      		THEN
	    GlobalMsg ("^1".GetCurrentPlayerVar("NickName") ." ^7^TAdmin ^7Olarak Sunucuya Bağlandı!."); 
cmdLFS("/rcm ".GetCurrentPlayerVar("NickName") ." ^7^TAdmin ^7Giriş Yaptı!");
cmdLFS("/rcm_all");
ELSE
ENDIF
					UserGroupFromFile( "yonetici", "./yonetici.txt" );
			IF( UserInGroup( "yonetici",$userName) )
THEN
	    GlobalMsg ("^1".GetCurrentPlayerVar("NickName") ." ^7^TYönetici ^7Olarak Sunucuya Bağlandı!."); 
cmdLFS("/rcm ".GetCurrentPlayerVar("NickName") ." ^7^TYönetici ^7Giriş Yaptı!");
cmdLFS("/rcm_all");
ELSE
ENDIF
UserGroupFromFile( "yoneticim", "./yoneticim.txt" );
			IF( UserInGroup( "yoneticim",$userName) )
THEN
	    GlobalMsg ("^1".GetCurrentPlayerVar("NickName") ." ^7^TYönetici ^7Olarak Sunucuya Bağlandı!."); 
cmdLFS("/rcm ".GetCurrentPlayerVar("NickName") ." ^7^TYönetici ^7Giriş Yaptı!");
cmdLFS("/rcm_all");
ELSE
ENDIF
UserGroupFromFile( "yoneticii", "./yoneticii.txt" );
			IF( UserInGroup( "yoneticii",$userName) )
THEN
	    GlobalMsg ("^1".GetCurrentPlayerVar("NickName") ." ^7^TYönetici ^7Olarak Sunucuya Bağlandı!."); 
cmdLFS("/rcm ".GetCurrentPlayerVar("NickName") ." ^7^TYönetici ^7Giriş Yaptı!");
cmdLFS("/rcm_all");
ELSE
ENDIF
UserGroupFromFile( "superusers", "./superısers.txt" );
			IF( UserInGroup( "superusers",$userName) )
THEN
	    GlobalMsg ("^1".GetCurrentPlayerVar("NickName") ." ^7^TTestMod ^7Olarak Sunucuya Bağlandı!."); 
cmdLFS("/rcm ".GetCurrentPlayerVar("NickName") ." ^7^TTestMod ^7Giriş Yaptı!");
cmdLFS("/rcm_all");
ELSE
ENDIF
UserGroupFromFile( "moderator", "./moderator.txt" );
			IF( UserInGroup( "moderator",$userName) )
THEN
	    GlobalMsg ("^1".GetCurrentPlayerVar("NickName") ." ^7^TModeratör ^7Olarak Sunucuya Bağlandı!."); 
cmdLFS("/rcm ".GetCurrentPlayerVar("NickName") ." ^7^TModeratör ^7Giriş Yaptı!");
cmdLFS("/rcm_all");
ELSE
ENDIF


					UserGroupFromFile( "kurucu", "./kurucu.txt" );
			IF( UserInGroup( "kurucu",$userName) )
THEN
	    GlobalMsg ("^1".GetCurrentPlayerVar("NickName") ." ^7^TKurucu ^7Olarak Sunucuya Bağlandı!."); 
cmdLFS("/rcm ".GetCurrentPlayerVar("NickName") ." ^7^TKurucu ^7Giriş Yaptı!");
cmdLFS("/rcm_all");
ELSE
ENDIF
EndEvent


Sub OnConnectCloseKick( $KeyFlags,$id )
	closePrivButton("welc&pos&clos&ref");
	cmdLFS("/kick " . GetCurrentPlayerVar("UserName") );
EndSub
##########################################
#New PLayer joining race or leaving pits)#
##########################################

Event OnNewPlayerJoin( $userName )  # Player event
GlobalMsg(" ".GetCurrentPlayerVar("NickName"). " ^7^TAraç ".GetCurrentPlayerVar("Car"). "" );
GlobalMsg(" ".GetCurrentPlayerVar("NickName"). " ^7^TPitten Çıkış Yaptı İyi Oyunlar.");
EndEvent

#####################################################
# Event  when a player changes their nickname
#####################################################

Event OnNameChange($userName,$oldNickName,$newNickName) # Player event
EndEvent

#####################################################
#DisConnect messages when a player leaves the server#
#####################################################

Event OnDisConnect( $userName, $reason ) # Player event
	globalMsg ( langEngine ( "%{main_left_server}%", $userName ));
EndEvent

#############################################$#
#Splitting (general action when passing split)#
###############################################

Event OnSplit1( $userName ) # Player event
EndEvent

Event OnSplit2( $userName ) # Player event
EndEvent

Event OnSplit3( $userName ) # Player event
EndEvent

Event OnLap( $userName ) # Player event
EndEvent

#################################################
#Action when a predefined dist is done by player#
# Minimum dist is 100 meters
# -1 deactivate this feature
#################################################

$distToDo = 1;

Event OnDistDone( $userName ) # Player event
penPrivButton( "speed",30,190,25,8,8,-1,0,langEngine( "%{main_speedtrap}%" , ToPlayerUnit( GetCurrentPlayerVar( "InstantSpeed" ) ),GetCurrentPlayerVar("UnitSpeed") ) );
penGlobalButton( "tarih",182,70,17,4,1,-1,32,"^3Tarih: ^7". GetLapperVar ( "ShortDate" ),"" );
penGlobalButton( "Saat",182,74,17,4,1,-1,32,"^3Saat: ^7". GetLapperVar ( "ShortTime" ),"" );
penGlobalButton( "baglantilar",182,78,17,4,1,-1,32,"^3^TOnline Sayısı: ^7". GetLapperVar( "numConns" ),"" );



EndEvent

#############################################
#Action when a new Gapping Info is available#
#############################################

/*
openPrivButton( "help",25,28,150,10,5,-1,0,"^2Commands list", backcall );
	Open a button for the current player
	1 - Unique id for this button
	2 - Left coordinate for this button ( 0-200 )
		$origL = (value between 0-200); - when this value is used, every next value can be made relative to this one (example: $origL + 5;)
	3 - Top coordinate for this button ( 0-200 )
		$origT = (value between 0-200); - when this value is used, every next value can be made relative to this one (example: $origT + 5;)
	4 - Width of the button ( 0-200 )
	5 - Heigth of the button ( 0-200 )
	6 - Space between line in multiline button
	7 - Duration in seconds for the button to be displayed (use -1 if you don't want an automatic close)
	8 - Format of the button, look at insim.txt for values
	9 - Button caption, for multiline, separate each line with &
	10 - Option name of the backcalled sub
*/


Event OnNewGapPlayerBefore( $userName,$split ) # Player Event
EndEvent

Event OnNewGapPlayerBehind( $userName,	$split )  # Player Event
EndEvent

Event OnChangePos($userName,$lastPos,$currPos)   # Player Event
EndEvent

#######################################################
#Splitting (compare player split to best player split)#
#######################################################

$ShowSplitPB = true; # Set to false if you don't want to see messages about splits

Event OnSpbSplit1( $userName ) # Player event
EndEvent

Event OnSpbSplit2( $userName ) # Player event
EndEvent

Event OnSpbSplit3( $userName ) # Player event
EndEvent

Event OnSpbLast( $userName ) # Player event
EndEvent

####################################################
#Actions to do on splits relative to trackinfo.cfg#
####################################################
#Local variable: {SplitTime} - Split time
#-------------------------------------------------------------------

Sub TRI_split1_0( $userName ) # Player event
	globalMsg(  langEngine( "%{main_great1}%", NumToMSH(GetCurrentPlayerVar("SplitTime")),GetCurrentPlayerVar("NickName") ) );
EndSub

Sub TRI_split1_1( $userName ) # Player event
	globalMsg( langEngine( "%{main_good1}%",NumToMSH(GetCurrentPlayerVar("SplitTime")),GetCurrentPlayerVar("NickName") ) );
EndSub

Sub TRI_split2_0( $userName ) # Player event
	globalMsg(  langEngine( "%{main_great2}%", NumToMSH(GetCurrentPlayerVar("SplitTime")),GetCurrentPlayerVar("NickName") ) );
EndSub

Sub alperkapat( $Keyflags,$id )
	closeButtonRegex (GetCurrentPlayerVar("UserName"), "alper_*"); #kapatma butonu
ClosePrivButton("alper_1&alper_2&alper_3&alper_4&alper_5&alper_6&alper_7&alper_8&");
EndSub

Sub TRI_split2_1( $userName ) # Player event
	globalMsg( langEngine( "%{main_good2}%",NumToMSH(GetCurrentPlayerVar("SplitTime")),GetCurrentPlayerVar("NickName") ) );
EndSub

Sub TRI_split3_0( $userName ) # Player event
	globalMsg(  langEngine( "%{main_great3}%", NumToMSH(GetCurrentPlayerVar("SplitTime")),GetCurrentPlayerVar("NickName") ) );
EndSub

Sub TRI_split3_1( $userName ) # Player event
	globalMsg( langEngine( "%{main_good3}%",NumToMSH(GetCurrentPlayerVar("SplitTime")),GetCurrentPlayerVar("NickName") ) );
EndSub

Sub TRI_lap_0( $userName ) # Player event
	globalMsg( langEngine( "%{main_greatlap}%",NumToMSH( GetCurrentPlayerVar("LapTime") ), GetCurrentPlayerVar("NickName" ) ) );
EndSub

Sub TRI_lap_1( $userName ) # Player event
	globalMsg( langEngine( "%{main_goodlap}%", NumToMSH( GetCurrentPlayerVar("LapTime") ), GetCurrentPlayerVar("NickName") ) );
EndSub

#########################
#List of user qualifying#
#########################
#RefreshQualUsers : allow Lapper to refresh QualUsers on each outgoing pits, Usefull if QualUsers is a file and this is changed frequently by an external program
#QualUser : is a list of racers that participed in the qualification, required for function !nearqual !topqual and !statsqual
#if you prefix with & , You can indicate a file name that contains a list of racers, one racer per line (example : QualUsers = ./userfile.txt;)
#if you prefix with @, You can list usernames separated with ',' (example : QualUsers = @Gai-Luron,gwendoline,_-ALUCARD-_,lagamel;)
#You can specify which car is used by a user adding car after username separated by ':' (example : Gai-Luron:XFR,lagamel:UFR)
#You can specify the scheme of group of this qualification using a special username called DefGroup
#Defgroup Take 3 argument separated with ':'
#1 - Is the number Max of Group for this qualification
#2 - Is the number max of user per group
#3 - Is the minimum of user in the last group, recalc previous group as possible if number is low
#If you ommit scheme of groups, the group of qualification do not appear
#-------------------------------------------------------------------

$RefreshQualUsers = true;
#$QualUsers = "&./your_file.flt";
#$QualUsers = "@DefGroup:5:5:2,Gai-Luron,MataGyula,nesrulz,gwendoline,_-ALUCARD-_,lagamel,lister88,c-quad,shimanofr,bruno7529,boby5,kevinb,edgar,berlioz,la tortue,neron59,eur-can,stff,2psbob,oliv76000";

#################
#Command actions#
#################
#If ! before a name, force nickName authentification if UseUsernameForAuthentication=true
#If ! before a name, force userName authentification if UseUsernameForAuthentication=false
#You can use regexp expression in userName pattern, type regex=your regular expression
#
#Example:	if UseUsernameForAuthentication=true
#		!regex=^\[COP\].*
#		Find all user with a nickname that begins with [COP]
#		regex=^Gai.*
#		Find all user with a username that begins with Gai
# 		See regular expression on web for more info how it work
#
#Use & sign at end of patterns
#-------------------------------------------------------------------

Event OnMSO( $userName, $text ) # Player event
	$idxOfFirtsSpace = indexOf( $text, " ");

	IF( $idxOfFirtsSpace == -1 ) THEN
	  $command = $text;
	  $argv = "";
	ELSE
	  $command = subStr( $text,0,$idxOfFirtsSpace );
	  $argv = trim( subStr( $text,$idxOfFirtsSpace ) );
	ENDIF
	
	SWITCH( $command )

		CASE "!node":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  privMsg(  langEngine( "%{main_currnode}%", GetCurrentPlayerVar( "CurrNode" ) ) );
			ENDIF
			BREAK;
		CASE "!zone":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  privMsg( langEngine( "%{main_currzone}%", GetCurrentPlayerVar( "X" ) . ":" . GetCurrentPlayerVar( "Y" ) ) );
			ENDIF
			BREAK;
		CASE "!dene":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  globalMsg( langEngine( "%{main_lapclose}%" ) );
			  termLapper();
			ELSE
			  privMsg( langEngine( "%{main_notadmin}%" ) );
			ENDIF
			BREAK;
CASE "!sunucu":

PrivMsg("^T^3#^7 Drift Modundasın!");


BREAK;
CASE "!pm":
	IF( $argv != "" )   THEN
		$idxSpace = indexOf( $argv, " ");
	IF( $idxSpace != -1 ) THEN
		$toUser = subStr( $argv,0,$idxSpace );
		$argv = trim( subStr( $argv,$idxSpace ) );
			privMsg ( "^6Ozel Mesaj ^8" . GetPlayerVar( $toUser , "Nickname" )  );
			privMsg ( "^7" . $argv );
			userMsg (GetCurrentPlayerVar( "Nickname" ), $toUser, $argv);
	ELSE
		privMsg ( "^7Komut ^2!pm <username> <message>" );
		privMsg ( "^7(Ornek: ^2!pm ABARTH SelamunAleykum^7)" );
	ENDIF
	ELSE
		privMsg ( "^7Komut: ^2!pm <username> <message>" );
	ENDIF
BREAK;
		




CASE "!top list":
PrivMsg("^6#^1^T  ^7En Çok Oyunda Oynayan Listesi");
PrivMsg("^6#^11.^7yasin32 ");
PrivMsg("^6#^12.^7emirhanfg");
PrivMsg("^6#^13.^7Ismail_PvP");
PrivMsg("^6#^14.^7DarkKnight_0");
PrivMsg("^6#^15.^7admin0");
PrivMsg("^6#^16.^7Kral44 ");
PrivMsg("^6#^17.^7legendscr");
PrivMsg("^6#^18.^7denizcansevinc");
PrivMsg("^6#^19.^7ysntfn");
PrivMsg("^6#^110.^7bos");
PrivMsg("^6#^111.^7bos");
PrivMsg("^6#^112.^7bos");
PrivMsg("^6#^113.^7bos");
PrivMsg("^6#^114.^7bos");
PrivMsg("^6#^115.^7bos");
BREAK;

CASE "!ver":
PrivMsg("^1^T*^7youtube abone ol ");
PrivMsg("^1^T*^1KAYNAK: ^7 DarkOfPro");
PrivMsg("^1^T*^1versyon: ^7 1.0");
BREAK;

CASE "!location":
			IF ( $Mode == 1 )
			THEN
				globalMsg( GetCurrentPlayerVar("NickName") . "^7's " . Location( ) );
			ENDIF
		BREAK;









CASE "!te":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ^1*                                                   *");
     GlobalMsg    (" ".GetCurrentPlayerVar("NickName") ." ^7Tarafindan Chat Temizlendi ");


			ENDIF
			BREAK;



CASE "!ac":
IF ( UserIsAdmin( $userName ) == 1 )
THEN
PrivMsg("^1Admin ^7Sohbeti");
PrivMsg("^8".GetCurrentPlayerVar("NickName") ." ^2 ".$argv );
         ELSE
 PrivMsg    (" ^1 Bu komuta iznin yok!!!");

ENDIF
Break;




CASE "!an":

			$argv1 = substr( $argv,0,30 );

			IF( strlen($argv) > 30 )
			THEN 
				$argv2 = substr( $argv,30,strlen($argv) );
			ENDIF

			IF( $argv2 != "" )
			THEN  
				IF( strlen($argv2) > 30 )
				THEN 
					$argv3 = substr( $argv2,30,strlen($argv2) );
				ENDIF
			ENDIF
			groupCmdLfs( "/msg ^1Duyuru ^7: " . $argv1 );

			IF( $argv2 != "" )
			THEN
				groupCmdLfs( "/msg ^11Duyuru ^7: " . $argv2 );             
			ENDIF

			IF( $argv3 != "" )
			THEN
				groupCmdLfs( "/msg ^1Duyuru ^7: " . $argv3 );             
			ENDIF
		BREAK;


		CASE "!test":
		    MyTest();
			BREAK;
		CASE "!powered":
			http("http://www.frh-team.net/reglapper/getserver2.php");
			BREAK;
		CASE "!license":
		  setLicense( $argv );
	 		BREAK;
CASE "!res":
			IF ( UserIsAdmin( $userName ) == 1 )
      		THEN
				GlobalMsg("^T^3İnsim Admin Veya Yapımcı Tarafından Resetlendi Bekleyiniz...."); 
				GlobalMsg("^T^3İnsim Admin Veya Yapımcı Tarafından Resetlendi Bekleyiniz...."); 
				GlobalMsg("^T^3İnsim Version.2.4.8"); 
				


				reload();
			ELSE
	      		privMsg("^T^7Bu komuta erişmene iznin yok!");
			ENDIF
			BREAK;

		CASE "!offmod":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  privMsg( langEngine( "%{main_ban}%", GetCurrentPlayerVar( "NickName" ), GetPlayerVar( $argv, "NickName" ) ) );
			  cmdLFS( "/ban " . $argv . " 1" );
			ELSE
			privMsg("^T^7Bu komuta erişmene iznin yok!");
			ENDIF
			BREAK;
		CASE "!offmod2":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  privMsg( langEngine( "%{main_ban}%", GetCurrentPlayerVar( "NickName" ), GetPlayerVar( $argv, "NickName" ) ) );
			  cmdLFS( "/ban " . $argv . " 2" );
			ELSE
			privMsg("^T^7Bu komuta erişmene iznin yok!");
			ENDIF
			BREAK;
		CASE "!offmod3":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  privMsg( langEngine( "%{main_ban}%", GetCurrentPlayerVar( "NickName" ), GetPlayerVar( $argv, "NickName" ) ) );
			  cmdLFS( "/ban " . $argv . " 3" );
			ELSE
			privMsg("^T^7Bu komuta erişmene iznin yok!");
			ENDIF
			BREAK;
		CASE "!offmod998":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  privMsg( langEngine( "%{main_ban}%", GetCurrentPlayerVar( "NickName" ), GetPlayerVar( $argv, "NickName" ) ) );
			  cmdLFS( "/ban " . $argv . " 999" );
			ELSE
			privMsg("^T^7Bu komuta erişmene iznin yok!");
			ENDIF
			BREAK;
		CASE "!mod":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  privMsg( langEngine( "%{main_kick}%", GetCurrentPlayerVar( "NickName" ), GetPlayerVar( $argv, "NickName" ) ));
			  cmdLFS( "/kick " . $argv );
			ELSE
			GlobalMsg("Only for admin!");
			ENDIF
			BREAK;
		CASE "sa":
			  privMsg( Aleykümselam Hoşgeldin, İyi Oyunlar, GetPlayerVar( $argv, "NickName" ) ));
			BREAK;
		CASE "Sa":
			  privMsg( Aleykümselam Hoşgeldin, İyi Oyunlar, GetPlayerVar( $argv, "NickName" ) ));
			BREAK;
		CASE "!pitlane":
			IF ( UserIsAdmin( $userName ) == 1 )
			THEN
			  privMsg( langEngine( "GetCurrentPlayerVar("NickName") .^7Kullanıcı Pite Gönderildi!", GetCurrentPlayerVar( "NickName" ), GetPlayerVar( $argv, "NickName" ) ) );
			  cmdLFS( "/pitlane " . $argv . " " );
			ELSE
			privMsg("^T^7Bu komuta erişmene iznin yok!");
			ENDIF
			BREAK;
		CASE "!pos":
			privMsg( langEngine( "%{main_friendpos}%", GetCurrentPlayerVar( "PosAbs" ) ) );
			BREAK;
		CASE "!groupqual":
			privMsg( langEngine( "%{main_groupqual}%", GetCurrentPlayerVar( "GroupQual" ) ) );
			BREAK;
		CASE "!auth":
			privMsg( langEngine( "%{main_level}%", GetCurrentPlayerVar("AuthLevel") ) );
			BREAK;
		CASE "!cleanspb":
			cleanSpb();
			BREAK;
		CASE "!spb":
			showSpb();
			BREAK;
		CASE "!hand":
			showHand( $argv );
			BREAK;
		CASE "!statsqual":
			statsQual( $argv );
			BREAK;
		CASE "!dstatsqual":
			dStatsQual( $argv );
			BREAK;
		CASE "!stats":
			stats( $argv );
			BREAK;
		CASE "!dstats":
			dStats( $argv );
			BREAK;
		CASE "!drfnearqual":
			drfNearQual( $argv );
			BREAK;
		CASE "!drfnear":
			drfNear( $argv );
			BREAK;
		CASE "!mypb":
			CurrentPlayerlfsWorldPB( $argv );
			BREAK;
		CASE "!myconfig":
			myConfig( );
			BREAK;
		CASE "!drf":
			drf( $argv );
			BREAK;
		CASE "!drfqual":
			drfQual( $argv );
			BREAK;
		CASE "!distance":
			privMsg(langEngine( "%{main_dist}%"
							,GetCurrentPlayerVar( "Car" )
							,GetLapperVar("ShortTrackName")
							,ToPlayerUnit( GetCurrentPlayerVar("Dist") )
							,GetCurrentPlayerVar("UnitDist")
							,ToPlayerUnit( GetCurrentPlayerVar("SessDist") )
							,GetCurrentPlayerVar("UnitDist")
			));
			BREAK;
		CASE "!laps":
			privMsg(langEngine( "%{main_lapdone}%"
							,GetCurrentPlayerVar("Car")
							,GetLapperVar("ShortTrackName")
							,GetCurrentPlayerVar("Laps")
							,GetCurrentPlayerVar("SessLaps") ) );
			 BREAK;
		CASE "!pit":
			privMsg( langEngine( "%{main_timeinpit}%",NumToMSH (GetCurrentPlayerVar("TotalPitTime"))));
			BREAK;
		CASE "!track":
			privMsg( langEngine( "%{main_trackused}%",GetLapperVar("ShortTrackName"),GetLapperVar("LongTrackName") ) );
			BREAK;
		CASE "!time":
			privMsg( langEngine( "%{main_serverclock}%",GetLapperVar("LongTime") ) );
			BREAK;
		CASE "!reload":
			IF ( UserIsAdmin( $userName ) == 1 )
      		THEN
				privMsg("Restarting and reloading config!");
				reload();
			ELSE
	      		privMsg("Only for admin!");
			ENDIF
			BREAK;
		CASE "!ps":
		    IF( $argv == "" ) THEN
				PstInfo( $userName );
			ELSE
				PstInfo( $argv );
			ENDIF
			BREAK;
#		CASE "!t":
#			privMsg( GetCurrentPlayerVar("Tpb"));
#			 BREAK;
	ENDSWITCH
EndEvent

Sub MA_closeHelp( $KeyFlags,$id )
	closePrivButton("help&help2&close");
EndSub

#####################################
#Action on teleport to pit (Shift+P)#
#####################################

# Actions to execute when player spectates or disconnects (leaves race).

Event OnLeaveRace( $userName )  # Player event
#	privMsg( GetCurrentPlayerVar("NickName" ) . "^8 left the race!" );
EndEvent

###############################
#Action a player flooding chat#
###############################

Event OnFlood( $userName ) # Player event
	privMsg( langEngine( "^7Flood Atmaktan Dolayi Atildin!", GetCurrentPlayerVar("NickName") ) );
	cmdLFS( "/kick " . GetCurrentPlayerVar("UserName" ) );
EndEvent

$MaxFloodLines = 5; # Maximum number of consecutive lines allowed

$MaxFloodLinesTime = 5000; # Maximum time between two consecutive lines in milliseconds to count as flooding

###################################
#Action on Practice, Qual and race#
###################################

Event OnPracStart( $numP ) # Lapper event
EndEvent

# Reorder grid can be "LFS", "PB", "WR"
$ReorderGrid = "LFS";

Event OnRaceStart( $NumP ) # Lapper event
EndEvent

Event OnQualStart( $NumP ) # Lapper event
	  DelayedCommand( 5, OQS );
EndEvent

Event OnFinish( $userName ) # Player event
EndEvent

Event OnResult( $userName,$flagConfirm ) # Player event
/*
    $WinnerName = GetCurrentPlayerVar("NickName");

    IF( GetCurrentPlayerVar( "FinishedPos" ) == "1" )
    THEN
		  $TopDamier = 133;
		  $leftDamier = 105;
      openGlobalButton( "number_1",62,137,20,32,3,10,0,"^01");
      openGlobalButton( "number_2",67,137,10,32,3,10,16," ");
      openGlobalButton( "winner_title",78,137,63,19,4,10,96,"Winner ");
      openGlobalButton( "winner_name",78,158,58,10,3,10,64,$WinnerName );

      openGlobalButton( "winner_backing",66,136,76,34,3,10,32," ");
		  openGlobalButton( "winner_backing2",$leftDamier,$TopDamier,34,14,12,10,0,"^1^L^H^9¡½  ¡½  ¡½  ¡½");
		  openGlobalButton( "winner_backing3",$leftDamier,$TopDamier+6,38,14,12,10,0,"^1^L^H^9   ¡½  ¡½  ¡½  ¡½");
		  openGlobalButton( "winner_backing4",$leftDamier,$TopDamier+12,34,14,12,10,0,"^1^L^H^9¡½  ¡½  ¡½  ¡½");
    ENDIF
*/
EndEvent

#########################
#Action to do on session#
#########################

$MaxSessionLaps = 2;

Event OnMaxSessionLaps( $userName ) # Player event
#	privMsg( "Max session laps reacheds" );
EndEvent

###############################
#Options on spinning detection#
###############################

$MinAngleVelocity = 250; # Minimum angle velocity to trigger action. Possible values: 0 - 720

# Action to execute when angle velocity is higher than MinAngleVelocity.

Event OnAngleVelocity( $userName ) # Player event
	globalMsg( langEngine( "%{main_lost_control}%" ,GetCurrentPlayerVar("NickName") ) );
EndEvent

$MaxNbInStunt = 20; #MaxNbInStunt is max time (in 100 ms) allowed in stunt mode before OnMaxNbInStunt is executed. If -1 No OnMaxNbInStunt are activated

Event OnMaxNbInStunt( $userName ) # Player event
#	cmdLFS( "/spec " . GetCurrentPlayerVar("NickName") );
EndEvent

#################################
#Actions when player is too slow#
#################################

#$MaxAllowedLapTime1 = 100; # % Max allowed time to complete a lap relative to MaxLapTime in trackInfo.cfg

/*
Event OnMaxAllowedLapTime1( $userName ) # Player event
	privMsg( langEngine( "%{main_toslow1}%" ,$MaxAllowedLapTime1 ) );
	privMsg( langEngine( "%{main_toslow2}%" , GetCurrentPlayerVar("MaxAllowedLapTime2") ) );
EndEvent
*/

#$MaxAllowedLapTime2 = 150; # % Max allowed time to complete a lap relative to MaxLapTime in trackInfo.cfg

/*
Event OnMaxAllowedLapTime2( $userName ) # Player event
	privMsg( langEngine( "%{main_toslowvery1}%" ) );
	globalMsg( langEngine( "%{main_toslowvery2}%", GetCurrentPlayerVar("NickName") ) );
	cmdLFS( "/spec " . GetCurrentPlayerVar("UserName") );
EndEvent
*/

##################################
#Options for idle player on track#
##################################

#$IdleExclude = "Lagamel,Gai-Luron"; # Usernames excluded for idle check

$OnIdleTimeout1 = 60; # Idle timeout for OnIdleAction1 in seconds

Event OnIdle1( $userName ) # Player event
	UserGroupFromFile( "idleExempt", "./idleexempt.txt" );
	IF( UserInGroup( "idleExempt",$userName ) == 0 )
	THEN
		privMsg( langEngine( "%{main_idle1}%" ) );
	ENDIF
EndEvent

$OnIdleTimeout2 = 120; # Idle timeout for OnIdleAction2 in seconds

Event OnIdle2( $userName ) # Player event
	UserGroupFromFile( "idleExempt", "./idleexempt.txt" );
	IF ( UserInGroup( "idleExempt",$userName ) == 0 )
	THEN
		cmdLFS ( "/spec " . GetCurrentPlayerVar("Nickname") );
		privMsg ( langEngine( "%{main_idle2}%" ) );
	ENDIF
EndEvent

##################
#Drifting options#
##################
# This is the filepath for a file containing the collected data.
# This file will be created if it doesnt exist yet.
# You must ensure read/write access to this path.
#-------------------------------------------------------------------

$DriftDatabase = "./DriftPB";
$MinimumDriftSpeed = 50; # Minimum speed in km/h to maintain. Driving below that speed will reset score
$MinimumDriftAngle = 15; # Minimum angel to maintain. When angle is below value, score is reset
$MaximumDriftAngle = 100; # Maximum angel to maintain. When angle is above value, score is reset

# Actions to do on new personal best drift lap.
Event OnDriftPB( $userName ) # Player event
EndEvent

# Actions to do to when total lap drift score is higher or equal to MinimumDriftScore.
Event OnDriftLap( $userName ) # Player event
EndEvent

Event OnDriftScore( $userName ) # Player event
EndEvent

$GoodDriftScore = 4000; # Value to be reached to execute action on good drift score

Event OnGoodDrift( $userName ) # Player event
EndEvent

$MinimumDriftScore = 10; # Minimum drift score required

# Actions to do at end of lap if MinimumDriftScore is not achieved.
Event OnDriftTooLow( $userName ) # Player event
EndEvent

# Actions to do when drift score is resette to zero when to low speed.
Event OnDriftResetScore( $userName ) # Player event
EndEvent

################################
#Options for hotlapping options#
################################

$GripDatabase = "./GripPB";	# This is the filepath of a file containing the collected data
				# This file will be created if it doesnt exist yet
				# You must ensure read/write access to this path

$LapTimeUsedForPb = 1; # How many PB lap used to make average PB time, Min = 1 and Max = 10

# Action to do on new personal best lap.
# OnPBQual for the racer who make qualif ( in QualUser )
# OnPB the other racer

Event OnPB( $userName ) # Player event
	globalMsg( langEngine( "%{main_onnewpb}%" , GetCurrentPlayerVar("NickName"), GetCurrentPlayerVar("Car"),NumToMSH(GetCurrentPlayerVar("LapTime")) ) );
	globalMsg( langEngine( "%{main_onnewpb_rank}%" ,GetCurrentPlayerVar("PosAbs") ) );
	privMsg( langEngine( "%{main_onnewpb_sesslaps}%" , GetCurrentPlayerVar("SessLaps") ) );
	privMsg( langEngine( "%{main_onnewpb_servlaps}%" , GetCurrentPlayerVar("Laps") ) );
	privMsg( langEngine( "%{main_onnewpb_avgspeed}%" ,ToPlayerUnit( GetCurrentPlayerVar("AvgSpeed") ),GetCurrentPlayerVar("UnitSpeed") ) );
	privRcm(  langEngine( "%{main_onnewpb_rank2}%" ,GetCurrentPlayerVar("Car"),GetCurrentPlayerVar("PosAbs") ) );
EndEvent

Event OnPBQual( $userName ) # Player event
	globalMsg( langEngine( "%{main_onnewpbqual}%" ,GetCurrentPlayerVar("NickName"),NumToMSH( GetCurrentPlayerVar("LapTime")) ) );
	globalMsg( langEngine( "%{main_onnewpbqual_rank}%" , GetCurrentPlayerVar("PosAbs") ) );
	privMsg( langEngine( "%{main_onnewpbqual_pos}%" ,GetCurrentPlayerVar("Posqual") ) );
	privMsg( langEngine( "%{main_onnewpbqual_pool}%" ,GetCurrentPlayerVar("GroupQual") ) );
	privMsg( langEngine( "%{main_onnewpbqual_avgspeed}%" , ToPlayerUnit( GetCurrentPlayerVar("AvgSpeed") ), GetCurrentPlayerVar("UnitSpeed") ) );
	privRcm( langEngine( "%{main_onnewpbqual_posqual}%" ,GetCurrentPlayerVar("NickName"),GetCurrentPlayerVar("Posqual"),GetCurrentPlayerVar("GroupQual") ) );
EndEvent

##########################
#Options for acceleration#
##########################

$AccelerationStartSpeed = 1; # At which speed to start measuring time. In km/h
$AccelerationEndSpeed = 100; # At which speed to stop measuring time. In km/h

$AccelerationStartSpeedMph = 1; # At which speed to start measuring time. In Mph
$AccelerationEndSpeedMph = 60; # At which speed to stop measuring time. In Mph

$AccelerationPrivateMaxTime = 10; # Maximum acceleration time in seconds to show message

#Message to show to players.
#Possible variables to use:
#{AccelerationStartSpeed} - Starting speed
#{AccelerationEndSpeed} - Ending speed
#{AccelerationTime} - Acceleration time achieved from start to end speed
#{UnitSpeed} Unit of the Speed of the player connected

Event OnAcceleration( $userName )  # Player event
	privMsg( langEngine( "%{main_accel}%" ,GetCurrentPlayerVar("AccelerationTime"),GetCurrentPlayerVar("AccelerationEndSpeed"),GetCurrentPlayerVar("UnitSpeed") ) );
EndEvent

############################
#Actions to do on Car Reset#
############################

$MaxCarResets = 0;        # Set to a positive number to limit number of race resets

Event OnMaxCarResets( $userName ) # Player event Spectate if player has used car reset more than the max
    globalMsg( langEngine( "%{main_maxreset}%" , GetCurrentPlayerVar( "NickName" ) ) );
    cmdLFS( "/spec " . GetCurrentPlayerVar( "UserName" ) );
EndEvent

Event OnCarReset( $userName ) # Player event Player event Do something when the car resets
    globalMsg( langEngine( "%{main_oncarreset}%", GetCurrentPlayerVar( "NickName" ),GetCurrentPlayerVar( "LapsDone" )+1 ));
    IF( getConfigVar("MaxCarResets") > 0 && getLapperVar( "RaceLaps" ) != 0 )
    THEN
        openPrivButton( "carres_warn",50,60,100,15,5,4,16, langEngine( "%{main_specwarn}%" ) );
        openPrivButton( "carres_msg1",50,75,100,10,5,4,16,langEngine( "%{main_resetrest}%",getConfigVar("MaxCarResets") - GetCurrentPlayerVar( "NumCarResets" )));
        privdelayedcommand( 4, ApplyCarResetPenalty);
    ELSE
        privdelayedcommand( 1, ApplyCarResetPenalty);
    ENDIF
EndEvent

Sub ApplyCarResetPenalty( $userName )
    IF( GetCurrentPlayerVar( "LapsDone" ) > 0 )
    THEN
        IF( getLapperVar( "RaceLapsLeft" ) <= 1 )
        THEN
            cmdLFS( "/p_30 " . GetCurrentPlayerVar( "UserName" ) );
        ELSE
            cmdLFS( "/p_dt " . GetCurrentPlayerVar( "UserName" ) );
        ENDIF
    ENDIF
EndSub

######################
#Actions for pit stop#
######################
#Local variable tou can use
#-------------------------------------------------------------------
# no pit windows if two var set to 0

$PitWindowStart=0;
$PitWindowStop=0;

Event OnNotPitWindow( $userName )  # Player event
	privMsg( langEngine( "%{main_notpitwindow}%" ,GetCurrentPlayerVar("NickName"),getConfigVar("PitWindowStart"),getConfigVar("PitWindowStop") ) );
EndEvent

Event OnBeginPitWindow( $userName ) # Player event
	privMsg( langEngine( "%{main_inpitwindows}%" ,GetCurrentPlayerVar("NickName") ) );
EndEvent

Event OnEndPitWindow( $userName )  # Player event
	privMsg( langEngine( "%{main_outpitwindows}%", GetCurrentPlayerVar("NickName"] ) ));
EndEvent

Event OnBeginPit( $userName )  # Player event
	globalMsg( langEngine( "%{main_beginpit}%", GetCurrentPlayerVar("NickName") ) );
	privMsg( langEngine( "%{main_pitwork}%", GetCurrentPlayerVar("pitWork") ) );
EndEvent

Event OnEndPit( $userName )  # Player event
EndEvent

Event OnPit( $userName )  # Player teleported to pit () Shift + P )'
EndEvent

Event OnEnterPitLane( $userName,$reason ) # Player event
# $reason
#	"ENTER"		// entered pit lane
#	"NO_PURPOSE"	// entered for no purpose
#	"DT"		// entered for drive-through
#	"SG"		// entered for stop-go
EndEvent

Event OnExitPitLane(  $userName ) # Player event
EndEvent

#$FL_Changed -> Front Left Changed  : 1 Changed 0 No
#$FR_Changed -> Front Right Changed : 1 Changed 0 No
#$RL_Changed -> Rear Left Changed : 1 Changed 0 No
#$RR_Changed -> Rear Right Changed : 1 Changed 0 No

Event OnChangeTyres( $userName, $FL_Changed, $FR_Changed, $RL_Changed, $RR_Changed ) # Player event
EndEvent

######################
#Actions on penalties#
######################
#Possible variables to use:
#
#OnFastDriveOnPitL1 = Actions on 30 Sec Penalty or drive-through
#OnFastDriveOnPitL2 = Actions on 45 Sec Penalty or Stop&Go
#MaxFastDriveOnPit = Max Fast Drive on Pit allowed per race
#OnMaxFastDriveOnPit = Actions on Max Fast Drive on Pit allowed
#OnFalseStartL1 = 30 Sec Penalty or drive-through
#OnFalseStartL2 = 45 Sec Penalty or Stop&Go
#
#Local Variable can be used:
#
#-------------------------------------------------------------------

Event OnFastDriveOnPitL1( $userName ) # Player event
	globalMsg( langEngine( "%{main_fastdrivepitl1_1}%",GetCurrentPlayerVar("NickName") ) );
	privMsg( langEngine( "%{main_fastdrivepitl1_2}%" ) );
EndEvent

Event OnFastDriveOnPitL2( $userName ) # Player event
	globalMsg( langEngine( "%{main_fastdrivepitl2_1}%",GetCurrentPlayerVar("NickName") ) );
	privMsg( langEngine( "%{main_fastdrivepitl2_2}%", GetCurrentPlayerVar("RemainFDIP" ) ) );
	cmdLFS( "/spec " . GetCurrentPlayerVar( "UserName" ) );
EndEvent

Event OnMaxFastDriveOnPit( $userName ) # Player event
	globalMsg( langEngine( "%{main_maxfastdrivepit1}%",GetCurrentPlayerVar("NickName") ) );
	privRcm( langEngine( "%{main_maxfastdrivepit2}%"  ) );
	cmdLFS( "/kick " . GetCurrentPlayerVar("UserName") );
EndEvent

$MaxFastDriveOnPit = 2;

Event OnFalseStartL1( $userName ) # Player event
EndEvent

Event OnFalseStartL2( $userName ) # Player event
EndEvent

Event OnREO ( $NumP, $ReqI, $GridOrder ) # Lapper event to recieve Race Order - can request it using RequestREO( );
	# NumP: Number of Players in this Race
	# ReqI: 0 = packet was server initiated, > 0 packet was user requested
	# GridOrder : Comma separated list of PLIDs in grid order
#	globalMsg ( "Reoorder list = " . $GridOrder);
EndEvent

Event OnRaceEnd( ) # Lapper event generated when server returns to main menu, ending the race (CTRL-X vote)
EndEvent

####################
#    Default Sub   #
####################

Sub PstInfo($userName )
	$currPly = getPlayerInfo( $userName );
	if( $currPly == "" ) THEN
	    WriteLine( "Coucou");
		RETURN();
	ENDIF
	openPrivButton( "Back",74,58,52,64,5,-1,ISB_DARK, "" );
	openPrivButton( "PSNickName",75,59,50,5,5,-1,ISB_DARK, $currPly["NickName"] . " ^7( " . $currPly["PSCountry"] . " )" );
	openPrivButton( "PSDistance",75,65,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_psdistance}%", strFormat( "{0:0}", ToPlayerUnit( $currPly["PSDistance"]/1000 )),$currPly["UnitDist"]) );
	openPrivButton( "PSFuel",75,70,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_psfuel}%", strFormat( "{0:0}", $currPly["PSFuel"]/1000)) );
	openPrivButton( "PSLaps",75,75,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_pslaps}%", $currPly["PSLaps"]) );
	openPrivButton( "PSWins",75,80,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_pswins}%", $currPly["PSWins"]) );
	openPrivButton( "PSSecond",75,85,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_pssecond}%", $currPly["PSSecond"]) );
	openPrivButton( "PSThird",75,90,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_psthird}%", $currPly["PSThird"]) );
	openPrivButton( "PSFinished",75,95,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_psfinished}%", $currPly["PSFinished"]) );
	openPrivButton( "PSQuals",75,100,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_psquals}%", $currPly["PSQuals"]) );
	openPrivButton( "PSPole",75,105,50,5,5,-1,ISB_LIGHT|ISB_LEFT, langEngine("%{main_pspole}%", $currPly["PSPole"]) );
	openPrivButton( "pstclose",75,111,50,10,5,-1,ISB_DARK, langEngine("%{main_close}%"),ClosePstInfo );
EndSub

Sub ClosePstInfo( $KeyFlags,$id )
	closePrivButton( "pstclose&Back&PSNickName&PSDistance&PSFuel&PSLaps&PSWins&PSSecond&PSThird&PSFinished&PSQuals&PSPole");
EndSub

####################
#Overriding options#
####################

include( "./includes/addonsused.lpr");

#######################
#Language Translations#
#######################

Lang "EN"
	main_welc1 = "^7Welcome {0} ^7DENEME ^1YAPILIYOR ^7powered server !%nl%^2Type ^7!help ^2after leaving garage to see commands.";
	main_welc2 = "^7Your actual friendly Position (all visitors) : ^7{0}%nl%^2Your actual League prequalify Position : {1}^6Estimate Pool : {2}%nl%Don't use swearwords on this server%nl%respect other player%nl%otherwise you can be banned";
	main_accept = "Accept";
	main_deny = "Deny";
	main_speedtrap = "^2{0} {1}";
	main_gotlevel =  "^3You have got level: {0}";
	main_swear11 = "^1Don't use this words on this server";
	main_swear12 = "You will be spectated in ^2{0} ^1 more attempt(s)";
	main_swear21 = "Too many swearwords, spectated";
	main_nomatchflag = "Flags not match required flags";
	main_yourflag =  "Yours flags -> {0}";
	main_requiredflag = "Required flags -> {0}" ;
	main_spectated = "Spectated";
	main_notadmin = "You are not an Admin!";
	main_currnode = "The Current Node is : {0}";
	main_currzone = "The Current Zone is : {0}";
	main_lapclose = "^T^3 İNSİM ADMİN TARAFINDAN KAPATILDI";
	main_ban = "{0} ^7Moderator Tarafindan Ban Atılmiştir {1}";
	main_kick = "{0} ^7Moderator Tarafından Kick Atilmistir {1}";
	main_friendpos = "Your friendly position is {0}";
	main_groupqual = "Your groupqual is {0}";
	main_level = "^3You have level(s): {0}";
	main_dist = "Distance done on {0}/{1} = {2} {3}, session = {4} {5}";
	main_lapdone = "Laps done on {0}/{1} = {2}, session = {3}";
	main_timeinpit = "Time in pitting {0}";
	main_trackused = "Track in use : {0} = {1}";
	main_serverclock = "Server time clock reference : {0}";
	main_midnight = "Midnight warning to all working men!";
	main_newyear = "Happy New Year!";
	main_allowed = "{0}^3 allowed on this server";
	main_notallowed = "{0}^3 not allowed on this server";
	main_tolowhand1 = "{0}^3 spectated for too low handicap";
	main_tolowhand2 = "^3need {0}kg and {1}% of intake restriction!";
	main_vote_restart1 = "Restart:";
	main_vote_restart2 = "({0}/{1}) Need {2}";
	main_vote_qualify1 = "Qualify";
	main_vote_qualify2 = "({0}/{1}) Need {2}";
	main_vote_end1 = "End:";
	main_vote_end2 = "({0}/{1}) Need {2}";
	main_car_changed = "Car changed, go to pit! Current car = {0}";
	main_track_changed1 = "Track changed, please wait!";
	main_track_changed2 = "Current Track = {0}";
	main_left_server = "{0} ^T^7Adlı Kullanıcı Çıkış Yaptı Tekrar Bekleriz... ";
	main_great1 = "Great 1st split ({0}) by {1}^8!";
	main_good1 = "Good 1st split ({0}) by {1}^8!";
	main_great2 = "Great 2nd split ({0}) by {1}^8!";
	main_good2 = "Good 2nd split ({0}) by {1}^8!";
	main_great3 = "Great 3rd split ({0}) by {1}^8!";
	main_good3 = "Good 3rd split ({0}) by {1}^8!";
	main_greatlap = "Great lap ({0}) by {1}^8!";
	main_goodlap = "Good lap ({0}) by {1}^8!";
	main_flood = "{0} ^3^T Flood Atmaktan Dolayı Atıldın! !"
	main_on_result = "Finished Pos = {0}";
	main_lost_control = "^1Dikkat Kanka ^8{0} ^7 Kaza Yapti..!";
	main_toslow1 = "you are too slow! Max : {0}";
	main_toslow2 = "kick on {0}";
	main_toslowvery1 = "You are very slow, spectated!";
	main_toslowvery2 = "{0} is too slow, spectated!";
	main_idle1 = "^3You are idle and will be spectated in 10 seconds" ;
	main_idle2 = "^3You are spectated for non-activity";
	main_onnewpb = "New PB by {0}^8 ({1}): {2}";
	main_onnewpb_rank = "Friendly rank : {0}";
	main_onnewpb_sesslaps = "Session laps done = {0}";
	main_onnewpb_servlaps = "Total laps done (server) = {0}";
	main_onnewpb_avgspeed = "Average speed: {0}{1}";
	main_onnewpb_rank2 = "Friendly {0} rank: ^7{1}";
	main_onnewpbqual = "League - New QT by {0}^8:{1}";
	main_onnewpbqual_rank = "Friendly rank (all visitors): ^7{0}";
	main_onnewpbqual_pos = "^2Qualify pos.: {0}";
	main_onnewpbqual_pool = "^6Actual Pool: {0}";
	main_onnewpbqual_avgspeed = "Average speed: {0}{1}";
	main_onnewpbqual_posqual = "{0} ^2Pos:{1} - Pool:{2}";
	main_accel = "^8Oha ^3{0}^8 Saniede Bu Hiza Ulastin :){1} {2}!";
	main_notpitwindow = "{0} ^1You are not on pit Windows, allowed in {1}-{2}";
	main_inpitwindows = "{0} ^1You are allowed to pit";
	main_outpitwindows = "{0}  ^1You are not allowed to pit";
	main_beginpit = "{0}^8 makes a pit stop";
	main_pitwork = "Pit begin Work:{0}";
	main_fastdrivepitl1_1 = "{0}^1 Warning for fast driving in pit";
	main_fastdrivepitl1_2 = "^1WARNING-KICK POSSIBLE";
	main_fastdrivepitl2_1 = "{0}^1 Spectated for fast driving in pit";
	main_fastdrivepitl2_2 = "^1WARNING: YOU WILL BE KICKED IF YOU SPEED IN PITS {0} MORE TIME";
	main_maxfastdrivepit1 = "{0}^1 kicked for fast driving in pit";
	main_maxfastdrivepit2 = "^1YOU HAVE BEEN KICKED FOR SPEEDING IN PITS TOO MANY TIMES";
	main_maxreset = "{0} spectated for exceeding max car resets";
	main_oncarreset = "Car Reset by {0} on lap {1}";
	main_specwarn = "^1Spectate Warning";
	main_resetrest = "^2You have^3 {0} ^2car resets left";
	main_close = "Close";
	main_psdistance = "^7Distance: ^2{0} ^7{1}";
	main_psfuel = "^7Fuel used: ^2{0} ^7liters ";
	main_pslaps = "^7Laps done: ^2{0}";
	main_pswins = "^7Wins: ^2{0}";
	main_pssecond = "^7Second: ^2{0}";
	main_psthird = "^7Third: ^2{0}";
	main_psfinished = "^7Race finished: ^2{0}";
	main_psquals = "^7Qualifications done: ^2{0}";
	main_pspole = "^7Poles done: ^2{0}";
	built_pos = "Pos";
	built_grp = "Grp";
	built_car = "Car";
	built_track = "Track";
	built_nick = "NickName";
	built_pb = "Pb";
	built_split = "Split";
	built_splits = "Splits";
	built_points = "Points";
	built_nolfspb = "LFS World PB not yet retreived";
	built_nolfspbcrit = "No LFS World PB for this criteria";
	built_lapsdone = " Laps Done";
	built_hand_nick = "^3{0}^9 handicap:";
	built_hand_curr = "  - Current {0}Kg - Intake Restr.: {1}%";
	built_hand_req =  "  - Required {0}^9 {1}Kg - Intake Rest.: {2}%";
EndLang

Lang "FR"
	main_welc1 = "^7Bienvenue {0} ^7sur ce serveur Géré par ^1LFSLapper^7!%nl%^2Tapez ^7!help ^2 pour voir les commandes après avoir quitté le garage";
	main_welc2 = "^7Votre position absolue (Tous les visiteurs) : ^7{0}%nl%^2Votre position de préqualification : {1}^6Estimation de poule : {2}%nl%Ne pas employer de mots grossiers sur ce serveur%nl%Respecter les autres joueurs%nl%sinon vous risquez d'être banni";
	main_accept = "Accepter";
	main_deny = "Refuser";
	main_speedtrap = "Radar = {0} {1}";
	main_gotlevel =  "^3Vous avez atteind le niveau: {0}";
	main_swear11 = "^1Ne pas utiliser de gros mots ici";
	main_swear12 = "Encore {0} gros mot(s) et vous passerez spectateur";
	main_swear21 = "Trop de gros mots, spectateur";
	main_nomatchflag = "Flags ne correspondent pas aux flags requis";
	main_yourflag =  "Vos flags -> {0}";
	main_requiredflag = "Flags requis -> {0}" ;
	main_spectated = "Spectateur";
	main_notadmin = "Vous n'êtes pas admin!";
	main_currnode = "Le noeud courant est: {0}";
	main_currzone = "La zone courante est: {0}";
	main_lapclose = "Lapper fermé par un administrateur!";
	main_ban = "{0} a banni {1}";
	main_kick = "{0} a kické {1}";
	main_friendpos = "Votre position absolue est {0}";
	main_groupqual = "Votre poule est {0}";
	main_level = "^3Vous avez le(s) niveau(x): {0}";
	main_dist = "Distance réalisée avec {0}/{1} = {2} {3}, session = {4} {5}";
	main_lapdone = "Tours réalisés avec {0}/{1} = {2}, session = {3}";
	main_timeinpit = "Temps passé aux stands {0}";
	main_trackused = "Circuit actuel: {0} = {1}";
	main_serverclock = "Heure du serveur: {0}";
	main_midnight = "Minuit, attention aux travailleurs!";
	main_newyear = "Bonne année!";
	main_allowed = "{0}^3 autorisé sur ce serveur";
	main_notallowed = "{0}^3 non autorisé sur ce serveur";
	main_tolowhand1 = "{0}^3 spectateur car handicap trop faible";
	main_tolowhand2 = "^3Requis {0}kg et {1}% de limitation à l'admission!";
	main_vote_restart1 = "Redémarrer:";
	main_vote_restart2 = "({0}/{1}) Requis {2}";
	main_vote_qualify1 = "Qualify";
	main_vote_qualify2 = "({0}/{1}) Requis {2}";
	main_vote_end1 = "Finir:";
	main_vote_end2 = "({0}/{1}) Requis {2}";
	main_car_changed = "La voiture a changé, Allez aux pits! Voiture = {0}";
	main_track_changed1 = "Changement de circuit, patientez!";
	main_track_changed2 = "Circuit actuel = {0}";
	main_left_server = "{0} part du serveur";
	main_great1 = "Superbe 1er split ({0}) par {1}^8!";
	main_good1 = "Bon 1er split ({0}) par {1}^8!";
	main_great2 = "Superbe 2ème split ({0}) par {1}^8!";
	main_good2 = "Bon 2ème split ({0}) par {1}^8!";
	main_great3 = "Superbe 3ème split ({0}) par {1}^8!";
	main_good3 = "Bon 3ème split ({0}) par {1}^8!";
	main_greatlap = "Superbe tour ({0}) par {1}^8!";
	main_goodlap = "Bon tour ({0}) par {1}^8!";
	main_flood = "{0}^7^TFlood Atmayı Bırak Artık!";
	main_on_result = "Position finale = {0}";
	main_lost_control = "^1Danger! ^8{0} ^2a perdu le contrôle!";
	main_toslow1 = "Vous être trop lent! Max : {0}";
	main_toslow2 = "Vous serez kické dans {0}";
	main_toslowvery1 = "Vous êtes vraiment trop lent, spectateur!";
	main_toslowvery2 = "{0} est trop lent, spectateur!";
	main_idle1 = "^3Vous êtes inactif et passerez spectateur dans 10 secondes" ;
	main_idle2 = "^3Vous êtes passé spectateur car inactif!";
	main_onnewpb = "Nouveau PB par {0}^8 ({1}): {2}";
	main_onnewpb_rank = "Position absolue : {0}";
	main_onnewpb_sesslaps = "Tours réalisés durant la session = {0}";
	main_onnewpb_servlaps = "Tours réalisés sur le serveur = {0}";
	main_onnewpb_avgspeed = "Vitesse moyanne: {0}{1}";
	main_onnewpb_rank2 = "Voiture {0} position: ^7{1}";
	main_onnewpbqual = "Ligue - Nouveau temps de qualif par {0}^8:{1}";
	main_onnewpbqual_rank = "Position absolue: ^7{0}";
	main_onnewpbqual_pos = "^2Position Qualifiquation.: {0}";
	main_onnewpbqual_pool = "^6Poule actuelle: {0}";
	main_onnewpbqual_avgspeed = "Vitesse moyenne: {0}{1}";
	main_onnewpbqual_posqual = "{0} ^2Pos:{1} - Poule:{2}";
	main_accel = "^8De 0 à {1}{2} en ^3{0}^8 secondes!";
	main_notpitwindow = "{0} ^1Stand fermés, ouverture entre {1}-{2}";
	main_inpitwindows = "{0} ^1Vous êtes autorisé à pitter";
	main_outpitwindows = "{0}  ^1Vous n'êtes pas autorisé à pitter";
	main_beginpit = "{0}^8 s'arrête au stand";
	main_pitwork = "Début d'arrêt au stand! Travail en cours:{0}";
	main_fastdrivepitl1_1 = "{0}^1Attention vitesse excessive aux stands";
	main_fastdrivepitl1_2 = "^1ATTENTION-KICK POSSIBLE" ;
	main_fastdrivepitl2_1 = "{0}^1Spectateur car trop rapide dans les stands";
	main_fastdrivepitl2_2 = "^1ENCORE {0} ESSAIS AVANT LE KICK" ;
	main_maxfastdrivepit1 = "{0}^1Kické car trop rapide dans les stands";
	main_maxfastdrivepit2 = "^1VOUS ETES KICKE";
	main_maxreset = "{0} mis en spectateur pour excès de reset de voiture";
	main_oncarreset = "Reset de voiture par {0} au tour {1}";
	main_specwarn = "^1Attention mise en spectateur";
	main_resetrest = "^2Il vous reste^3 {0} ^2reset de voiture";
	main_close = "Fermer";
	main_psdistance = "^7Distance: ^2{0} ^7{1}";
	main_psfuel = "^7Essence consommée: ^2{0} ^7liters ";
	main_pslaps = "^7Tours réalisés: ^2{0}";
	main_pswins = "^7Victoires: ^2{0}";
	main_pssecond = "^7Secondes places: ^2{0}";
	main_psthird = "^7Troisièmes places: ^2{0}";
	main_psfinished = "^7Courses termiée: ^2{0}";
	main_psquals = "^7Qualifications réalisées: ^2{0}";
	main_pspole = "^7Poles réalisées: ^2{0}";
	built_pos = "Position";
	built_grp = "Poule";
	built_car = "Voiture";
	built_track = "Circuit";
	built_nick = "Pseudo";
	built_pb = "PB";
	built_split = "Split";
	built_splits = "Splits";
	built_points = "Points";
	built_nolfspb = "Les record de LFS World ne sont pas encore récupérés";
	built_nolfspbcrit = "Pas de records LFS World pour ce critère";
	built_lapsdone = "Tours réalisés";
	built_hand_nick = "^9 Handicap pour ^3{0}^9 :";
	built_hand_curr = "  - Actuel {0}Kg - Restr. admission.: {1}%";
	built_hand_req =  "  - Requis {0}^9 {1}Kg - Restr. admission.: {2}%";
EndLang

Lang "NL" # NL Lang made by $!N-Tim (emit-nl)
	main_welc1 = "^7Welkom {0} ^7op een ^1LFSLapper ^7server!%nl%^2Typ ^7!help ^2na het verlaten van de garage om commando's te zien.";
	main_welc2 = "^7Je plaats in het serverklassement is: ^7{0}%nl%^2Je huidige plaats in de voorkwalificatie: {1}^6Geschatte pool: {2}%nl%Spreek Engels en let op je taalgebruik!%nl%Respecteer andere spelers%nl%Zo niet, kun je verbannen worden";
	main_accept = "Accepteren";
	main_deny = "Weigeren";
	main_speedtrap = "Gemeten snelheid = {0} {1}";
	main_gotlevel =  "^3Jouw niveau is: {0}";
	main_swear11 = "^1Let op het taalgebruik!";
	main_swear12 = "Nog ^3{0} ^8pogingen en dan moet je toekijken.";
	main_swear21 = "Te veel verkeerd taalgebruik, kijk toe";
	main_nomatchflag = "Vlaggen komen niet overeen";
	main_yourflag =  "Jouw vlaggen -> {0}";
	main_requiredflag = "Benodigde vlaggen -> {0}" ;
	main_spectated = "Kijk Toe";
	main_notadmin = "Je bent geen Administrator!";
	main_currnode = "Je huidige baanpositie is: {0}";
	main_currzone = "Je huidige coördinaten zijn: {0}";
	main_lapclose = "LFSLapper is afgesloten door een Administrator!";
	main_ban = "{0} heeft {1} ^8verbannen";
	main_kick = "{0} heeft {1} ^8gekickt";
	main_friendpos = "Je huidige plaats in het serverklassement is: {0}";
	main_groupqual = "Je huidige plaats in de groepkwalificatie is: {0}";
	main_level = "^3Je hebt de volgende niveau(s): {0}";
	main_dist = "Afstand afgelegd met de {0} op {1} = {2} {3}. Deze sessie = {4} {5}";
	main_lapdone = "Rondes gedaan met {0} op {1} = {2}. Deze sessie = {3}";
	main_timeinpit = "Tijd in pits = {0}";
	main_trackused = "Huidige baan: {1} ({0})";
	main_serverclock = "Tijd op deze server: {0}";
	main_midnight = "Waarschuwing voor alle mensen met een baan! Het is middernacht!";
	main_newyear = "Gelukkig Nieuw Jaar!";
	main_allowed = "{0}^3 is toegestaan op deze server";
	main_notallowed = "{0}^3 is niet toegestaan op deze server";
	main_tolowhand1 = "{0}^3 moet toekijken vanwege een te laag ingestelde handicap";
	main_tolowhand2 = "^3Benodigd: {0}kg toegevoegde massa en {1}% luchtinlaat beperking!";
	main_vote_restart1 = "Herstart:";
	main_vote_restart2 = "({0}/{1}) Nog {2} nodig";
	main_vote_qualify1 = "Qualify";
	main_vote_qualify2 = "({0}/{1}) Nog {2} nodig";
	main_vote_end1 = "Einde:";
	main_vote_end2 = "({0}/{1}) Nog {2} nodig";
	main_car_changed = "Toegestane auto's veranderd, ga in pits! Huidige auto = {0}";
	main_track_changed1 = "Baan veranderd, een ogenblik geduld!";
	main_track_changed2 = "Huidige baan = {0}";
	main_left_server = "{0} ^7heeft de server verlaten";
	main_great1 = "Geweldige 1e split ({0}) door {1}^8!";
	main_good1 = "Goede 1e split ({0}) door {1}^8!";
	main_great2 = "Geweldige 2e split ({0}) door {1}^8!";
	main_good2 = "Goede 2e split ({0}) door {1}^8!";
	main_great3 = "Geweldige 3e split ({0}) door {1}^8!";
	main_good3 = "Goede 3e split ({0}) door {1}^8!";
	main_greatlap = "Geweldige ronde ({0}) door {1}^8!";
	main_goodlap = "Goede ronde ({0}) door {1}^8!";
	main_flood = "{0}^3 is gekickt vanwege flooding";
	main_on_result = "Finish positie = {0}";
	main_lost_control = "^1Gevaar! ^8{0} ^2verloor controle!";
	main_toslow1 = "je bent te traag! Max : {0}";
	main_toslow2 = "kick na {0}";
	main_toslowvery1 = "Je bent erg traag, kijk toe!";
	main_toslowvery2 = "{0} ging te traag, kijkt toe!";
	main_idle1 = "^3Je bent inactief. Over 10 seconden moet je toekijken" ;
	main_idle2 = "^3Je moet toekijken omdat je inactief bent";
	main_onnewpb = "Nieuw PB door {0}^8 ({1}): {2}";
	main_onnewpb_rank = "Positie : {0}";
	main_onnewpb_sesslaps = "Rondes tijdens deze sessie = {0}";
	main_onnewpb_servlaps = "Totaal aantal rondes op deze server = {0}";
	main_onnewpb_avgspeed = "Gemiddelde snelheid: {0}{1}";
	main_onnewpb_rank2 = "Positie op de server met de {0}: ^7{1}";
	main_onnewpbqual = "Competitie - Nieuwe QT door {0}^8:{1}";
	main_onnewpbqual_rank = "Positie in het serverklassement: ^7{0}";
	main_onnewpbqual_pos = "^2Positie in kwalificatie: {0}";
	main_onnewpbqual_pool = "^6Werkelijke Pool: {0}";
	main_onnewpbqual_avgspeed = "Gemiddelde snelheid: {0}{1}";
	main_onnewpbqual_posqual = "{0} ^2Positie:{1} - Pool:{2}";
	main_accel = "^8Accelereerde in ^3{0}^8 seconden naar {1} {2}!";
	main_notpitwindow = "{0} ^1Je bent niet in je pitwindows, allowed in {1}-{2}";
	main_inpitwindows = "{0} ^1Je mag nu een pitstop maken";
	main_outpitwindows = "{0}  ^1Je mag nu geen pitstop maken";
	main_beginpit = "{0}^8 maakt een pitstop";
	main_pitwork = "Pitstop begint! Werk:{0}";
	main_fastdrivepitl1_1 = "{0}^1 Waarschuwing! Te hard in de pits";
	main_fastdrivepitl1_2 = "^1Let op! Gekickt worden is mogelijk!" ;
	main_fastdrivepitl2_1 = "{0}^1 Je reed te hard in de pits. Kijk toe";
	main_fastdrivepitl2_2 = "^1Nog ^3{0} ^1keer voordat je gekickt wordt" ;
	main_maxfastdrivepit1 = "{0}^1 is gekickt voor te hard rijden in pits";
	main_maxfastdrivepit2 = "^1JE BENT GEKICKT!";
	main_maxreset = "{0} moet toekijken vanwege te veel wagenresets";
	main_oncarreset = "Wagen gereset door {0} in ronde {1}";
	main_specwarn = "^1Let op! Te veel wagenresets betekend toekijken";
	main_resetrest = "^2Je hebt nog ^3{0} ^2wagenresets over";
	main_close = "Sluiten";
	main_psdistance = "^7Afstand: ^2{0} ^7{1}";
	main_psfuel = "^7Gebruikte brandstof: ^2{0} ^7Liter ";
	main_pslaps = "^7Gereden rondes: ^2{0}";
	main_pswins = "^7Gewonnen: ^2{0}";
	main_pssecond = "^7Tweede: ^2{0}";
	main_psthird = "^7Derde: ^2{0}";
	main_psfinished = "^7Aantal Races gefinisht: ^2{0}";
	main_psquals = "^7Aantal Kwalificaties gedaan: ^2{0}";
	main_pspole = "^7Aantal Poles: ^2{0}";
	built_pos = "Pos";
	built_grp = "Grp";
	built_car = "Auto";
	built_track = "Baan";
	built_nick = "NickName";
	built_pb = "Pb";
	built_split = "Split";
	built_splits = "Splits";
	built_points = "Punten";
	built_nolfspb = "LFS World PB nog niet ontvangen";
	built_nolfspbcrit = "Geen LFS World PB voor deze criteria";
	built_lapsdone = " Gereden rondes";
	built_hand_nick = "^3{0}^9 handicap:";
	built_hand_curr = "  - Toegevoegde massa: {0}Kg - Luchtinlaat beperking: {1}%";
	built_hand_req =  "  - Benodigd: {0}^9 {1}Kg toegevoegde massa - Luchtinlaat beperking: {2}%";
EndLang

Lang "NO" #Translated by Carlos/DenonForce14
	main_welc1 = "^7Velkommen {0} ^7til ^1LFSLapper ^7forsynte servere!%nl%^2Press ^7!help ^2etter du har forlatt garasjen for å se kommandoer";
	main_welc2 = "^7Din vennlige posisjon (alle seere) : ^7{0}%nl%^2Din aktuelle prekvalifasjon i liga : {1}^6Anslått Sammenslutning : {2}%nl%Ikke bruk banneord på denne serveren og respekter andre, ellers kan du bli utestengt";
	main_accept = "Godta";
	main_deny = "Avslå";
	main_speedtrap = "Fartsfelle = {0} {1}";
	main_gotlevel = "^3Du har level: {0}";
	main_swear11 = "^1Ikke bruke dette ordet på denne serveren.";
	main_swear12 = "^1Du havner i tilskuermodus hvis du bruker et banneord igjen.";
	main_swear21 = "For mange banneord, du blir satt i tilskuermodus";
	main_nomatchflag = "Flagg samsvarer ikke nødvendige flagg";
	main_yourflag = "Dine flagg -> {0}";
	main_requiredflag = "Nødvendige flagg -> {0}";
	main_spectated = "Tilskuermodus";
	main_notadmin = "Du er ikke en adminstrator!";
	main_currnode = "Gjeldende klynge er : {0}";
	main_currzone = "Gjeldende område er : {0}";
	main_lapclose = "LFSLapper ble slått av av administrator!";
	main_ban = "{0} Utesteng {1}";
	main_kick = "{0} frakoble {1}";
	main_friendpos = "Din vennlige posisjon er {0}";
	main_groupqual = "Din gruppekvalifisering er {0}";
	main_level = "^3Du har level(s): {0}";
	main_dist = "Distanse gjort på {0}/{1} = {2} {3}, session = {4} {5}";
	main_lapdone = "Runder gjort på {0}/{1} = {2}, session = {3}";
	main_timeinpit = "Tid i pit {0}";
	main_trackused = "Bane i bruk : {0} = {1}";
	main_serverclock = "Server tid : {0}";
	main_midnight = "Nattvarsel til alle arbeidende menn!";
	main_newyear = "Godt nyttår!";
	main_allowed = "{0}^3 tillatt på denne serveren";
	main_notallowed = "{0}^3 ikke tillatt på denne serveren";
	main_tolowhand1 = "{0}^3 satt i tilskuermodus pga for lite handicap";
	main_tolowhand2 = "^3trenger {0}kg og {1}% av inntak begrensning!";
	main_vote_restart1 = "Start løp på nytt:";
	main_vote_restart2 = "({0}/{1}) trenger {2}";
	main_vote_qualify1 = "Kvalifisering";
	main_vote_qualify2 = "({0}/{1}) trenger {2}";
	main_vote_end1 = "Slutt:";
	main_vote_end2 = "({0}/{1}) Trenger {2}";
	main_car_changed = "Bil endret, gå til garasje. Bil i bruk = {0}";
	main_track_changed1 = "Banen er endret, vent litt!";
	main_track_changed2 = "Bane i bruk = {0}";
	main_left_server = "{0} ^7forlot serveren";
	main_great1 = "Utmerket 1st split ({0}) by {1}^8!";
	main_good1 = "Bra 1st split ({0}) by {1}^8!";
	main_great2 = "Utmerket 2nd split ({0}) by {1}^8!";
	main_good2 = "Bra 2nd split ({0}) by {1}^8!";
	main_great3 = "Utmerket 3rd split ({0}) by {1}^8!";
	main_good3 = "Bra 3rd split ({0}) by {1}^8!";
	main_greatlap = "Utmerket runde ({0}) by {1}^8!";
	main_goodlap = "Bra runde ({0}) by {1}^8!";
	main_flood = "{0}^3 frakoblet for overfloding av chat";
	main_on_result = "Avsluttende posisjon = {0}";
	main_lost_control = "^1Fare! ^8{0} ^2er ut av kontroll!";
	main_toslow1 = "Du kjører for langsomt! Max : {0}";
	main_toslow2 = "frakoble om {0}";
	main_toslowvery1 = "Du er for langsom, og blir satt i tilskuermodus!";
	main_toslowvery2 = "{0} er for langsom, og ble satt i tilskuermodus!";
	main_idle1 = "^3Du er for langsom, og vil bli satt i tilskuermodus om 10 sekunder";
	main_idle2 = "^3Du er satt i tilskuermodus for langsomhet";
	main_onnewpb = "Ny banerekord av {0}^8 ({1}): {2}";
	main_onnewpb_rank = "Vennlig rank : {0}";
	main_onnewpb_sesslaps = "Samlet antall runder = {0}";
	main_onnewpb_servlaps = "Totalt antall runder (server) = {0}";
	main_onnewpb_avgspeed = "Gjennomsnitt fart: {0}{1}";
	main_onnewpb_rank2 = "Vennlig {0} rank: ^7{1}";
	main_onnewpbqual = "Liga - Ny QT av {0}^8:{1}";
	main_onnewpbqual_rank = "Vennlig rank (alle besøkende): ^7{0}";
	main_onnewpbqual_pos = "^2Kvali. posisjon: {0}";
	main_onnewpbqual_pool = "^6Virkelig sammenslutning: {0}";
	main_onnewpbqual_avgspeed = "Gjennomsnitt fart: {0}{1}";
	main_onnewpbqual_posqual = "{0} ^2Posisjon:{1} - Sammenslutning:{2}";
	main_accel = "^8Akselererte fra 0 til {1} {2} på ^3{0}^8 sekunder!";
	main_notpitwindow = "{0} ^1You are not on pit Windows, allowed in {1}-{2}";
	main_inpitwindows = "{0} ^1Du kan gå til pit";
	main_outpitwindows = "{0} ^1Du har ikke lov til å gå til pit";
	main_beginpit = "{0}^8 gjorde et pit stopp";
	main_pitwork = "Pit begynner! :{0}";
	main_fastdrivepitl1_1 = "{0}^1 Advarsel for å kjøre for fort i pit";
	main_fastdrivepitl1_2 = "^1ADVARSEL, FRAKOBLING MULIG";
	main_fastdrivepitl2_1 = "{0}^1 Satt i tilskuermodus for å kjøre for fort i pit";
	main_fastdrivepitl2_2 = "^1FRAKOBLET OM {0} TRY";
	main_maxfastdrivepit1 = "{0}^1frakoblet for å kjøre for fort i pit";
	main_maxfastdrivepit2 = "^1DU ER FRAKOBLET";
	main_maxreset = "{0} satt i tilskuermodus for å overgå max resets lovlig";
	main_oncarreset = "Reset av {0} på runde {1}";
	main_specwarn = "^1Advarsel, tilskuermodus";
	main_resetrest = "^2Du har^3 {0} ^2resets igjen";
	main_close = "Avslutt";
	main_psdistance = "^7Distanse: ^2{0} ^7{1}";
	main_psfuel = "^7Drivstoff brukt: ^2{0} ^7liter";
	main_pslaps = "^7Runder gjort: ^2{0}";
	main_pswins = "^7Første plass: ^2{0}";
	main_pssecond = "^7Andre plass: ^2{0}";
	main_psthird = "^7Tredje plass: ^2{0}";
	main_psfinished = "^7Løp gjort: ^2{0}";
	main_psquals = "^7Kvalifisjoner gjort: ^2{0}";
	main_pspole = "^7Staver gjort: ^2{0}";
	built_pos = "Posisjon";
	built_grp = "Grp";
	built_car = "Bil";
	built_track = "Bane";
	built_nick = "Kallenavn";
	built_pb = "Banerekord";
	built_split = "Split";
	built_splits = "Splits";
	built_points = "Points";
	built_nolfspb = "LFS World banerekord er ikke mottatt enda";
	built_nolfspbcrit = "Ingen LFS World banerekord for denne bilen/banen";
	built_lapsdone = "Runder gjort";
EndLang
