local googleSignIn = require "plugin.googleSignIn"
local json = require("json")
googleSignIn.init()
local widget = require("widget")
local androidClientID = "replace with client id (android)"
local clientID = "replace with client id (iOS)" -- iOS deafult
if (system.getInfo("platform") == "android") then
    clientID = androidClientID
end
googleSignIn.silentSignIn(function (e)
  if (e.isError) then
  	print("please sign in before logging out")
  else
   print("you are signed in")
 end
end)
local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 0,0,1 )

local title = display.newText( "Google Sign In", display.contentCenterX, 40, native.systemFontBold ,30)

function signIn_onEvent(event)
	if(event.phase == "ended")then
		function listener(event)
			print( "hi" )
			if (event.isError == true) then
		        native.showAlert("Error Sign In", event.error, {"Ok"})
		    else
		    	print(json.encode(event.email))
		        native.showAlert("Signed In", json.encode(event), {"Ok"})
		    end
		end
		googleSignIn.signIn({clientID= clientID, listener = listener})
	end
end

local signIn = widget.newButton( {
	label = "Sign In",
	fontSize = 20,
	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
	x = display.contentCenterX,
	y = display.contentCenterY,
	onEvent = signIn_onEvent
} )

function signOut_onEvent(event)
	if(event.phase == "ended")then
		local function listener2(event)
            print(event)
            if(event.isError == true)then
                native.showAlert( "Google", event.error, {"OKAY"} )
                print(event.error)
            else
            print("Logged out from Google")
            end
        end
        local function listener3(event)
            print(event)
            if(event.isError == false) then
                print("Logged out from Google")
            end
        end
        googleSignIn.signOut(listener2)
        googleSignIn.Disconnect(listener2)
	end
end

local signOut = widget.newButton( {
	label = "Sign Out/Disconnect",
	fontSize = 20,
	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
	x = display.contentCenterX,
	y = display.contentCenterY+100,
	onEvent = signOut_onEvent
} )
