

function is_numeric(x)
    if tonumber(x) ~= nil then
        return true
    end
    return false
end

if timer == nil then
    local answer = app.alert{title="Auto Save Configure", text="Auto Save is not enabled. Would you like to enable it?", buttons={"Enable", "Cancel"}}
    if answer == 1 then
        local dlg = Dialog()
        dlg:entry{
            id="wantedDelay",
            label="Time in between auto-saves (in minutes): ",
            text="",
            focus=true
        }
        dlg:button{
            id="confirm",
            text="Confirm"
        }
        dlg:show()
        
        local data = dlg.data
        
        while not is_numeric(data.wantedDelay) do
            local bounds = dlg.bounds
            dlg.bounds = Rectangle(bounds.x, bounds.y, 400, 200)
            dlg:modify{
                id="wantedDelay",
                label="Invalid number, please enter a real one (in minutes): ",
                text="",
                focus=true
            }
            dlg:show()
            data = dlg.data
        end

        timer = Timer{
            interval=data.wantedDelay*60,
            ontick=function()
                app.command.SaveFile()
            end
        }

        app.command.SaveFile()

        timer:start()
        running = true
    end
else
    
    local secondAnswer = app.alert{title="Auto Save Configure", text="Auto Save is enabled. Would you like to disable it?", buttons={"DISABLE", "Cancel"}}
    if secondAnswer == 1 then
        timer:stop()
        timer = nil
        app.alert{title="Auto Save Configure", text="AUTO SAVE HAS BEEN TURNED OFF. BE CAREFUL"}
    end
end
