import QtQuick 2.0
import QtQuick.Controls 1.4 //for the textField
/**
  * A Text Field with a border through the QtQuick.Controlls 1.4
  */

Rectangle {
    //border.color: "lightgrey"
    color: "transparent"
    property string text: textArea.text
    TextField{
        id: textArea
        anchors.fill: parent
    }
}
