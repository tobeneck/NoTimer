import QtQuick 2.9
import QtQuick.Controls 2.5 //textArea
import QtQuick.Layouts 1.11

Item {
    id: timerWindow

    signal updateList(string name, real startTime, bool timerRunning, string comment)

    function reload(name, startTime, timerRunning, comment){
        timerWindow.name = name
        print(comment)
        commentArea.setText(comment)
        timerWindow.timerRunning = timerRunning
        timerWindow.startTime = new Date(startTime)
    }

    property string name: ""
    property var startTime: new Date() //TODO real Date.now()?
    property var currentTime: new Date()
    property int elapsedTime: 0
    property bool timerRunning: false
    property int repeats: 0

    function intToTime(intSec){ //to "ss:zz"
        if(intSec < 0)//to prevent unwanted negative values at the beginning
            intSec = 0

        var min = Math.floor(intSec / 60000)
        var sec = Math.floor(intSec / 1000) % 60
        var msec = Math.floor(intSec / 10) % 100

        if(min < 10)
            min = "0" + min
        if(sec < 10)
            sec = "0" + sec
        if(msec < 10)
            msec = "0" + msec

        return min + ":" + sec + "." + msec //TODO: Add Days to the mix (if >0)
    }

    Timer {
        interval: 55;
        running: true;
        repeat: true;
        onTriggered: {
            if(timerRunning)
                elapsedTime = currentTime.getTime() - startTime.getTime()
            else
                elapsedTime = 0
            currentTime = new Date()
        }
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 5
        Text
        {
            Layout.alignment: Qt.AlignHCenter
            text: intToTime(elapsedTime)
            font.pixelSize: window.width/5
            color: "grey"
        }

//        RowLayout{
//            Layout.alignment: Qt.AlignCenter

//            SpinBox {
//                value: repeats
////                onValueChanged: timerWindow.repeats = value
//                height: window.width/15
//            }

//            Button{
//                text: "Reset"
//                onClicked: repeats = 0
//                height: window.width/15
//            }
//        }

        Button{
            Layout.alignment: Qt.AlignHCenter
            Text{
                anchors.centerIn: parent
                text: timerRunning ? " Stop" : "Start"
                color: "grey"
                font.pixelSize: parent.height / 2
            }
            height: window.height/16
            width: window.width/2
            onClicked: {
                startTime = new Date()
                if(!timerRunning)
                    repeats ++;
                timerRunning = !timerRunning
                timerWindow.updateList(name, startTime.getTime(), timerRunning, commentArea.getText(), repeats)
            }
        }

        OwnTextArea{
            id: commentArea
            Layout.fillHeight: true
            Layout.fillWidth: true
            onUpdateList: {
                timerWindow.updateList(name, startTime.getTime(), timerRunning, currentComment, repeats) //TODO: startTime
            }
        }
    }
}
