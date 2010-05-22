package NAMESPACE;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;

class MAIN extends Sprite {
	
	private var mc:Sprite;
	private var txt:TextField;
	private var tf:TextFormat;

	static function main() {
		//weird little workaround.... template boilerplate
		var app:MAIN = new MAIN();
		flash.Lib.current.addChild(app);
		app.init();
	}

	function init() {
		mc = new Sprite();
		mc.x = flash.Lib.current.stage.stageWidth/2;
		mc.y = flash.Lib.current.stage.stageHeight/2;
		txt = new TextField();
		txt.text = "haXe";
		tf = new TextFormat();
		txt.x = -150;
		txt.y = -100;
		tf.color = 0xFF0000;
		tf.size = 450;
		txt.width = 350;
		txt.height = 220;
		tf.font = "Arial";
		tf.bold = true;
		txt.setTextFormat(tf);
		mc.addChild(txt);
		addChild(mc);
		stage.addEventListener( Event.ENTER_FRAME, render);
	}

	function render(event:Event) {
		/*trace("foo");*/
		mc.rotationY += 1;
	}
}
