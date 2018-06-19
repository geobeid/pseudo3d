package;

import openfl.display.Sprite;
import openfl.Lib;
import utils.Performance;

/**
 * ...
 * @author Killabunnies
 */
class Main extends Sprite {

	public function new() {
		super();
		var myRoad:Road = new Road();
		myRoad.x = (myRoad.width / -2) + (stage.stageWidth / 2); 
		myRoad.y = stage.stageHeight-300;
		addChild(myRoad);
		//var myPerf:Performance = new Performance();
		//myPerf.scaleX = myPerf.scaleY = 4;
		//addChild(myPerf);
	}

}
