#ifndef VALIDABLEAPP_H
#define VALIDABLEAPP_H
#include "abratractapp.h"
#include "mainwindow.h"
#include "qdpwin/qdpwin.h"

class ValidableApp :public AbratractApp
{
    Q_OBJECT
private:
    QDPWin *qdp;
    bool sendValidable(int id,bool activo);
    bool validTemplate(int validable);
    DATA_BLOB* template_data;
public:
    ValidableApp(MainWindow *window);
    ValidableApp();
    ~ValidableApp();
public slots:
    void getValidable(QString identificacion);
    void onPush(int num){}
    void onVerify(bool){}
    void onComplete(DATA_BLOB* template_data){}
    void onCapture(FT_BYTE * template_data, int len);
};

#endif // VALIDABLEAPP_H
