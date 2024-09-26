import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import PROJECT_ATM

Window {
    id: root
    width: 800
    height: 500
    visible: true
    title: qsTr("THANH COMBANK")

    property bool isSign: false
    property bool isSign_ad: false
    property int select: 0
    property int select2: 0
    property string name
    property bool other_num: false
    property bool cash_out_user: false
    property bool pinChange: false
    property string text_cash:""
    property bool transfer: false
    property bool sent: false
    property bool user: false

    function formatMoney(inputText) {
        if (inputText === "" || isNaN(inputText.replace(/,/g, ''))) {
            return inputText;
        }

        var num = inputText.replace(/,/g, '');

        return num.replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
    }

    Login{
        id: your_login
        onLogin_success: {
            myMenu.read_acc(user_acc_num.text,user_password.text)
            console.log("Login Success")
            root.isSign = true
            root.select = 1
            name = your_login.status
            your_login.status = ""
        }
        onLogin_fails: {
            color: "black"
            console.log("Login fails")
            root.isSign = false
        }
        onLogin_success_ad: {
            root.isSign = true

        }
        onLogin_fails_ad: {
            root.isSign = false
        }

    }
    ATM{
        id: myMenu
        onChange_pin_success: {
            root.select = 0
            myMenu.note = "Pin code changed successful"
            root.pinChange = true
        }
        onChange_pin_false: {
            root.pinChange = false
        }
        onTransfer_pin_success: {
            root.select = 0
            root.transfer = true
        }
        onTransfer_pin_false: {
            root.transfer = false
        }
    }
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "qrc:/image/atm.png"
        fillMode: Image.PreserveAspectCrop
    }
    Column{
        visible: !isSign
        id: column_login_user
        spacing: 15
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
                    if(isSign_ad==false){
                        var accpass = parseInt(user_password.text);
                        your_login.login_user(user_acc_num.text,accpass)
                        console.log("Button is click USER")
                        user = true;
                    }else{
                        your_login.login_admin(user_acc_num.text,user_password.text)
                        console.log("Button is click ADMIN")
                        user = false;
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
                    root.isSign_ad = true
                    // your_login.status = " "
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
                    root.isSign_ad = false
                    your_login.status = " "
                }
            }
        }
        Label{
            id: status_lable
            text: your_login.status
            color: "black"
            height: 10
            width: 250
        }

        anchors.centerIn: parent
    }

    //------------user-----------------
    Rectangle{
        id: page1
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
                    root.isSign = false
                    console.log("LOG OUT")
                    pincode_old.text = ""
                    pincode_new1.text = ""
                    pincode_new2.text = ""
                    user_acc_num.text = ""
                    user_password.text = ""
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
                text: "Hello!"+ name
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
                        root.select = 2
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
                        // root.isSign = false
                        root.select = 3
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
                        myMenu.User_infor()
                        root.select = 4
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
                        root.select = 5
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
                        root.select = 7
                        myMenu.user_his(0);
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
                        root.select = 6
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
                            myMenu.cash_out("100000")
                            root.cash_out_user = true
                            root.select = 0
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
                            myMenu.cash_out("2000000")
                            root.cash_out_user = true
                            root.select = 0
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
                            myMenu.cash_out("500000")
                            root.cash_out_user = true
                            root.select = 0
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
                            root.other_num = true
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
                            myMenu.cash_out("1000000")
                            root.cash_out_user = true
                            root.select = 0
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
                            root.select = 1
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
                            myMenu.cash_out("1500000")
                            root.cash_out_user = true
                            root.select = 0
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
                    root.text_cash = enter_money.text;
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
                        console.log(cleanedText)
                        myMenu.cash_out(cleanedText)
                        root.cash_out_user = true
                        root.select = 0
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
                    root.other_num = false
                    root.select = 1
                    enter_money.text = ""
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
                    text: myMenu.infor
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
                    root.select = 1
                    root.cash_out_user = false
                    root.other_num = false
                    enter_money.text = ""
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
                        myMenu.change_pin(pincode_old.text,pincode_new1.text,pincode_new2.text)
                        //root.select = 0
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
                        root.select = 1
                        pincode_old.text = ""
                        pincode_new1.text = ""
                        pincode_new2.text = ""
                        myMenu.note = ""
                    }
                }
            }
            Label{
                visible: !pinChange
                anchors.horizontalCenter: changed_pincode.horizontalCenter
                id: status_change
                text: myMenu.note
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
                    text: myMenu.note
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
                    root.select = 1
                    root.pinChange = false
                    pincode_old.text = ""
                    pincode_new1.text= ""
                    pincode_new2.text= ""
                    myMenu.note = ""
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
                    text: myMenu.user_infor
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
                    root.select = 1
                }
            }
        }
        Column{
            id: transfer_page
            visible: select == 5 && !root.transfer
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
                        var cleaned = money_receiver.text.replace(/,/g, "");
                        myMenu.tranfer_money(num_receiver.text,cleaned, pincode_transfer.text);
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
                        root.select = 1
                        num_receiver.text = ""
                        money_receiver.text = ""
                        pincode_transfer.text = ""
                        myMenu.note_transfer = ""
                        root.transfer = false
                    }
                }
            }
            Label{
                anchors.horizontalCenter: transfer_page.horizontalCenter
                id: status_tranfer
                text: myMenu.note_transfer
                color: "black"
                height: 10
                width: 250
            }
        }
        Column{
            id: done_tranfer
            visible: select == 0 && root.transfer
            anchors.centerIn: page1
            spacing: 20
            Label{
                id: label_done_tranfer
                font.pointSize: 20
                text: myMenu.note_transfer
                color:"black"
                font.family: "Consolas"
                anchors.horizontalCenter: done_tranfer.horizontalCenter
            }
            Button{
                id: return_done_tranfer
                width: 120
                height: 30
                anchors.horizontalCenter: done_tranfer.horizontalCenter
                Text{
                    text: "Return"
                    color: 	"black"
                    font.family: "Consolas"
                    anchors.centerIn: return_done_tranfer
                    font.pointSize: 15
                }
                background: Rectangle{
                    color: return_done_tranfer.pressed ?"white":"#888888"
                    radius: 10
                }
                onClicked: {
                    root.select = 1
                    num_receiver.text = ""
                    money_receiver.text = ""
                    pincode_transfer.text = ""
                    myMenu.note_transfer = ""
                    root.transfer = false
                }
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
                            myMenu.send_money(1000000)
                            root.sent = true
                            root.select = 0
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
                            myMenu.send_money(2000000)
                            root.sent = true
                            root.select = 0
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
                            myMenu.send_money(5000000)
                            root.sent = true
                            root.select = 0
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
                            myMenu.send_money(10000000)
                            root.sent = true
                            root.select = 0
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
                            root.select = 1
                            root.sent = false
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
                    text: myMenu.send
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
                    root.select = 1
                    root.sent = false
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
                        key: "Oldest"
                    }
                    ListElement{
                        key: "Latest"
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
                        myMenu.user_his(0);
                    } else if (select_view.currentIndex === 1) {
                        myMenu.user_his(1);
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
                    clip: true
                    Repeater {
                        model: myMenu.his
                        Rectangle {
                            id: his_box
                            width: view_his.width
                            height: 30
                            color: "White"
                            border.color: "gray"
                            Text {
                                text: " "+(index + 1) + ". " + modelData
                                font.pixelSize: 14
                                wrapMode: Text.WordWrap
                                anchors.verticalCenter: his_box.verticalCenter
                                font.family: "Consolas"
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
                    root.select = 1
                }
            }
        }
    }


    //---------ADMIN------------------
    Rectangle{
        id: page2
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
                    root.isSign = false
                    console.log("LOG OUT")
                    pincode_old.text = ""
                    pincode_new1.text = ""
                    pincode_new2.text = ""
                    user_acc_num.text = ""
                    user_password.text = ""
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
                        root.select2 = 1
                        myMenu.user_list(0);
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
                        root.select2 = 2
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
                        root.select2 = 3
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
                        root.select2 = 4
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
                        root.select2 = 5
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
                        root.select2 = 6
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
                        key: "All"
                    }
                    ListElement{
                        key: "Oldest"
                    }
                    ListElement{
                        key: "Latest"
                    }
                }
                contentItem: Text{
                    text: select_view2.displayText
                    font.pointSize: 12
                    font.family: "Consolas"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "black"
                }
                onActivated: {
                    if (select_view2.currentIndex === 0) {
                        myMenu.user_list(0);
                    } else if (select_view2.currentIndex === 1) {
                        myMenu.user_list(1);
                    }else if (select_view2.currentIndex === 2) {
                        myMenu.user_list(2);
                    }
                }
            }

            ScrollView {
                id: view_user_list
                width: 650
                height: 220
                anchors.horizontalCenter: page_user_list.horizontalCenter
                contentHeight: columnn.height
                contentWidth: columnn.width
                Column{
                    id: columnn
                    width: view_user_list.width
                    clip: true
                    Repeater {
                        model: myMenu.list
                        Rectangle {
                            id: user_box
                            width: view_user_list.width
                            height: 30
                            color: "White"
                            border.color: "gray"
                            Text {
                                text: " "+(index + 1) + ". " + modelData
                                font.pixelSize: 14
                                wrapMode: Text.WordWrap
                                anchors.verticalCenter: user_box.verticalCenter
                                font.family: "Consolas"
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
                    root.select2 = 0
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
                        myMenu.add_new_user(name_user_add.text,acc_num_add.text,pass_add_1.text,pass_add_2.text);
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
                        root.select2 = 0
                        pass_add_1.text = ""
                        pass_add_2.text = ""
                        name_user_add.text = ""
                        acc_num_add.text = ""
                        myMenu.add_user = ""
                    }
                }
            }
            Label{
                anchors.horizontalCenter: page_add_user.horizontalCenter
                text: myMenu.add_user;
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
                        myMenu.delete_user(acc_num_dele.text,pass_delete_1.text);
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
                        root.select2 = 0
                        pass_delete_1.text = ""
                        acc_num_dele.text = ""
                        myMenu.add_user = ""
                    }
                }
            }
            Label{
                anchors.horizontalCenter: page_delete_user.horizontalCenter
                text: myMenu.add_user;
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
                        myMenu.search_user(acc_num_search.text);
                    }
                }
            }

            Label{
                id: label_search_infor
                anchors.horizontalCenter: page_search_user.horizontalCenter
                Text{
                    text: myMenu.user_infor
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
                    root.select2 = 0
                    acc_num_search.text = ""
                    myMenu.user_infor = ""
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
                    text: "Display user list"
                    color: "black"
                    font.pointSize: 18
                    font.family: "Consolas"
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
                            key: "Oldest"
                        }
                        ListElement{
                            key: "Latest"
                        }
                    }
                    contentItem: Text{
                        text: select_view3.displayText
                        font.pointSize: 12
                        font.family: "Consolas"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "black"
                    }
                    onActivated: {

                            if (select_view3.currentIndex === 0 )
                                myMenu.admin_his(2,acc_num_search_transfer.text);
                            if (select_view3.currentIndex === 1 )
                                myMenu.admin_his(0,acc_num_search_transfer.text);
                            if(select_view3.currentIndex === 2)
                                myMenu.admin_his(1,acc_num_search_transfer.text);

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
                        myMenu.admin_his(0,acc_num_search_transfer.text)
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
                    clip: true
                    Repeater {
                        model: myMenu.his
                        Rectangle {
                            id: transfer_box
                            width: view_transfer_list.width
                            height: 30
                            color: "White"
                            border.color: "gray"
                            Text {
                                text: " "+(index + 1) + ". " + modelData
                                font.pixelSize: 14
                                wrapMode: Text.WordWrap
                                anchors.verticalCenter: transfer_box.verticalCenter
                                font.family: "Consolas"
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
                    root.select2 = 0
                    myMenu.his = ""
                    acc_num_search_transfer.text = ""
                }
            }
        }

    }
}


