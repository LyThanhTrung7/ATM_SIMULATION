import QtQuick 2.15
import QtQuick.Window 2.15
import "Login"
import "MenuUser"
import "MenuAD"
Window {
    id: main
    width: 800
    height: 500
    visible: true
    title: qsTr("THANH COMBANK")
    property bool isSign: false
    property bool user: false
    property int accNumber: 0
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/image/atm.png"
        fillMode: Image.PreserveAspectCrop
    }
    Login{
        id: login
    }
    MenuUser{
       id: menu_user
    }
    MenuAD{
    id: menu_ad
    }

}
