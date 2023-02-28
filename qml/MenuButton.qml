import QtQuick 2.4


Image {
    id: playButton
    signal clicked //尝试把这个作为一个模版，其他相似的使用这个模版写
    //使用一个类来存储这两个图片源，为模块化做准备
    height: toolBar.height
    property string name;
    property string sourceReleased;
    property  string sourcePressed;
    MouseArea{
        id: mouse;
        anchors.fill: parent
        onPressed: playButton.source = sourcePressed
        onReleased: playButton.source = sourceReleased

        hoverEnabled: true
        onEntered: a.visible
        onExited: a.visible
    }
    Component.onCompleted: mouse.clicked.connect(clicked);
    Rectangle{
        id: a
        visible: false
        width: t.width
        height: t.height
        border.color: "black"
        border.width: 1
        opacity: 0.8
        z:playButton.z + 2
        color: "#fbed90"
        Text {
            id: t
            text: qsTr(name)
        }
    }

}
