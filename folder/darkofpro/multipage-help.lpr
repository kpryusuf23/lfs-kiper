#############################################################################
# LFS Lapper Multi-Page Help System by Krayy
#############################################################################
# This is a more flexible Help system that allows the addition of extra help
# descriptions without encroaching on available screen area.
#############################################################################
# Ver 1.0.1 - 15 Jan 2010 Initial release
# Ver 1.0.2 - 16 Jan 2010 Minor updates to display
#############################################################################

CatchEvent OnLapperStart()
	GlobalVar $maxHelpPages;
	$maxHelpPages = 4;	# maximum number of pages for help...increase when new help pages added
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

		CASE "!help":
                CASE "!yardim":
			DoMultiPageHelp(0, "multihelp_header_1");
			BREAK;
	ENDSWITCH
EndCatchEvent

############################
#Replacement Help Functions#
############################

Sub DoMultiPageHelp ( $KeyFlags, $id )
	$PageNum = ToNum(split( $id,"_",2 ));

	# Display the help menu title
	openPrivButton ( "help_title",44,26,112,10,5,-1,32,langEngine( "%{multihelp_header}%", $PageNum) );
	openPrivButton ( "help_bg",44,36,112,107,1,-1,32,"");

	# Display the help text
	openPrivButton ( "help_contents",45,36,110,6,5,-1,64,langEngine( "%{multihelp_contents_" . $PageNum . "}%") );

	# Display the help menu buttons
	openPrivButton( "helpbutton_close",44,145,25,10,8,-1,32,"^3Close",helpClose );
	FOR ($i=1; $i < $maxHelpPages+1; $i=$i+1)
		IF ( ToNum($PageNum) == ToNum($i) )	# Print a Prev button if the page is greater than 1
		THEN
			openPrivButton ( "helpbutton_num_" . $i,66 + (7 * $i),145,6,10,8,-1,32,"^3" . $i,DoMultiPageHelp );
		ELSE
			openPrivButton ( "helpbutton_num_" . $i,66 + (7 * $i),145,6,10,8,-1,32,"^8" . $i,DoMultiPageHelp );
		ENDIF
	ENDFOR
EndSub

Sub helpClose( $KeyFlags,$id )
	closePrivButton("help_title&help_contents&helpbutton_close&helpbutton_prev&helpbutton_next&help_bg");
	FOR ($i=0; $i < $maxHelpPages+1; $i=$i+1)
		closePrivButton ("helpbutton_num_".$i);
	ENDFOR
EndSub

Lang "EN" # Race Events messages
	multihelp_header = "^7YARDýM MENUSU {0}";
	multihelp_contents_1 = "^2BÝLGÝ"
			. "%nl%^1iletisim:^4instagram/^7dpo"
			. "%nl%^3KURUCU: ^7dpo"
                        . "%nl%^3BÝLGÝ: 
 
        multihelp_contents_2 = "^2BOS"
	. "%nl%^3Forum Sayfamiz: ^7Turksunucum.com";  		
	multihelp_contents_3 = "^2BOS"
			
	multihelp_contents_4 = "^2BOS"
			
EndLang
