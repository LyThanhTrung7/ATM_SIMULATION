import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: page2

    property int select2: 0
    anchors.centerIn: parent
    visible: isSign && !user
    width: 700
    height: 420
    radius: 20
    border.color: "black"
    border.width: 1
    color: "#DDDDDD"
    Rectangle{
        id: top_page2
        width: 700
        height: 70
        border.color: "black"
        border.width: 1
        Row{
            spacing: 10
            Image {
                id: page2_Image
                source:"qrc:/image/logoatm.png"
                width: 40
                height: 40
                y: 10
            }
            Label{
                font.pointSize: 12
                y: 20
                text: "THANH COMBANK"
                color:"black"
                font.family: "Consolas"
            }
        }
        Label{
            font.pointSize: 20
            text: "LOGIN ADMIN SUCCESSFUL!"
            color:"black"
            font.family: "Consolas"
            y:20
            anchors.centerIn: top_page2
        }
        Button{
            id: log_out_2
            width: 70
            height: 30
            anchors.top: top_page2.top
            anchors.right: top_page2.right
            anchors.margins: 20
            Text{
                text: "LOG OUT"
                color: 	"black"
                anchors.centerIn: log_out_2
                font.pointSize: 10
                font.bold: true
            }
            background: Rectangle{
                color: log_out_2.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                main.isSign = false
                console.log("LOG OUT")
                ATM.logout();
            }
        }
    }
    Column{
        id: colum_page2
        spacing: 25
        visible: select2 == 0
        y: 80
        Label{
            font.pointSize: 20
            text: "Hello! Thanh Trung"
            color:"black"
            font.family: "Consolas"
            font.bold:  true
            anchors.horizontalCenter: colum_page2.horizontalCenter
        }
        Label{
            font.pointSize: 20
            text: "Please select transaction"
            color:"black"
            font.family: "Consolas"
            font.bold:  true
            anchors.horizontalCenter: colum_page2.horizontalCenter
        }
        Row{
            id: row1_2
            spacing: 300
            Button{
                id: bt_list_user
                width: 200
                height: 30
                Text{
                    text: "Display user list"
                    color: 	"black"
                    anchors.centerIn: bt_list_user
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: bt_list_user.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page2.select2 = 1
                    ATM.readHistory(111,0);
                }
            }
            Button{
                id: bt_add_user
                width: 200
                height: 30
                Text{
                    text: "Add user account"
                    color: 	"black"
                    anchors.centerIn: bt_add_user
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: bt_add_user.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page2.select2 = 2
                }
            }

        }
        Row{
            id: row22
            spacing: 300
            Button{
                id: bt_delete_user
                width: 200
                height: 30

                Text{
                    text: "Delete user account"
                    color: 	"black"
                    anchors.centerIn: bt_delete_user
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: bt_delete_user.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page2.select2 = 3
                }
            }
            Button{
                id: bt_search
                width: 200
                height: 30
                Text{
                    text: "Search user account"
                    color: 	"black"
                    anchors.centerIn: bt_search
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: bt_search.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page2.select2 = 4
                }
            }
        }
        Row{
            id: row32
            spacing: 300
            Button{
                id: history2
                width: 200
                height: 30

                Text{
                    text: "Transaction history"
                    color: 	"black"
                    anchors.centerIn: history2
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: history2.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page2.select2 = 5
                    // myMenu.user_his(0);
                }
            }
            Button{
                id: bt_report
                width: 200
                height: 30
                Text{
                    text: "Statistical report"
                    color: 	"black"
                    anchors.centerIn: bt_report
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: bt_report.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page2.select2 = 6
                }
            }
        }
    }
    Column{
        id: page_user_list
        spacing: 10
        visible: select2 == 1
        width: 700
        height: 250
        y: 80
        anchors.horizontalCenter: page2.horizontalCenter
        Label{
            id: label_user
            anchors.horizontalCenter: page_user_list.horizontalCenter
            Text{
                text: "Display user list"
                color: "black"
                font.pointSize: 20
                font.family: "Consolas"
                anchors.centerIn: label_user
            }
            height: 20
            width: 500
        }
        ComboBox{
            id: select_view2
            width: 150
            height: 25
            currentIndex: 0
            model: select_view2ListModel
            x: 10
            ListModel{
                id: select_view2ListModel
                ListElement{
                    key: "All User"
                }
                ListElement{
                    key: "Latest User"
                }
                ListElement{
                    key: "Oldest User"
                }
                ListElement{
                    key: "Largest Amount"
                }
                ListElement{
                    key: "Minimum amount"
                }
            }
            contentItem: Text{
                text: select_view2.displayText
                font.pointSize: 10
                font.family: "Consolas"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "black"
            }
            onActivated: {
                ATM.readHistory(111,select_view2.currentIndex);
            }
        }

        ScrollView {
            id: view_user_list
            width: 650
            height: 220
            anchors.horizontalCenter: page_user_list.horizontalCenter
            contentHeight: column.height
            contentWidth: column.width
            Column{
                id: column
                width: view_user_list.width
                RowLayout {
                    spacing: 2
                    Layout.fillWidth: true
                    Rectangle { width: 120; height: 40; color: "#888888"; border.color: "black"
                        Text { anchors.centerIn: parent; text: "Account Number"; font.bold: true }
                    }
                    Rectangle { width: 150; height: 40; color: "#888888"; border.color: "black"
                        Text { anchors.centerIn: parent; text: "Account Name"; font.bold: true }
                    }
                    Rectangle { width: 200; height: 40; color: "#888888"; border.color: "black"
                        Text { anchors.centerIn: parent; text: "Transaction Time"; font.bold: true }
                    }
                    Rectangle { width: 150; height: 40; color: "#888888"; border.color: "black"
                        Text { anchors.centerIn: parent; text: "Transaction Money"; font.bold: true }
                    }
                }

                Repeater {
                    id: list
                    model: ATM.his
                    RowLayout {
                        spacing: 2
                        Rectangle { width: 120; height: 40; color: "#DDDDDD"; border.color: "black"
                            Text { anchors.centerIn: parent; text: modelData.ACC_NUM }
                        }
                        Rectangle { width: 150; height: 40; color: "#DDDDDD"; border.color: "black"
                            Text { anchors.centerIn: parent; text: modelData.ACC_NAME }
                        }
                        Rectangle { width: 200; height: 40; color: "#DDDDDD"; border.color: "black"
                            Text { anchors.centerIn: parent; text: modelData.ACC_DATE }
                        }
                        Rectangle { width: 150; height: 40; color: "#DDDDDD"; border.color: "black"
                            Text { anchors.centerIn: parent; text: modelData.ACC_MONEY }
                        }
                    }
                }
            }
        }

        Button{
            id: return_list
            width: 150
            height: 30
            anchors.horizontalCenter:page_user_list.horizontalCenter
            Text{
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: return_list
                font.pointSize: 15
            }
            background: Rectangle{
                color: page_user_list.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page2.select2 = 0
                ATM.his = ""
            }
        }
    }
    Column{
        id: page_add_user
        spacing: 15
        visible: select2 == 2
        width: 700
        height: 250
        y: 80
        anchors.horizontalCenter: page2.horizontalCenter

        Label{
            id: label_add
            anchors.horizontalCenter: page_add_user.horizontalCenter
            Text{
                text: "Add user account"
                color: "black"
                font.pointSize: 20
                font.family: "Consolas"
                anchors.centerIn: label_add
            }
            height: 20
            width: 500
        }

        TextField{
            id: name_user_add
            anchors.horizontalCenter: page_add_user.horizontalCenter
            placeholderText: "Enter new name user"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 45
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: name_user_add.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: acc_num_add
            anchors.horizontalCenter: page_add_user.horizontalCenter
            placeholderText: "Enter new user account number"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 45
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: acc_num_add.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: pass_add_1
            anchors.horizontalCenter: page_add_user.horizontalCenter
            placeholderText: "Enter user new pin code"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 45
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: pass_add_1.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: pass_add_2
            anchors.horizontalCenter: page_add_user.horizontalCenter
            placeholderText: "Re-enter user new pin code"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 45
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: pass_add_2.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        Row{
            spacing: 20
            anchors.horizontalCenter: page_add_user.horizontalCenter
            Button{
                id: add_user_done
                width: 100
                height: 25
                anchors.horizontalCenter: add_user_done.horizontalCenter
                Text{
                    text: "Add"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: add_user_done
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: add_user_done.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    var number = parseInt(acc_num_add.text);
                    var pin1 = parseInt(pass_add_1.text);
                    var pin2 = parseInt(pass_add_2.text);
                    if(pin1 === pin2){
                        ATM.acctionMenu(0,number,pin1,name_user_add.text);
                    }else ATM.status = "Pin Code don't match!!!!"
                }
            }
            Button{
                id: return_add
                width: 100
                height: 25
                anchors.horizontalCenter: return_add.horizontalCenter
                Text{
                    text: "Return"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: return_add
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: return_add.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    page2.select2 = 0
                    pass_add_1.text = ""
                    pass_add_2.text = ""
                    name_user_add.text = ""
                    acc_num_add.text = ""
                    ATM.status = ""
                }
            }
        }
        Label{
            anchors.horizontalCenter: page_add_user.horizontalCenter
            text: ATM.status;
            color: "black"
            height: 10
            width: 250
        }
    }
    Column{
        id: page_delete_user
        spacing: 15
        visible: select2 == 3
        width: 700
        height: 250
        y: 120
        anchors.centerIn: page2

        Label{
            id: label_dele
            anchors.horizontalCenter: page_delete_user.horizontalCenter
            Text{
                text: "Delete user account"
                color: "black"
                font.pointSize: 20
                font.family: "Consolas"
                anchors.centerIn: label_dele
            }
            height: 20
            width: 500
        }

        TextField{
            id: acc_num_dele
            anchors.horizontalCenter: page_delete_user.horizontalCenter
            placeholderText: "Enter user account number"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 45
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: acc_num_dele.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: pass_delete_1
            anchors.horizontalCenter: page_delete_user.horizontalCenter
            placeholderText: "Enter user pin code"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 45
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: pass_delete_1.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        Row{
            spacing: 20
            anchors.horizontalCenter: page_delete_user.horizontalCenter
            Button{
                id: delete_user_done
                width: 100
                height: 25
                anchors.horizontalCenter: delete_user_done.horizontalCenter
                Text{
                    text: "Delete"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: delete_user_done
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: delete_user_done.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    var num = parseInt(acc_num_dele.text);
                    var pin = parseInt(pass_delete_1.text);
                    ATM.acctionMenu(1, num, pin);
                }
            }
            Button{
                id: return_delete
                width: 100
                height: 25
                anchors.horizontalCenter: return_delete.horizontalCenter
                Text{
                    text: "Return"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: return_delete
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: return_delete.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    page2.select2 = 0
                    pass_delete_1.text = ""
                    acc_num_dele.text = ""
                    ATM.status = ""
                }
            }
        }
        Label{
            anchors.horizontalCenter: page_delete_user.horizontalCenter
            text: ATM.status;
            color: "black"
            height: 10
            width: 250
        }
    }
    Column{
        id: page_search_user
        spacing: 15
        visible: select2 == 4
        width: 700
        height: 250
        y: 80
        anchors.centerIn: page2

        Label{
            id: label_search
            anchors.horizontalCenter: page_search_user.horizontalCenter
            Text{
                text: "Search user account"
                color: "black"
                font.pointSize: 20
                font.family: "Consolas"
                anchors.centerIn: label_search
            }
            height: 20
            width: 500
        }

        Row{
            spacing: 20
            anchors.horizontalCenter: page_search_user.horizontalCenter
            TextField{
                id: acc_num_search
                placeholderText: "Enter user account number"
                placeholderTextColor: "#888888"
                color: "black"
                width: 350
                height: 30
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 13
                leftPadding: 10
                background: Rectangle {
                    color: acc_num_search.focus ? "#888888":"white"
                    radius: 5
                    border.color: "black"
                    border.width: 1
                }
            }
            Button{
                id: search_user_done
                width: 100
                height: 30
                anchors.horizontalCenter: page_search_user.horizontalCenter
                Text{
                    text: "Search"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: search_user_done
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: search_user_done.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    var num = parseInt(acc_num_search.text);
                    ATM.acctionMenu(2, num, 0);
                }
            }
        }

        Label{
            id: label_search_infor
            anchors.horizontalCenter: page_search_user.horizontalCenter
            Text{
                text: ATM.status
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: label_search_infor
                font.pointSize: 15
            }
            height:180
            width: 150
        }

        Button{
            id: return_search
            width: 100
            height: 30
            anchors.horizontalCenter: page_search_user.horizontalCenter
            Text{
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: return_search
                font.pointSize: 13
            }
            background: Rectangle{
                color: return_search.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page2.select2 = 0
                acc_num_search.text = ""
                ATM.status = ""
            }
        }
    }
    Column{
        id: page_transfer_list
        spacing: 10
        visible: select2 == 5
        width: 700
        height: 250
        y: 80
        anchors.horizontalCenter: page2.horizontalCenter
        Label{
            id: label_trans
            anchors.horizontalCenter: page_transfer_list.horizontalCenter
            Text{
                text: "List of transaction history"
                color: "black"
                font.pointSize: 18
                anchors.centerIn: label_trans
            }
            height: 20
            width: 500
        }
        Row{
            spacing: 20
            x: 10
            ComboBox{
                id: select_view3
                width: 150
                height: 25
                currentIndex: 0
                model: select_view3ListModel
                ListModel{
                    id: select_view3ListModel
                    ListElement{
                        key: "All"
                    }
                    ListElement{
                       key: "Latest"
                    }
                    ListElement{
                        key: "Oldest"
                    }
                }
                contentItem: Text{
                    text: select_view3.displayText
                    font.pointSize: 12
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "black"
                }
                onActivated: {
                    var num = parseInt(acc_num_search_transfer.text);
                    ATM.readHistory(num,select_view3.currentIndex);
                }
            }
            TextField{
                id: acc_num_search_transfer
                placeholderText: "Enter user account number"
                placeholderTextColor: "#888888"
                color: "black"
                width: 350
                height: 25
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
                leftPadding: 10
                background: Rectangle {
                    color: acc_num_search_transfer.focus ? "#888888":"white"
                    radius: 5
                    border.color: "black"
                    border.width: 1
                }
            }
            Button{
                id: search_transfer_user_done
                width: 80
                height: 25
                anchors.horizontalCenter: page_transfer_list.horizontalCenter
                Text{
                    text: "Search"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: search_transfer_user_done
                    font.pointSize: 10
                }
                background: Rectangle{
                    color: search_transfer_user_done.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    var num = parseInt(acc_num_search_transfer.text);
                    ATM.readHistory(num, select_view3.currentIndex);
                }
            }
        }
        ScrollView {
            id: view_transfer_list
            width: 650
            height: 230
            anchors.horizontalCenter: page_transfer_list.horizontalCenter
            contentHeight: columnnn.height
            contentWidth: columnnn.width
            Column{
                id: columnnn
                width: view_transfer_list.width
                RowLayout {
                    spacing: 2
                    Layout.fillWidth: true
                    Rectangle { width: 120; height: 40; color: "#888888"; border.color: "black"
                        Text { anchors.centerIn: parent; text: "Account Number"; font.bold: true }
                    }
                    Rectangle { width: 200; height: 40; color: "#888888"; border.color: "black"
                        Text { anchors.centerIn: parent; text: "Transaction Time"; font.bold: true }
                    }
                    Rectangle { width: 150; height: 40; color: "#888888"; border.color: "black"
                        Text { anchors.centerIn: parent; text: "Transaction Type"; font.bold: true }
                    }
                    Rectangle { width: 150; height: 40; color: "#888888"; border.color: "black"
                        Text { anchors.centerIn: parent; text: "Transaction Money"; font.bold: true }
                    }
                }

                Repeater {
                    id: list_transfer
                    model: ATM.his
                    RowLayout {
                        spacing: 2
                        Rectangle { width: 120; height: 40; color: "#DDDDDD"; border.color: "black"
                            Text { anchors.centerIn: parent; text: modelData.ACC_NUM }
                        }
                        Rectangle { width: 200; height: 40; color: "#DDDDDD"; border.color: "black"
                            Text { anchors.centerIn: parent; text: modelData.ACC_DATE }
                        }
                        Rectangle { width: 150; height: 40; color: "#DDDDDD"; border.color: "black"
                            Text { anchors.centerIn: parent; text: modelData.ACC_TYPE }
                        }
                        Rectangle { width: 150; height: 40; color: "#DDDDDD"; border.color: "black"
                            Text { anchors.centerIn: parent; text: modelData.ACC_MONEY }
                        }
                    }
                }
            }
        }

        Button{
            id: return_transfer
            width: 100
            height: 25
            anchors.horizontalCenter:page_transfer_list.horizontalCenter
            Text{
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: return_transfer
                font.pointSize: 13
            }
            background: Rectangle{
                color: page_transfer_list.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page2.select2 = 0
                ATM.his = ""
            }
        }
    }
}
