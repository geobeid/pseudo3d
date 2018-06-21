package;

import openfl.display.Sprite;

/**
 * ...
 * @author Killabunnies
 */
class Road extends Sprite{

	private var segments:Array<Segment> = new Array<Segment>();
	private var posX:Float = 0;
	private var posY:Float = 0;
	
	public function new() {
		super();
		for (i in 0...30)
		{
			var auxSegment:Segment = new Segment();
			auxSegment.x = posX;
			auxSegment.y = posY;
			posY -= 40;
			addChild(auxSegment);
			segments.push(auxSegment);
		}
		
	}
	
}