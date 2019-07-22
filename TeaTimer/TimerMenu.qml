import QtQuick 2.0
import QtQuick.Controls 2.5 //drawer, button, popup
import QtQuick.Layouts 1.12 //for ColumLayout


Item{
    id: timerMenu

    function open() {
        menu.open()
    }

    property ListModel listModel

    signal deleteTimer(string name)
    signal renameTimer(string oldName, string newName)
    signal addTimer(string name)

    Drawer{
        id: menu
        height: window.height
        width: window.width * 2/3
        ListView{
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: addButton.top
            model: listModel
            delegate: OwnButton{
                id: buttonDelegate
                text: name
                width: parent.width

                onClicked: {
                    loadTimer(name)
                    menu.close()
                }
                onRightClicked: {
                    timerInteractionMenu.currentName = name
                    timerInteractionMenu.popup()
                }

                background: Rectangle{
                    anchors.fill: parent
                    color: buttonDelegate.down? "lightgrey" : "white"
                }
            }
        }
        Button{
            id: addButton
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text: "+ Add"
            onClicked: newTimerPopup.open()
            background: Rectangle{
                anchors.fill: parent
                border.color: "grey"
                color: addButton.down ? "lightgrey" : "white"
            }
        }
    }

    Menu {
        id: timerInteractionMenu
        property string currentName
        MenuItem{
            text: "Rename"
            onClicked: print(timerInteractionMenu.currentName) //TODO: implement
        }
        MenuItem{
            text: "Delete"
            onClicked: {
                timerMenu.deleteTimer(timerInteractionMenu.currentName)
                menu
            }
        }
    }

    Popup {
        id: newTimerPopup
        modal: true
        focus: true

        ColumnLayout{
            Text{
                text: "Timer name:"
            }
            OwnTextField {
                id: newTimerName
                height: 27 //exact height for no scrolling //TODO: höhe dynamisch machen
                Layout.fillWidth: true
            }
            RowLayout{
                Button{
                    text: "Add"
                    Layout.fillWidth: true
                    onClicked: {
                        //TODO: Check if Name is already taken
                        if(newTimerName.text !== "" && newTimerName.text.trim() !== ""){
                            timerMenu.addTimer(newTimerName.text)
                            loadTimer(newTimerName.text)
                            newTimerPopup.close()
                            menu.close()
                        }
                    }
                }
                Button{
                    text: "Cancel"
                    Layout.fillWidth: true
                    onClicked: newTimerPopup.close()
                }
            }
        }

        closePolicy: Popup.CloseOnReleaseOutside
    }
}
