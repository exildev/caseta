#include "validableapp.h"
#include <QDebug>
#include <QQmlProperty>
#include <QJsonDocument>
#include <QJsonObject>
#include <QApplication>
#include "qdpwin/qdpwin.h"
#include <QQuickItem>

int i = 0;
ValidableApp::ValidableApp(MainWindow *window)
{
    this->context = window->getView()->rootObject()->findChild<QObject*>("funcs");
    QObject::connect(this->context,SIGNAL(getValidable(QString)),this,SLOT(getValidable(QString)));
    this->server = ServerManager::getInstance();
    this->data = NULL;
    this->qdp = QDPWin::getInstance();
    this->qdp->init();
    this->qdp->configure(window, this);
}

ValidableApp::ValidableApp(){
    this->server = ServerManager::getInstance();
    this->data = NULL;
}

ValidableApp::~ValidableApp()
{
    delete this->qdp;
}

void ValidableApp::onCapture(FT_BYTE * template_data, int len){
    qDebug() << len;
}

bool ValidableApp::validTemplate(int validable){
    QHash<QString, QString> *data = new QHash<QString, QString>();
    data->insert("validable",QString::number(validable));
    this->sendPeticion("http://104.236.33.228:9009/asistencia/template/valid/", data, true);
    if(this->data->getStatus() == 200){
        return true;
    }else{
        return false;
    }
}

void ValidableApp::getValidable(QString identificacion){
    QHash<QString, QString> *data = new QHash<QString, QString>();
    data->insert("identificacion",identificacion);
    this->sendPeticion("http://104.236.33.228:9009/asistencia/validable.json?", data, false);
    if(this->data->getStatus() == 200){
        QJsonObject json = QJsonDocument::fromJson(this->data->getResponse().toUtf8()).object();
        QVariant returnedValue;
        QVariant list= json.toVariantMap();
        QMetaObject::invokeMethod(this->context,"renderValidables",
                                  Q_RETURN_ARG(QVariant,returnedValue),
                                  Q_ARG(QVariant,list));
    }else{
        qDebug() << this->data->getResponse();
    }
}
