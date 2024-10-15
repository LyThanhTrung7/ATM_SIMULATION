import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{
    id: page1

    property int select: 1
    property int sent: 0
    property bool cash_out_user: false
    property bool other_num: false
    property bool pinChange: false
    property string text_cash:""
    property bool transfer: false

    function formatMoney(inputText) {
        if (inputText === "" || isNaN(inputText.replace(/,/g, ''))) {
            return inputText;
        }

        var num = inputText.replace(/,/g, '');

        return num.replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
    }

    anchors.centerIn: parent
    visible: isSign && user
    width: 700
    height: 420
    radius: 20
    border.color: "black"
    border.width: 1
    color: "#DDDDDD"
    Rectangle{
        id: top_page1
        width: 700
        height: 70
        border.color: "black"
        border.width: 1
        Row{
            spacing: 10
            x:10
            Image {
                id: page1_Image
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
            text: "LOGIN SUCCESSFUL!"
            color:"black"
            font.family: "Consolas"
            y:20
            anchors.centerIn: top_page1
        }
        Button{
            id: log_out
            width: 70
            height: 30
            anchors.top: top_page1.top
            anchors.right: top_page1.right
            anchors.margins: 20
            
            Text{
                text: "LOG OUT"
                color: 	"black"
                anchors.centerIn: log_out
                font.pointSize: 10
                font.bold: true
            }
            background: Rectangle{
                color: log_out.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                main.isSign = false
                ATM.logout();
                console.log("LOG OUT")
            }
        }
    }
    Column{
        id: colum_page1
        spacing: 25
        visible: select == 1
        y: 80
        Label{
            id: name_user
            font.pointSize: 20
            text: "Hello!" + ATM.name
            color:"black"
            font.family: "Consolas"
            font.bold:  true
            anchors.horizontalCenter: colum_page1.horizontalCenter
        }
        Label{
            font.pointSize: 20
            text: "Please select transaction"
            color:"black"
            font.family: "Consolas"
            font.bold:  true
            anchors.horizontalCenter: colum_page1.horizontalCenter
        }
        Row{
            id: row1
            spacing: 300
            Button{
                id: withdraw_bt
                width: 200
                height: 30
                Text{
                    text: "With Draw"
                    color: 	"black"
                    anchors.centerIn: withdraw_bt
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: withdraw_bt.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page1.select = 2
                }
            }
            Button{
                id: changePin_bt
                width: 200
                height: 30
                Text{
                    text: "Change Pin Code"
                    color: 	"black"
                    anchors.centerIn: changePin_bt
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: changePin_bt.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page1.select = 3
                }
            }

        }
        Row{
            id: row2
            spacing: 300
            Button{
                id: view_print
                width: 200
                height: 30

                Text{
                    text: "View balance/print"
                    color: 	"black"
                    anchors.centerIn: view_print
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: view_print.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    ATM.readInfor();
                    page1.select = 4
                }
            }
            Button{
                id: transfer
                width: 200
                height: 30
                Text{
                    text: "Transfer"
                    color: 	"black"
                    anchors.centerIn: transfer
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: transfer.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page1.select = 5
                }
            }
        }
        Row{
            id: row3
            spacing: 300
            Button{
                id: history
                width: 200
                height: 30

                Text{
                    text: "Transaction history"
                    color: 	"black"
                    anchors.centerIn: history
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: history.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page1.select = 7
                    ATM.readHistory(accNumber,1)
                }
            }
            Button{
                id: send_money
                width: 200
                height: 30
                Text{
                    text: "Send money"
                    color: 	"black"
                    anchors.centerIn: send_money
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: send_money.pressed ?"#555555":"white"
                    radius: 10
                    border.color: "black"
                    border.width: 1
                }
                onClicked: {
                    page1.select = 6
                }
            }
        }
    }

    Column{
        visible: select == 2
        id: with_draw_menu
        anchors.horizontalCenter: page1.horizontalCenter
        spacing: 30
        y: 80
        Label{
            font.pointSize: 20
            text: "Please select amount"
            anchors.horizontalCenter: with_draw_menu.horizontalCenter
            color: "black"
            font.family: "Consolas"
        }

        Column{
            visible: !other_num
            spacing: 30
            Row{
                id: row_with_draw1
                spacing: 300
                Button{
                    id: bt_100k
                    width: 200
                    height: 30
                    Text{
                        text: "100 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: bt_100k
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: bt_100k.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(0,"100000",0);
                        page1.cash_out_user = true
                        page1.select = 0
                    }
                }
                Button{
                    id: bt_2tr
                    width: 200
                    height: 30
                    Text{
                        text: "2 000 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: bt_2tr
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: bt_2tr.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(0,"2000000",0);
                        page1.cash_out_user = true
                        page1.select = 0
                    }
                }
            }
            Row{
                id: row_with_draw2
                spacing: 300
                Button{
                    id: bt_500k
                    width: 200
                    height: 30
                    Text{
                        text: "500 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: bt_500k
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: bt_500k.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(0,"500000",0);
                        page1.cash_out_user = true
                        page1.select = 0
                    }
                }
                Button{
                    id: bt_other
                    width: 200
                    height: 30
                    Text{
                        text: "Other Number"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: bt_other
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: bt_other.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        page1.other_num = true
                    }
                }
            }
            Row{
                id: row_with_draw3
                spacing: 300
                Button{
                    id: bt_1tr
                    width: 200
                    height: 30
                    Text{
                        text: "1 000 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: bt_1tr
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: bt_1tr.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(0,1000000,0);
                        page1.cash_out_user = true
                        page1.select = 0
                    }
                }
                Button{
                    id: bt_return
                    width: 200
                    height: 30
                    Text{
                        text: "Return"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: bt_return
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: bt_return.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        page1.select = 1
                        ATM.status = ""
                    }
                }
            }
            Row{
                id: row_with_draw4
                spacing: 300
                Button{
                    id: bt_1tr5
                    width: 200
                    height: 30
                    Text{
                        text: "1 500 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: bt_1tr5
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: bt_1tr5.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(0,1500000,0);
                        page1.cash_out_user = true
                        page1.select = 0
                    }
                }
            }
        }

        TextField {
            visible: other_num
            id: enter_money
            placeholderText: "Enter cash amount (VND)"
            validator: IntValidator { }  // Chỉ cho phép nhập số
            onTextChanged: {
                page1.text_cash = enter_money.text;
                var cursorPosition = enter_money.cursorPosition;
                var oldText = enter_money.text;

                enter_money.text = formatMoney(oldText);

                var newText = enter_money.text;
                var oldLength = oldText.length;
                var newLength = newText.length;

                cursorPosition += (newLength - oldLength);

                cursorPosition = Math.min(cursorPosition, newLength);

                enter_money.cursorPosition = cursorPosition;
            }
            placeholderTextColor: "#888888"
            font.family: "Consolas"
            color: "black"
            width: 300
            height: 50
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 15
            leftPadding: 10
            background: Rectangle {
                color: enter_money.focus ? "#d9d2e9" : "white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        Row{
            visible: other_num
            anchors.horizontalCenter: with_draw_menu.horizontalCenter
            spacing: 10
            Button{
                id: withdraw_other_bt
                width: 120
                height: 30
                Text{
                    id: with_other_bt
                    text: "Cash out"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: withdraw_other_bt
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: withdraw_other_bt.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    var cleanedText = text_cash.replace(/,/g, "");  // Loại bỏ dấu phẩy
                    var amount = parseFloat(cleanedText);
                    ATM.acctionMenu(0,amount,0);
                    page1.cash_out_user = true
                    page1.select = 0
                }
            }
            Button{
                id: reset_other_bt
                width: 120
                height: 30
                Text{
                    id: reset_other
                    text: "Reset"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: reset_other_bt
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: reset_other_bt.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    enter_money.text = ""
                }
            }
        }
        Button{
            visible: other_num
            id: return_cash
            width: 100
            height: 30
            anchors.horizontalCenter: with_draw_menu.horizontalCenter
            Text{
                id: returnCash
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: return_cash
                font.pointSize: 13
            }
            background: Rectangle{
                color: return_cash.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page1.other_num = false
                page1.select = 1
                enter_money.text = ""
                ATM.status = ""
            }
        }
    }
    Column{
        visible: cash_out_user
        id: dis_infor
        spacing:20
        anchors.centerIn: page1
        Label{
            id: label_disinfor
            anchors.horizontalCenter: dis_infor.horizontalCenter
            Text{
                text: ATM.status
                color: "black"
                font.pointSize: 20
                font.family: "Consolas"
                anchors.centerIn: label_disinfor
            }
            height: 20
            width: 500
        }
        Button{
            id: re
            width: 150
            height: 30
            anchors.horizontalCenter: dis_infor.horizontalCenter
            Text{
                id: ret
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: re
                font.pointSize: 15
            }
            background: Rectangle{
                color: re.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page1.select = 1
                page1.cash_out_user = false
                page1.other_num = false
                enter_money.text = ""
                ATM.status = ""
            }
        }
    }
    Column{
        visible: select == 3
        id: changed_pincode
        anchors.horizontalCenter: page1.horizontalCenter
        spacing: 20
        y: 80
        Label{
            id: changed
            font.pointSize: 20
            text: "Change pin code"
            color:"black"
            font.family: "Consolas"
            anchors.horizontalCenter: page1.horizontalCenter
        }
        TextField{
            id: pincode_old
            placeholderText: "Enter your old pin code"
            placeholderTextColor: "#888888"
            color: "black"
            width: 230
            height: 40
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: pincode_old.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: pincode_new1
            placeholderText: "Enter your new pin code"
            placeholderTextColor: "#888888"
            color: "black"
            width: 230
            height: 40
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: pincode_new1.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: pincode_new2
            placeholderText: "Re-enter your new pin code"
            placeholderTextColor: "#888888"
            color: "black"
            width: 230
            height: 40
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: pincode_new2.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        Row{
            spacing: 20
            Button{
                id: changed_pin
                width: 100
                height: 25
                anchors.horizontalCenter: changed_pin.horizontalCenter
                Text{
                    id: change
                    text: "Change"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: changed_pin
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: changed_pin.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    var oldPin = parseFloat(pincode_old.text);
                    var newPin1 = parseFloat(pincode_new1.text);
                    var newPin2 = parseFloat(pincode_new2.text);

                    if(newPin1 === newPin2) ATM.acctionMenu(1,newPin1,oldPin);
                    else ATM.status = "RE-ENTER NEW PASSWORD!!!";
                }
            }
            Button{
                id: return_changed
                width: 100
                height: 25
                anchors.horizontalCenter: return_changed.horizontalCenter
                Text{
                    id: returnchanged
                    text: "Return"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: return_changed
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: return_changed.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    page1.select = 1
                    pincode_old.text = ""
                    pincode_new1.text = ""
                    pincode_new2.text = ""
                    ATM.status = ""
                }
            }
        }
        Label{
            visible: !pinChange
            anchors.horizontalCenter: changed_pincode.horizontalCenter
            id: status_change
            text: ATM.status
            color: "black"
            height: 10
            width: 250
        }
    }
    Column{
        id: changed_done
        visible: pinChange
        anchors.centerIn:page1
        spacing: 30
        Label{
            id: status_done
            Text{
                id: done_text
                text: ATM.status
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: status_done
                font.pointSize: 15
            }
            height: 20
            width: 250
        }
        Button{
            id: done_return
            width: 150
            height: 30
            anchors.horizontalCenter: changed_done.horizontalCenter
            Text{
                id: return_change_done
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: done_return
                font.pointSize: 15
            }
            background: Rectangle{
                color: done_return.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page1.select = 1
                page1.pinChange = false
            }
        }
    }
    Column{
        id: infor_user_page
        visible: select == 4
        spacing: 10
        anchors.centerIn: page1
        Label{
            id: top_page_infor
            anchors.horizontalCenter: infor_user_page.horizontalCenter
            Text{
                text: "User Information"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: top_page_infor
                font.pointSize: 20
            }
            height:20
            width: 150
        }
        Label{
            id: label_infor
            anchors.horizontalCenter: infor_user_page.horizontalCenter
            Text{
                id: money_text
                text: ATM.infor
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: label_infor
                font.pointSize: 15
            }
            height:120
            width: 150
        }
        Button{
            id: infor_return
            width: 150
            height: 30
            anchors.horizontalCenter: infor_user_page.horizontalCenter
            Text{
                id: return_infor
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: infor_return
                font.pointSize: 15
            }
            background: Rectangle{
                color: infor_return.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page1.select = 1
            }
        }
    }
    Column{
        id: transfer_page
        visible: select == 5 && !page1.transfer
        anchors.horizontalCenter: page1.horizontalCenter
        spacing: 20
        y: 80
        Label{
            id: label_transfer
            font.pointSize: 20
            text: "Transfer Money"
            color:"black"
            font.family: "Consolas"
            anchors.horizontalCenter: page1.horizontalCenter
        }
        TextField{
            id: num_receiver
            placeholderText: "Enter Recipient account number"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 40
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: pincode_old.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: money_receiver
            placeholderText: "Enter deposit amount (VND)"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 40
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 13
            leftPadding: 10
            onTextChanged: {
                var cursorPosition = money_receiver.cursorPosition;
                var oldText = money_receiver.text;

                money_receiver.text = formatMoney(oldText);

                var newText = money_receiver.text;
                var oldLength = oldText.length;
                var newLength = newText.length;

                cursorPosition += (newLength - oldLength);

                cursorPosition = Math.min(cursorPosition, newLength);

                money_receiver.cursorPosition = cursorPosition;
            }
            background: Rectangle {
                color: pincode_new1.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        TextField{
            id: pincode_transfer
            placeholderText: "Enter your pin code"
            placeholderTextColor: "#888888"
            color: "black"
            width: 250
            height: 40
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            font.pointSize: 13
            leftPadding: 10
            background: Rectangle {
                color: pincode_new2.focus ? "#888888":"white"
                radius: 5
                border.color: "black"
                border.width: 1
            }
        }
        Row{
            spacing: 20
            Button{
                id: bt_transfer
                width: 100
                height: 25
                anchors.horizontalCenter: transfer_page.horizontalCenter
                Text{
                    id: text_bt_transfer
                    text: "Transfer"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: bt_transfer
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: bt_transfer.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    var rawText = num_receiver.text;
                    var cleaned = money_receiver.text.replace(/,/g, "");
                    ATM.acctionMenu(2,cleaned,rawText);
                }
            }
            Button{
                id: return_tranfer
                width: 100
                height: 25
                anchors.horizontalCenter: return_tranfer.horizontalCenter
                Text{
                    text: "Return"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: return_tranfer
                    font.pointSize: 13
                }
                background: Rectangle{
                    color: return_tranfer.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    page1.select = 1
                    num_receiver.text = ""
                    money_receiver.text = ""
                    pincode_transfer.text = ""
                    ATM.status = ""
                    page1.transfer = false
                }
            }
        }
        Label{
            anchors.horizontalCenter: transfer_page.horizontalCenter
            id: status_tranfer
            text: ATM.status
            color: "black"
            height: 10
            width: 250
        }
    }
    Column{
        visible: select == 6 && !sent
        id: send_menu
        anchors.horizontalCenter: page1.horizontalCenter
        spacing: 30
        y: 80
        Label{
            font.pointSize: 20
            text: "Send Money"
            anchors.horizontalCenter: send_menu.horizontalCenter
            color: "black"
            font.family: "Consolas"
        }
        Column{
            spacing: 50
            Row{
                id: send_row1
                spacing: 300
                Button{
                    id: send1tr
                    width: 200
                    height: 30
                    Text{
                        text: "1 000 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: send1tr
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: send1tr.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(3,1000000,0);
                        page1.sent = true
                        page1.select = 0
                    }
                }
                Button{
                    id: send2tr
                    width: 200
                    height: 30
                    Text{
                        text: "2 000 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: send2tr
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: send2tr.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(3,2000000,0);
                        page1.sent = true
                        page1.select = 0
                    }
                }
            }
            Row{
                id: send_row2
                spacing: 300
                Button{
                    id: send5tr
                    width: 200
                    height: 30
                    Text{
                        text: "5 000 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: send5tr
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: send5tr.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(3,5000000,0);
                        page1.sent = true
                        page1.select = 0
                    }
                }
                Button{
                    id: send10tr
                    width: 200
                    height: 30
                    Text{
                        text: "10 000 000"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: send10tr
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: send10tr.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        ATM.acctionMenu(3,10000000,0);
                        page1.sent = true
                        page1.select = 0
                    }
                }
            }
            Row{
                id: send_row3
                Button{
                    id: send_return
                    width: 200
                    height: 30
                    Text{
                        text: "Return"
                        color: 	"black"
                        font.family: "Consolas"
                        anchors.centerIn: send_return
                        font.pointSize: 13
                    }
                    background: Rectangle{
                        color: send_return.pressed ?"#555555":"white"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    onClicked: {
                        page1.select = 1
                        page1.sent = false
                    }
                }
            }
        }
    }
    Column{
        visible: select == 0 && sent
        id: send_done
        spacing:20
        anchors.centerIn: page1
        Label{
            id: label_send_done
            anchors.horizontalCenter: send_done.horizontalCenter
            Text{
                text: ATM.his
                color: "black"
                font.pointSize: 20
                font.family: "Consolas"
                anchors.centerIn: label_send_done
            }
            height: 20
            width: 500
        }
        Button{
            id: return_done_send
            width: 150
            height: 30
            anchors.horizontalCenter: send_done.horizontalCenter
            Text{
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: return_done_send
                font.pointSize: 15
            }
            background: Rectangle{
                color: return_done_send.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page1.select = 1
                page1.sent = false
                ATM.status =""
            }
        }
    }

    Column{
        id: page_history
        spacing: 10
        visible: select == 7
        width: 700
        height: 250
        y: 80
        anchors.horizontalCenter: page1.horizontalCenter
        Label{
            id: label_his
            anchors.horizontalCenter: page_history.horizontalCenter
            Text{
                text: "Transaction History"
                color: "black"
                font.pointSize: 20
                font.family: "Consolas"
                anchors.centerIn: label_his
            }
            height: 20
            width: 500
        }
        ComboBox{
            id: select_view
            width: 150
            height: 25
            currentIndex: 0
            model: select_viewListModel
            x: 10
            ListModel{
                id: select_viewListModel
                ListElement{
                    key: "Latest"
                }
                ListElement{
                    key: "Oldest"
                }
            }
            contentItem: Text{
                text: select_view.displayText
                font.pointSize: 12
                font.family: "Consolas"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "black"
            }
            onActivated: {
                 if (select_view.currentIndex === 0) {
                     ATM.readHistory(accNumber,1)
                 } else if (select_view.currentIndex === 1) {
                     ATM.readHistory(accNumber,2)
                 }
            }
        }

        ScrollView {
            id: view_his
            width: 650
            height: 220
            anchors.horizontalCenter: page_history.horizontalCenter
            contentHeight: column.height
            contentWidth: column.width
            Column{
                id: column
                width: view_his.width

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
                    id: list
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
            id: return_his
            width: 150
            height: 30
            anchors.horizontalCenter:page_history.horizontalCenter
            Text{
                text: "Return"
                color: 	"black"
                font.family: "Consolas"
                anchors.centerIn: return_his
                font.pointSize: 15
            }
            background: Rectangle{
                color: page_history.pressed ?"white":"#888888"
                radius: 10
            }
            onClicked: {
                page1.select = 1
            }
        }
    }
}


