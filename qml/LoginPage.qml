import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.jin.pagecontrol 1.0
Rectangle{
    anchors.centerIn: parent
    color: "#abcdef"
    opacity:0.8
    GridLayout{
        columns: 2
        anchors.fill: parent
        Text {
            id: nameText
            text: qsTr("Name")
        }
        TextField{
            id: nameInput
            text: qsTr("Input Name")
            onPressed: {
                if (nameInput.text == "Input Name"){
                    nameInput.text = "";
                }
            }

        }
        Text{
            id: passwordText
            text: qsTr("Password")
        }
        TextField{
            id: passwordInput
            text: qsTr("Password Input")
            onPressed: {
                if(passwordInput.text == "Password Input"){
                    passwordInput.text = "";
                }
            }
        }
        Button{
            id: loginButton
            text: "Login"
            onClicked: {
                pageController.loginPage = null;
            }
            GridLayout.leftMargin: 10
        }
    }



}
