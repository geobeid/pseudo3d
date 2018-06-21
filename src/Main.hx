package;

import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;
import utils.Performance;

/**
 * ...
 * @author Killabunnies
 */
class Main extends Sprite {

	public function new() {
		super();
		
		/*
		var myRoad:Road = new Road();
		myRoad.x = (myRoad.width / -2) + (stage.stageWidth / 2); 
		myRoad.y = stage.stageHeight-300;
		addChild(myRoad);
		/*/
		var tileRoad:TileRoad = new TileRoad(1920, 1080);
		tileRoad.x = tileRoad.y = 0;
		addChild(tileRoad);
		stage.addEventListener(MouseEvent.CLICK, tileRoad.addSegment);
		//*/
		
		var myPerf:Performance = new Performance();
		myPerf.scaleX = myPerf.scaleY = 4;
		addChild(myPerf);
		
	}
}
