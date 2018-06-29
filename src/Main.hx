package;

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
	static public var stageWidth:Int=0;
	static public var stageHeight:Int=0;
	static public var current:Main;
	
	private var tileRoad:TileRoad; 
	public function new() {
		super();
		current = this;
		stageWidth = stage.stageWidth;
		stageHeight = stage.stageHeight;
		
		
		//var myY = Main.myPerspective.y / Main.myPerspective.z + Main.myHorizon;
		
		var myGrass:Sprite = new Sprite();
		myGrass.graphics.beginBitmapFill(Assets.getBitmapData("img/grass.png"), null, true, true);
		myGrass.graphics.drawRect(0, 0, stage.stageWidth, Math.floor(stage.stageHeight / 3));
		myGrass.graphics.endFill();
		
		addChild(myGrass);
		
		
		myPerspective.x = stage.stageWidth / 2;
		myPerspective.y = stage.stageHeight / 2;
		myPerspective.z = -300000;
		
		myGrass.y = myPerspective.y;
		
		tileRoad = new TileRoad(stage.stageWidth, stage.stageHeight);
		tileRoad.x = tileRoad.y = 0;
		addChild(tileRoad);
				
		var myPerf:Performance = new Performance();
		myPerf.scaleX = myPerf.scaleY = 4;
		addChild(myPerf);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	
	function onKeyDown(E:KeyboardEvent){
		if(E.keyCode==39){
			TileRoad.currentX += 5;
		}else if(E.keyCode==37){
			TileRoad.currentX -= 5;
		}
	}
}
