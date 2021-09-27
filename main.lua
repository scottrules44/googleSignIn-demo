local googleSignIn = require "plugin.googleSignIn"
local json = require("json")

local widget = require("widget")

googleSignIn.init({
ios={
    clientId = "652763858765-ati8ar1t20ofebu4a39nhk7ea9oqmuu1.apps.googleusercontent.com"
},
android={
    clientId = "652763858765-hq7huph5a5to4m39gqsoo7cn0ih3bd3d.apps.googleusercontent.com"
}
})
googleSignIn.silentSignIn(function (e)
  if (e.isError) then
  	print(e.error)
  else
   print("you are signed in")
 end
end)

local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 0,0,1 )

local title = display.newText( "Google Sign In", display.contentCenterX, 40, native.systemFontBold ,30)


function googleListener(event)
    if (event.isError == true) then
        native.showAlert("Error Sign In", event.error, {"Ok"})
    elseif(event.status == "cancelled") then
        native.showAlert("Sign In Cancelled", json.encode(event), {"Ok"})
    elseif(event.status == "signed in") then
        native.showAlert("Signed In", json.encode(event), {"Ok"})
    elseif(event.status == "signed out") then
        native.showAlert("Signed Out", json.encode(event), {"Ok"})
    end
end

function signIn_onEvent(event)
	if(event.phase == "ended")then
		googleSignIn.signIn(googleListener)
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
        googleSignIn.disconnect(googleListener)
        googleSignIn.signOut(googleListener)
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
