package;

import openfl.events.Event;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;
import utils.Performance;

/**
 * ...
 * @author Killabunnies
 */
class Main extends Sprite {

	static public var myPerspective:Sprite = new Sprite();
	static public var stageWidth:Int=0;
	static public var stageHeight:Int=0;
	
	public function new() {
		super();
		
		stageWidth = stage.stageWidth;
		stageHeight = stage.stageHeight;
		
		var myGrass:Sprite = new Sprite();
		myGrass.graphics.beginBitmapFill(Assets.getBitmapData("img/grass.png"), null, true, true);
		myGrass.graphics.drawRect(0, 0, stage.stageWidth, Math.floor(stage.stageHeight / 3));
		myGrass.graphics.endFill();
		
		addChild(myGrass);
		myGrass.y = stage.stageHeight - myGrass.height;
		
		myPerspective.graphics.beginFill(0xFF0000);
		myPerspective.graphics.drawCircle(0, 0, 10);
		myPerspective.graphics.endFill();
		myPerspective.x = stage.stageWidth / 2;
		myPerspective.y = stage.stageHeight / 2;
		
		addChild(myPerspective);
		
		var tileRoad:TileRoad = new TileRoad(stage.stageWidth, stage.stageHeight);
		tileRoad.x = tileRoad.y = 0;
		addChild(tileRoad);
		stage.addEventListener(MouseEvent.CLICK, tileRoad.addSegment);
				
		var myPerf:Performance = new Performance();
		myPerf.scaleX = myPerf.scaleY = 4;
		addChild(myPerf);
		
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseMove);
	}
	
	function onMouseMove(E:MouseEvent){
		myPerspective.y = E.stageY;
		myPerspective.x = E.stageX;
	}
}
