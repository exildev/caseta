import QtQuick 2.0
import QtQuick.Window 2.0

Rectangle{
    id:window
    width: 800
    height: 600
    Rectangle{
       id:inicio
       anchors.fill: parent
       color: "#D0DAD4"
       visible: false
       FocusScope{
           id:input
           width: 640
           height: 480
           anchors.centerIn: parent
           Keys.onPressed: {
               if(event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space){
                   console.log(funcs.texto)
                   funcs.getValidable(funcs.texto)
                   funcs.texto = ""
               }else{
                   funcs.texto += event.text
               }
           }
           focus:true
           Rectangle{
               id:header
               width: parent.width
               height: 70
               color: "#999"
               Text {
                   text: qsTr("SIGA LAS INSTRUCCIONES A CONTINUAIÓN")
                   anchors.centerIn: parent
                   font.pointSize: 20
               }
           }
           Rectangle{
               id:body
               width: parent.width
               anchors.top: header.bottom
               anchors.bottom: parent.bottom
               color:"#e1e1e1"
           }
       }
   }
    Rectangle {
        id:validable
        width: 800
        height: 600
        color: "#EEE"
        visible: true
        SystemPalette {id: syspal}
        FontLoader{id:roboto; source: "media/Roboto-Light.ttf"; name:"Roboto Thin"}
        FontLoader{id:icons; source: "media/icons.ttf"; name:"Material icons"}

        Rectangle{
            id:back
            width: 32
            height: 32
            color:"#e1e1e1"
            border.color: syspal.dark
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 3

            Image {
                source: "media/ic_arrow_back.svg"
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                anchors.margins: 1
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    validable.visible = false;
                    inicio.visible = true;
                    input.forceActiveFocus()
                }
            }
        }

        Rectangle{
            id:perfilContainer
            width: 640
            height: 300
            color:"#fff"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            Rectangle{
                id:foto
                height: parent.height
                width: 225
                color: parent.color
                Image {
                    id: profile
                    source: "media/profile.jpg"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 1
                }
                border.color: syspal.dark
            }
            Rectangle{
                id:info
                height: parent.height
                anchors.left: foto.right
                anchors.right: parent.right
                color: parent.color
                Rectangle{
                    id:nombre
                    color:parent.color
                    border.color: syspal.dark
                    width: parent.width - 10
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text{
                        id:nombreText
                        text:"Tori Black"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 20
                        font.family: roboto.name
                        anchors.left: parent.left
                        anchors.leftMargin: 4
                    }
                }

                Text {
                    id:cargo1
                    text: qsTr("Cargo: ")
                    anchors.top: nombre.bottom
                    anchors.topMargin: 15
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    font.pointSize: 18
                    font.family: roboto.name
                }
                Text {
                    id: cargo2
                    text: qsTr("Profesor")
                    anchors.top: nombre.bottom
                    anchors.topMargin: 15
                    anchors.left: cargo1.right
                    font.pointSize: 18
                    font.family: roboto.name
                }
            }
            Rectangle{
                id:huellaContainer
                width: 640
                height: 90
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: perfilContainer.bottom
                anchors.topMargin: 50
                color:"#fff"
                Rectangle{
                    id: huella
                    anchors.right: parent.right
                    height: parent.height
                    width: 0
                    border.color: syspal.dark
                    color: "#fff"
                    visible: false
                    Image {
                        source: "media/huella.png"
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                        anchors.margins: 2
                        opacity: 0.3
                    }
                }
                Rectangle{
                    id:mensaje
                    height: 90
                    color:"#e1e1e1"
                    border.color: syspal.dark
                    anchors.left: parent.left
                    anchors.right: huella.left

                    Text{
                        text: "Marcar salida"
                        anchors.centerIn: parent
                        font.pointSize: 27
                        font.family: roboto.name
                        anchors.left: parent.left
                        anchors.leftMargin: 4
                    }
                }
            }
        }
    }
    Item {
        id: funcs
        objectName: "funcs"
        property string texto: ""
        signal getValidable(string identificacion)
        function renderValidables(v){
            console.log(v.num_rows);
            if(v.num_rows > 0){
                var empleado = v.object_list[0];
                nombreText.text = empleado.nombre + " " + empleado.apellidos
                cargo2.text = empleado.cargo__nombre;
            }
            inicio.focus = false
            inicio.visible = false
            validable.visible = true
        }
    }
}
