import QtQuick 2.0
import QtQuick.Controls 1.4 //for the textarea with borders and scroll
/**
  * A Text Area with a border through the QtQuick.Controlls 1.4
  */

Rectangle {
    //border.color: "lightgrey"
    id: ownTextArea
    color: "transparent"

    function setText(text){
        textArea.text = text
    }

    function getText(){
        return textArea.text
    }

    signal updateList(string currentComment)
    property var wrapMode: TextEdit.WordWrap


    TextArea{
        id: textArea
        anchors.fill: parent
        wrapMode: wrapMode
        onTextChanged: {
            if(update)
                ownTextArea.updateList(text)
        }
        //this is to prevent early loading and deletion of the whole data:
        property bool update: false
        Component.onCompleted: update = true
    }
}
