import themidibus.*;

MidiBus myBus;    // MidiBusインスタンス

void setup() {
    size(300, 300);    //ウインドウのサイズ
    background(255);   //ウインドウ背景の色

    MidiBus.list();                     //MIDIデバイスのリストを表示
    myBus = new MidiBus(this, 0, 1);    //MIDIデバイスのinput,outputを指定
}

float x = 150;    //図形の基準位置x
float y = 150;    //図形の基準位置y
int r = 180;      //図形の半径

void draw(){       
    background(255);        //背景塗りつぶし（図形を削除する目的）
    stroke(0, 0, 0);        //図形の描画線に色を付ける
    ellipse(x, y, r, r);    //円の描画（x座標, y座標, 幅, 高さ）
}

void controllerChange(int channel, int number, int value){

    if(number == 20){      
      x = map(value,0,127,0,width);
    }else{
      y = map(value,0,127,0,width);
    }

    //動かしたコントロールの値を表示
    println("channel:" + channel + " number:" + number +" value:"+ value);
}