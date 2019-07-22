import QtQuick 2.0
import QtQuick.Controls 2.5 // for the Button
/**
  * Basicly standart QML-Button with right-klick!
  */

Button {
    id: ownButton
    signal rightClicked

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: {
            ownButton.rightClicked()
         }
    }
}
