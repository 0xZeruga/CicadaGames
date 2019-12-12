	.tt {
		background-color:#790700;
		color:white;
		text-decoration:none;
		cursor:pointer;
		border-bottom: 1px dotted;
	}
	
	/*Hover Link Colors - Plan to change later*/
	.tt a:link {color:inherit;}
	.tt a:visited {color:inherit;}
	.tt a:hover {color:inherit; text-decoration: none;}
	.tt a:active {color:inherit;}
	
	.hiddenBalloon {
		display:none;
	}
	
	#visibleBalloonElement * .editsection {
		font-size: 13px;
	}
	#visibleBalloonElement * h2 {
		border-bottom: solid 1px #91A3B0;
		font-size: 18px;
		margin-top: 14px;
		overflow: hidden;
	}
	
	table.mapLocationsTable tr:last-child td{
		border-bottom: 0px;
	}
	
	#ajaxContentArea .removeOnAjax {
		display:none;
	}


/* 'show'/'hide' buttons created dynamically by the CollapsibleTables javascript
   in [[MediaWiki:Common.js]] are styled here so they can be customised. */
.collapseButton {       
    /* @noflip */
    float: right;
    font-weight: normal;
    /* @noflip */
    margin-left: 0.5em;
    /* @noflip */
    text-align: right;
    width: auto;
}

a[href="/wiki/User:Jgjake2"] {
    color: #cc6600 !important;
    text-transform: lowercase !important;
}