package;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Lib;
import openfl.events.MouseEvent;
import utils.Performance;

/**
 * ...
 * @author Killabunnies
 */
class Main extends Sprite {

	static public var myPerspective:Point3D = new Point3D();
	static public var myHorizon:Float = 300;
	static public var stageWidth:Int=0;
	static public var stageHeight:Int=0;
	static public var current:Main;
	
	private var tileRoad:TileRoad; 
	private var myGround:TileRoad; 
	private var mySky:Sprite = new Sprite();
	
	public function new() {
		super();
		current = this;
		stageWidth = stage.stageWidth;
		stageHeight = stage.stageHeight;
		
		var myBitmapData:BitmapData = Assets.getBitmapData("img/sky.png");
        var myBitmap:Bitmap = new Bitmap (myBitmapData);
		mySky.addChild(myBitmap);
		addChild(mySky);
		
		myPerspective.x = stage.stageWidth / 2;
		myPerspective.y = (stage.stageHeight/ 5) *2;
		myPerspective.z = -30000;		
		
		myGround = new TileRoad(stage.stageWidth, stage.stageHeight,Assets.getBitmapData("img/grass.png"),3);
		myGround.x = 0;
		myGround.y = 0;
		addChild(myGround);
		
		tileRoad = new TileRoad(stage.stageWidth, stage.stageHeight, Assets.getBitmapData("img/segment.png"));
		tileRoad.x = tileRoad.y = 0;
		addChild(tileRoad);
				
		var myPerf:Performance = new Performance();
		addChild(myPerf);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	
	static public var dt:Float=0;
	private var lastTime:Float = 0;
	static public var speed:Float = 500;
	
	function update(E:Event) {
		dt = Lib.getTimer() - lastTime;
		lastTime+= dt;
		
		//if(dt>35){
			//dt=35;
		//}
		
		dt /= 1000;	
	}
	
	function onKeyDown(E:KeyboardEvent){
		if(E.keyCode==39){
			TileRoad.currentX += Math.floor(speed*dt*5);
		}else if(E.keyCode==37){
			TileRoad.currentX -= Math.floor(speed*dt*5);
		}
	}
}
