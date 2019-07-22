import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.5 //for Application Window
import QtQuick.Layouts 1.11
import FileReader 1.0
import QtQml.Models 2.12 // listModel

ApplicationWindow {
    id: window
    visible: true
    width: 90 * 3
    height: 160 * 3
    title: qsTr("Tea Timer")

    property string dataFilePath: "DataFile.txt"

    FileReader{
        id: fileReader
    }

    ListModel{
        id: timerListModel

        Component.onCompleted: readFile()
    }

    function loadTimer(name){
        for (var i = 0; i < timerListModel.count; ++i){
            if(timerListModel.get(i).name === name){
                timerWindow.reload(timerListModel.get(i).name, timerListModel.get(i).startTime, timerListModel.get(i).running, timerListModel.get(i).comment)
                headline.text = timerListModel.get(i).name
            }
        }
    }

    //adds a new Timer to the List and to the File
    function addTimer(name){
        timerListModel.append({name: name, startTime: 0, running: false, comment: ""})
        window.writeFile()
    }

    //renames a Timer
    function renameTimer(oldName, newName){
        for (var i = 0; i < timerListModel.count; ++i){
            if(timerListModel.get(i).name === oldName){
                timerListModel.get(i).name = newName
                reload
            }
        }
    }

    //deletes the Timer from the List and the File, also reloads a new timer to the TimerWindow
    function deleteTimer(name){
        for (var i = 0; i < timerListModel.count; ++i){
            if(timerListModel.get(i).name === name){
                print("hi")
                timerListModel.remove(i)
                window.loadDefaultTimer()
                window.writeFile()
            }
        }
    }

    //updates the current timer-data to the List and also to the File
    function saveCurrentTimer(name, startTime, running, comment){
        for (var i = 0; i < timerListModel.count; ++i){
            if(timerListModel.get(i).name === name){
                timerListModel.get(i).name = name
                timerListModel.get(i).startTime = startTime
                timerListModel.get(i).running = running
                timerListModel.get(i).comment = comment
            }
        }
        writeFile()
    }

    //reads the File and re-fills the List
    function readFile(){
        var datastore = fileReader.readFile(dataFilePath)
        if (datastore) {
          timerListModel.clear()
          var parsedModel = JSON.parse(datastore)
          for (var i = 0; i < parsedModel.length; ++i)
              timerListModel.append(parsedModel[i])
        }
    }

    //writes the current List Elements in a File
    function writeFile(){
        var datamodel = []
        for (var j = 0; j < timerListModel.count; ++j)
            datamodel.push(timerListModel.get(j))
        fileReader.writeFile(dataFilePath, JSON.stringify(datamodel))
    }

    //loads the first Timer automaticly adds a default Timer to the List if empty
    function loadDefaultTimer(){
        if(timerListModel.count > 0){
            window.loadTimer(timerListModel.get(0).name)
            print(timerListModel.get(0).name)
        }
        else{
            window.addTimer("Default Timer")
            window.loadTimer("Default Timer")
            headline.text = "Default Timer"
        }
    }

    //TODO: ToolBar Kapseln //TODO: initialize with first list Item or with default Timer
    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("⋮")
                onClicked: timerMenu.open()
            }
            Label {
                id: headline
                text: "Title"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton { //TODO: info and Credits button
                text: qsTr("‹")
                //onClicked: stack.pop()
            }
        }
    }

    TimerWindow{
        id: timerWindow
        anchors.fill: parent
        onUpdateList: saveCurrentTimer(name, startTime, timerRunning, comment)
    }

    TimerMenu{
        id: timerMenu
        anchors.fill: parent
        listModel: timerListModel

        onDeleteTimer: window.deleteTimer(name)
        onAddTimer: window.addTimer(name)
    }

    Component.onCompleted: {
        //load first Timer
        window.readFile()
        window.loadDefaultTimer()
    }
}
