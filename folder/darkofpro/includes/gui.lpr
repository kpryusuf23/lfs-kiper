#############################################################################
# Tabbed GUI Framework (c) by Krayy
#############################################################################
# This addon provides wrapper functions for the tabbed GUI system.
#
# This can be used by scripters to create a multi-page interface that has a
# common look and feel so that Lapper becomes easier to use and promotes a
# clean style of coding to make scripts easier to edit and maintain.
#
# New modules should follow the following naming guidelines and .lpr
# heirarchy to keep in sync with other available modules:
#
# gui.lpr (this module that always exists)
#   |-> gui_<module_name>.lpr
#      |-> gui_<module_name>_<sub_module_name>lpr
#
# So if we were creating a new module called "foo" with an item tab called "bar",
# we would do the following:
#
# 1. Copy an existing base module, like gui_admin.lpr to gui_admin_foo.lpr
#    and then update any variable definitions to new names
# 2. Create a new file called gui_foo_bar.lpr and copy the OnLapperStart
#
#############################################################################
# Ver 1.0.1 - 07 July 2010 Initial release
# Ver 1.0.2 - 07 July 2010 Added support for button groups using leading colon in item name
#############################################################################

Sub DrawGUI(  $TGPrefix, $TGTitle, $TGorigT, $TGorigL, $ItemCallBackPrefix, $HighLightedItemNum, $ItemList )
	$HostName = getLapperVar( "HostName" );
	$Width = 100;			# ...width of Dialog box
	$Height = 130;			# ...height of window

	$origLTab = 42;			# Left edge of Tab
	$WidthTab = 23;			# ...width of Tab
	$RowHeight = 6;			# ...height of window
	
	# Draw the background and the title bar
	openPrivButton ( $TGPrefix . "_AllBg1",$origLTab-2,$TGorigT-8,$WidthTab+$Width+7,$Height+10,1,-1,ISB_LIGHT,"");
	openPrivButton ( $TGPrefix . "_AllBg2",$origLTab-2,$TGorigT-8,$WidthTab+$Width+7,$Height+10,1,-1,ISB_LIGHT,"");
	openPrivButton ( $TGPrefix . "_TabbedGuiTitle",$origLTab,$TGorigT-8,$WidthTab+$Width+7,8,1,-1,ISB_LEFT+2, $HostName . "^0 - " . $TGTitle );
	openPrivButton ( $TGPrefix . "_Version",$origLTab+$WidthTab+$Width-17,$TGorigT-8,20,4,4,-1,ISB_RIGHT+7, "GUI Framework%nl%v1.0.1 by Krayy");

	# Tab background and tab names to click on
	openPrivButton ( $TGPrefix . "_TabMain",$origLTab,$TGorigT,$WidthTab+2,$Height,5,-1,32," " );

	$GUI_ITEMS = SplitTOArray(  $ItemList , "," );
	$GUI_ITEMS_MAX = arrayCount( $GUI_ITEMS );

	$i=0; $ButtonCount=0;
	WHILE ($i <= $GUI_ITEMS_MAX)
		IF ( $GUI_ITEMS[$i] != "" )
		THEN
			$ButOrigT = $TGorigT + ($RowHeight * ($ButtonCount)) + $ButtonCount + 1;
			$ButtonCount = $ButtonCount + 1;
			
			$ColonLoc = indexOf( $GUI_ITEMS[$i], ":");
			IF ( $ColonLoc == 0 )
			THEN
				$SectionName = substr( $GUI_ITEMS[$i],1,strlen($GUI_ITEMS[$i]) );
				openPrivButton ( $TGPrefix . "_Section_" . $i,$origLTab+1,$ButOrigT,$WidthTab,6,5,-1,32,"^7" . $SectionName );
			ELSE
				IF ( $i == $HighLightedItemNum )
				THEN
					openPrivButton ( $TGPrefix . "Tab_" . $i,$origLTab+1,$ButOrigT,$WidthTab,6,4,-1,16,"^3" . $GUI_ITEMS[$i], $ItemCallBackPrefix . StrReplace( $GUI_ITEMS[$i], " ", "_" ) );
				ELSE
					openPrivButton ( $TGPrefix . "Tab_" . $i,$origLTab+1,$ButOrigT,$WidthTab,6,4,-1,16,$GUI_ITEMS[$i], $ItemCallBackPrefix . StrReplace( $GUI_ITEMS[$i], " ", "_" ) );
				ENDIF
			ENDIF
		ENDIF
		$i = $i + 1;
	ENDWHILE

	openPrivButton( $TGPrefix . "_close",$origLTab+1,$TGorigT+$Height-8,$WidthTab,6,4,-1,16,"^7Close",DialogClose );

	# Draw the main contents window on top of the titles and clear them
	openPrivButton( $TGPrefix . "_main",$TGorigL,$TGorigT,$Width,$Height,5,-1,32," " );
	DialogClose ( 0, $TGPrefix . "-" );
EndSub
