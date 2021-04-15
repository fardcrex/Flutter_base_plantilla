import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

class ApkDocModel {
  final String id;

  static const fieldCodeName = 'versionCode';
  final int versionCode;

  static const fieldRouteName = 'routeFile';
  final String routeFileStorage;

  static const fieldTimeName = 'timestamp';

  ApkDocModel(this.versionCode, this.id, this.routeFileStorage);
  ApkDocModel.empty() : this(-1, '', '');
  get notExist => versionCode == -1;
}

enum StateVersion { newVersionAvailable, apkDownloaded, versionUpdated, downloadFailed, downloadPaused }

class AlertAppUpdate extends StatefulWidget {
  AlertAppUpdate({Key key, this.uidDevice}) : super(key: key);
  final String uidDevice;
  @override
  _AlertAppUpdateState createState() => _AlertAppUpdateState();
}

class _AlertAppUpdateState extends State<AlertAppUpdate> {
  ///===================  Se altera en cada versión nueva ===================
  ///
  static const versionCodeApp = 1;
  static const versionName = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApkDocModel>(
        stream: streamApk,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return getAlertDialog();
          final ApkDocModel apkDocModel = snapshot.data;
          if (apkDocModel.notExist) {
            return getAlertDialog(noExistDoc: true);
          }
          return StreamBuilder<bool>(
              stream: getStreamApkUser(widget.uidDevice, apkDocModel.id),
              builder: (context, apkIsAvailable) {
                if (!apkIsAvailable.hasData) {
                  return getAlertDialog();
                }
                _updateVersionState(apkDocModel, apkIsAvailable.data);
                return getAlertDialog(isLoadingData: false);
              });
        });
  }

  Widget getAlertDialog({bool isLoadingData = true, bool noExistDoc = false}) => WillPopScope(
        onWillPop: () async {
          if (isDownloadingApk) {
            _showToast(_messagingLoadingToast);
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: isLoadingData
            ? CupertinoAlertDialog(
                content: Center(
                  child: noExistDoc
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 40.0),
                          child: RaisedButton(
                            onPressed: () => createDocument(),
                            child: Text("Crear doc en Firestore"),
                          ),
                        )
                      : Container(
                          height: 35,
                          width: 35,
                          margin: const EdgeInsets.all(40.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(primary),
                          )),
                ),
              )
            : CupertinoAlertDialog(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Versión actual: $versionName'),
                ),
                content: bodyWidget,
                actions: [bottomLeft, bottomRight]),
      );

  final instance = FirebaseFirestore.instance;

  static const _collectionName = 'apk-versions';
  static const _collectionDevicesName = 'id-devices';

  Stream<ApkDocModel> get streamApk => instance
          .collection(_collectionName)
          .orderBy(ApkDocModel.fieldTimeName, descending: true)
          .limit(1)
          .snapshots()
          .map((event) {
        if (event.docs.isEmpty) return ApkDocModel.empty();
        final map = event.docs.first.data();
        try {
          return ApkDocModel(
            map[ApkDocModel.fieldCodeName] ?? -1,
            event.docs.first.id,
            map[ApkDocModel.fieldRouteName] ?? '',
          );
        } catch (e) {
          return ApkDocModel.empty();
        }
      });

  Stream<bool> getStreamApkUser(slug, idApk) => instance
      .collection(_collectionName)
      .doc(idApk)
      .collection(_collectionDevicesName)
      .doc(slug)
      .snapshots()
      .map((event) => !event.exists);

  createDocument() {
    instance.collection(_collectionName).add({
      ApkDocModel.fieldTimeName: DateTime.now(),
      ApkDocModel.fieldCodeName: versionCodeApp,
      ApkDocModel.fieldRouteName: 'apk_versions/$versionCodeApp/$fileName',
    });
  }

  _updateVersionState(ApkDocModel apkDocModel, bool apkIsAvailable) {
    apkData = apkDocModel;

    if (task?.snapshot?.state == TaskState.canceled || task?.snapshot?.state == TaskState.error)
      return stateVersion = StateVersion.downloadFailed;
    if (task?.snapshot?.state == TaskState.paused) return stateVersion = StateVersion.downloadPaused;
    stateVersion = apkIsAvailable
        ? StateVersion.newVersionAvailable
        : apkDocModel.versionCode == versionCodeApp
            ? StateVersion.versionUpdated
            : StateVersion.apkDownloaded;
  }

  StateVersion stateVersion = StateVersion.versionUpdated;
  bool isDownloadingApk = false;
  double _percentage = 0.0;

  ApkDocModel apkData;

  static final _messagingLoadingToast = 'Espere la descarga';
  String _messagingLoading = 'Pausado';
  String _messagingFailed = 'Descarga Fallida';

  static final primary = Color(0xff4F7BE3);
  static final grey = Colors.grey[500];
  static final green = Colors.greenAccent[700];
  static final red = Colors.deepOrangeAccent[400];

  get bodyWidget {
    if (isDownloadingApk)
      return Column(
        children: [
          FittedBox(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: 110, child: Text(_messagingLoading, textAlign: TextAlign.start)),
              SizedBox(width: 50, child: Text('${_percentage.floor()} %', textAlign: TextAlign.end)),
            ]),
          ),
          Container(
              width: 163,
              margin: EdgeInsets.only(top: 10),
              child: LinearProgressIndicator(
                value: _percentage / 100,
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ))
        ],
      );
    final map = {
      StateVersion.newVersionAvailable: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Nueva versión disponible: '),
        SizedBox(width: 5),
        Icon(Icons.android_outlined, color: green, size: 25),
      ]),
      StateVersion.versionUpdated: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('App actualizada'),
        SizedBox(width: 10),
        Icon(Icons.check_circle_outline, color: primary, size: 25),
      ]),
      StateVersion.apkDownloaded: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Apk listo para instalar'),
        SizedBox(width: 5),
        Icon(Icons.download_done_outlined, color: green, size: 25),
      ]),
      StateVersion.downloadFailed: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(_messagingFailed),
        SizedBox(width: 10),
        Icon(Icons.warning_amber_outlined, color: red, size: 25),
      ]),
    };
    return map[stateVersion];
  }

  get bottomRight {
    if (isDownloadingApk && stateVersion != StateVersion.downloadPaused)
      return FlatButton(
        onPressed: () async {
          await task.pause();
          _messagingLoading = 'Pausado';
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Pause "),
          Icon(Icons.pause, color: primary),
        ]),
      );
    final map = {
      StateVersion.downloadPaused: FlatButton(
        onPressed: () async {
          await task.resume();
          _messagingLoading = 'Descargando';
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Continue "),
          Icon(Icons.play_arrow, color: primary),
        ]),
      ),
      StateVersion.downloadFailed: FlatButton(
        onPressed: () => downloadApk(),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Retry "),
          Icon(Icons.replay_rounded, color: isDownloadingApk ? grey : green),
        ]),
      ),
      StateVersion.newVersionAvailable: FlatButton(
        onPressed: () => downloadApk(),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Download "),
          Icon(Icons.download_rounded, color: isDownloadingApk ? grey : green),
        ]),
      ),
      StateVersion.versionUpdated: FlatButton(
        onPressed: () => _showToast('No hay nuevas vesiones disponibles'),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Download ", style: TextStyle(color: grey)),
          Icon(Icons.download_rounded, color: grey),
        ]),
      ),
      StateVersion.apkDownloaded: FlatButton(
        onPressed: () async {
          Directory appDocDir = await getApplicationDocumentsDirectory();
          File downloadToFile = File('${appDocDir.path}/$fileName');
          OpenFile.open(downloadToFile.path, type: "application/vnd.android.package-archive");
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Install "),
          Icon(Icons.android, color: green),
        ]),
      ),
    };
    return map[stateVersion];
  }

  DownloadTask task;
  static final fileName = 'app-release.apk';

  void downloadApk() async {
    if (this.isDownloadingApk) {
      _showToast(_messagingLoadingToast);
      return;
    }
    assert(this.apkData != null);

    setState(() => {this.isDownloadingApk = true});

    Directory appDocDir = await getApplicationDocumentsDirectory();
    // await Future.delayed(Duration(seconds: 10));
    File downloadToFile = File('${appDocDir.path}/$fileName');

    task = FirebaseStorage.instance.ref(apkData.routeFileStorage).writeToFile(downloadToFile);
    task.snapshotEvents.listen(
      (event) async {
        var percentage = (event.bytesTransferred / event.totalBytes) * 100;
        percentage = percentage <= 100 ? percentage : percentage - 30;
        this._percentage = percentage <= 100 ? percentage : 100.0;
        setState(() {});
        event.state;
        if (event.state == TaskState.success) {
          setState(() => {this.isDownloadingApk = false});
          await instance
              .collection(_collectionName)
              .doc(this.apkData.id)
              .collection(_collectionDevicesName)
              .doc(widget.uidDevice)
              .set({});
        }
      },
      onError: (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        print(task.snapshot);

        if (e?.code == 'canceled') _messagingFailed = 'Descarga cancelada';

        if (e?.code == 'object-not-found') _messagingFailed = 'Apk removido';

        if (e?.code == 'permission-denied') _messagingFailed = 'No tienes permisos';

        setState(() => {this.isDownloadingApk = false});
      },
      onDone: () => print('onDone'),
    );
  }

  get bottomLeft => isDownloadingApk
      ? FlatButton(
          onPressed: () => task.cancel(),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Cancel "),
            Icon(Icons.block, color: red, size: 20),
          ]),
        )
      : stateVersion == StateVersion.newVersionAvailable || stateVersion == StateVersion.downloadFailed
          ? FlatButton(
              onPressed: () => _showToast('Descargue la nueva versión antes'),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Share ", style: TextStyle(color: grey)),
                Icon(Icons.share, color: grey, size: 20),
              ]),
            )
          : FlatButton(
              onPressed: () => shareFile(),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Share "),
                Icon(Icons.share, color: primary, size: 20),
              ]),
            );

  _showToast(String message) {
    Toast.show(message, context, duration: 3, gravity: Toast.BOTTOM);
  }

  shareFile() async {
    if (this.isDownloadingApk) {
      _showToast(_messagingLoadingToast);
      return;
    }
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File file = File('${appDocDir.path}/$fileName');
    final data = await file.readAsBytes();
    await Share.file("Compartir apk versión $versionName", fileName, data, 'application/vnd.android.package-archive');
  }
}
