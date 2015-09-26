import QtQuick 2.5
import QtQuick.Controls 1.4
Rectangle {
           id: listViewDelegate;
           color: index % 2 == 0 ? "orange" : "red";
           height: 24;
           states: [
               State {
                   name: "ADDED;";
                   PropertyChanges {
                       target: platformText;
                       readOnly: false;
                   }
               },
               State {
                   name: "SAVED";
                   PropertyChanges {
                       target: platformText;
                       readOnly: true;
                       focus: false;
                   }
               }
           ]

           onStateChanged: {
               if ( state === "ADDED" ) {
                   platformText.selectAll();
                   platformText.forceActiveFocus();
               }
           }

           anchors {
               left: parent.left;
               right: parent.right;
           }

           TextField {
               id: platformText;
               text: collectionName;
               readOnly: true;

               anchors {
                   verticalCenter: parent.verticalCenter;
                   left: parent.left;
                   leftMargin:  24;
               }

               onAccepted: {
                   collectionsModel.set( collectionID, platformText.text );
                   readOnly = true;
                   focus = false;
               }

               font {
                   pixelSize: PhxTheme.selectionArea.basePixelSize;
               }

               textColor: PhxTheme.common.baseFontColor;

           }

           Button {
               visible: collectionID !== 0;
               z: mouseArea.z + 1;
               anchors {
                   right: parent.right;
                   verticalCenter: parent.verticalCenter;
                   rightMargin: 12;
               }

               text: "Remove";

               onClicked: {
                   collectionsModel.remove( collectionID );
               }
           }

           MouseArea {
               id: mouseArea;
               anchors.fill: parent;
               enabled: platformText.readOnly;
               onClicked: {

                   if ( collectionID == 0 ) {
                       contentArea.contentLibraryModel.clearFilter( "collections", "collectionID" );
                   } else {
                       contentArea.contentLibraryModel.setFilter( "collections", "collectionID", collectionID );
                   }

               }
           }

       }

