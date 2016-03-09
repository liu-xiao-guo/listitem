import QtQuick 2.0
import Ubuntu.Components 1.2
import Ubuntu.Components.ListItems 1.0 as ListItems

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "listitem.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(60)
    height: units.gu(85)

    Page {
        title: i18n.tr("ListItem")
        clip:true


        Flickable {
            height: parent.height
            width: parent.width
            contentHeight: content.childrenRect.height

            Column {
                id: content
                anchors.fill: parent

                ListItems.Standard {
                    text: "Selectable standard list item"
                    selected: false
                    onClicked: selected = !selected
                }
                ListItems.Standard {
                    text: "List item with icon"
                    iconName: "compose"
                }
                ListItems.Standard {
                    text: "With a progression arrow"
                    progression: true
                }
                ListItems.Standard {
                    text: "Control"
                    control: Button {
                        text: "Click me"
                        width: units.gu(19)
                        onClicked: print("Clicked")
                    }
                    progression: true
                }

                ListItem {
                    id: listItem
                    height: 200
                    Row {
                        spacing: 20
                        Image {
                            width: 200
                            height: 200
                            source: "images/pic1.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }

                        Button {
                            text: "Press me"
                            onClicked: {
                                console.log("Button is clicked");
                                listItem.destroy();
                            }
                        }
                    }
                    onClicked: console.log("clicked on ListItem")
                }

                ListItem {
                    leadingActions: ListItemActions {
                        actions: [
                            Action {
                                iconName: "delete"
                                onTriggered: {
                                    console.log("delete is triggered");
                                }
                            }
                        ]
                    }

                    Label {
                        text: "LeadingAction"
                    }

                    onClicked: console.log("clicked on ListItem with leadingActions set")
                }
                ListItem {
                    trailingActions: ListItemActions {
                        actions: [
                            Action {
                                iconName: "edit"

                                onTriggered: {
                                    console.log("edit is triggered!");
                                }
                            }
                        ]
                    }

                    Label {
                        text: "TrailingActions"
                    }

                    onClicked: console.log("clicked on ListItem with trailingActions set")
                }
                ListItem {
                    Label {
                        text: "onClicked implemented"
                    }
                    onClicked: console.log("clicked on ListItem with onClicked implemented")
                }
                ListItem {
                    Label {
                        text: "onPressAndHold implemented"
                    }
                    onPressAndHold: console.log("long-pressed on ListItem with onPressAndHold implemented")
                }
                ListItem {
                    Label {
                        text: "No highlight"
                    }

                    onClicked: console.log("clicked on No highlight");
                }


                ListView {
                    clip: true
                    width: parent.width
                    height: units.gu(50)

                    model: ListModel {
                        Component.onCompleted: {
                            for (var i = 0; i < 100; i++) {
                                append({tag: "List item #"+i});
                            }
                        }
                    }

                    delegate: ListItem {
                        Label {
                            text: modelData
                        }
                        color: dragMode ? "lightblue" : "lightgray"
                        onPressAndHold: ListView.view.ViewItems.dragMode =
                                        !ListView.view.ViewItems.dragMode
                    }
                    ViewItems.onDragUpdated: {
                        if (event.status == ListItemDrag.Moving) {
                            model.move(event.from, event.to, 1);
                        }
                    }
                    moveDisplaced: Transition {
                        UbuntuNumberAnimation {
                            property: "y"
                        }
                    }
                }
            }

        }

    }
}

