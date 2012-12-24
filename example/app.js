// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

var tittalert = require('com.qnyp.tittalert');
Ti.API.info("module is => " + tittalert);

var container = Ti.UI.createView({
  width: Ti.UI.FILL,
  height: Ti.UI.SIZE,
  layout: 'vertical'
});

var button1 = Ti.UI.createButton({
  top: 10,
  width: Ti.UI.SIZE,
  height: Ti.UI.SIZE,
  title: 'single button alert'
});

var button2 = Ti.UI.createButton({
  top: 10,
  width: Ti.UI.SIZE,
  height: Ti.UI.SIZE,
  title: 'two button alert'
});

var button3 = Ti.UI.createButton({
  top: 10,
  width: Ti.UI.SIZE,
  height: Ti.UI.SIZE,
  title: 'three button alert'
});


button1.addEventListener('click', function(){
  ttalert = tittalert.createView({
    'title': 'single button alert',
    'message': 'Message',
    'cancelButtonTitle': 'キャンセル'
  });
  ttalert.addEventListener('click', function(e){
    Ti.API.debug('clicked');
    Ti.API.debug(e);
    alert(e);
  });
  ttalert.show();
});

button2.addEventListener('click', function(){
  ttalert = tittalert.createView({
    'title': 'This is Title',
    'message': 'Message',
    'cancelButtonTitle': 'キャンセル',
    'otherButtonTitle': 'OK'
  });
  ttalert.addEventListener('click', function(e){
    Ti.API.debug('clicked');
    Ti.API.debug(e);
    // Cancelボタンが押されたかどうか
    if(e.cancel){
      // cancel時の処理
      alert('cancel clicked');
    }
    // 選択されたボタンのindexも返る
    if(e.index == 1){
      // "OK"時の処理
      alert('ok clicked');
    }
    alert(e);
  });
  ttalert.show();
});

button3.addEventListener('click', function(){
  alert('3つ以上のボタンクリックには対応できていません');
});

container.add(button1);
container.add(button2);
container.add(button3);
win.add(container);
win.open();