import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: login
    property bool isSign_ad: false
    anchors.centerIn: parent
    visible: !isSign
    Column{
        id: column_login_user
        spacing: 15
        anchors.centerIn: parent
        Label{
            visible: isSign_ad
            id: tage_login_ad
            width: 200
            height: 20
            Text{
                id: text_login_ad
                anchors.centerIn: tage_login_ad
                text: "LOGIN FOR ADMIN"
                color: "black"
                font.family: "Arial"
                font.bold: true
                font.pointSize: 15
            }
        }
        Label{
            visible:  !isSign && !isSign_ad
            id: tage_login_user
            width: 200
            height: 20
            Text{
                id: text_login_user
                anchors.centerIn: tage_login_user
                text: "LOGIN FOR USER"
                color: "black"
                font.family: "Arial"
                font.bold: true
                font.pointSize: 15
            }
        }
        TextField{
            id: user_acc_num
            placeholderText: "Enter your account number"
            placeholderTextColor: "#888888"
            color: "black"
            width: 230
            height: 40
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: user_acc_num.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: user_password
            placeholderText: "Enter your password"
            placeholderTextColor: "#888888"
            color: "black"
            echoMode: TextInput.Password
            width: 230
            height: 40
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: user_password.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        Button{
            id: foget_pass
            width: 130
            height: 20
            Text{
                text: "Fogot your password?"
                font.pointSize: 10
                font.italic: true
            }
            background: Rectangle {
                color: foget_pass.focus ? "#888888":"white"
                radius: 5
            }
        }
        Row{
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Button{
                id: login_1
                width: 70
                height: 30
                Text{
                    id: bt_text_login_1
                    text: "LOGIN"
                    color: 	"black"
                    anchors.centerIn: login_1
                    font.pointSize: 10
                    font.bold: true
                }

                background: Rectangle{
                    color: login_1.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    var accpass = parseInt(user_password.text);
                    var accnum = parseInt(user_acc_num.text);
                    if(login.isSign_ad==false){
                        accNumber = accnum
                        ATM.Login(1);
                        main.isSign = ATM.checkUser(accnum,accpass);
                        console.log("Button is click USER")
                        main.user = true;
                    }else{
                        console.log("Button is click ADMIN")
                        main.user = false;
                        ATM.Login(2);
                        main.isSign = ATM.checkUser(accnum,accpass);
                    }
                    if(main.isSign) {
                        user_acc_num.text = ""
                        user_password.text = ""
                        status_lable.text = ""
                    }

                }
            }
            Button{
                visible: !isSign_ad
                id: login_admin
                width: 100
                height: 30
                Text{
                    id: bt_text_login_ad
                    text: "ADMIN LOGIN"
                    color: 	"black"
                    anchors.centerIn: login_admin
                    font.pointSize: 10
                    font.bold: true
                }
                background: Rectangle{
                    color: login_admin.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    login.isSign_ad = true
                }

            }
            Button{
                visible: isSign_ad
                id: login_users
                width: 100
                height: 30
                Text{
                    id: bt_text_login_user
                    text: "USER LOGIN"
                    color: 	"black"
                    anchors.centerIn: login_users
                    font.pointSize: 10
                    font.bold: true
                }
                background: Rectangle{
                    color: login_admin.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                   login.isSign_ad = false
                   status_lable.text = ""
                }
            }
        }
        Label{
            id: status_lable
            text: ATM.login
            color: "black"
            height: 10
            width: 250
            font.bold: true
            font.pointSize: 10
        }
    }
}
