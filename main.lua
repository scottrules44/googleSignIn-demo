local googleSignIn = require "plugin.googleSignIn"
local json = require("json")
googleSignIn.init()
local widget = require("widget")
local clientID = "replace with client id"
local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 0,0,1 )

local title = display.newText( "Google Sign In", display.contentCenterX, 40, native.systemFontBold ,30)

local signIn = widget.newButton( {
	label = "Sign In",
	fontSize = 20,
	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
	x = display.contentCenterX,
	y = display.contentCenterY,
	onRelease = function ( e )
        googleSignIn.signIn(clientID, nil,nil,function ( ev )
            if (ev.isError == true) then
                native.showAlert("Error Sign In", ev.error, {"Ok"})
            else
                native.showAlert("Signed In", json.encode(ev), {"Ok"})
            end
			print( json.encode( ev ) )
		end)
	end,
} )
