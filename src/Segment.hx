package;

import openfl.events.Event;
import openfl.Vector;
import openfl.geom.Point;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Killabunnies
 */
class Segment extends Sprite{

	private var graphicBMD:BitmapData = openfl.Assets.getBitmapData("img/segment.png");
	private var rectangles:Vector<Float>;
	private var indexes:Vector<Int>;
	private var transforms:Vector<Float>;
	
	public function new() {
		super();
		
		rectangles = new Vector<Float>(graphicBMD.height * 4);
		indexes = new Vector<Int>(graphicBMD.height);
		transforms = new Vector<Float>(graphicBMD.height * 6);
		addEventListener(Event.ENTER_FRAME, customDraw);
	}
	
	private function customDraw(E:Event) {
		for(j in 0...graphicBMD.height){
			var scaleMatrix:Matrix = new Matrix();
			scaleMatrix.scale(1 - .5 * (1 - j / graphicBMD.width), 1);
			var translateMatrix:Matrix = new Matrix();
			translateMatrix.translate((1 - j/graphicBMD.width)*(graphicBMD.width/4),j);
			scaleMatrix.concat(translateMatrix);
			
			
			rectangles[j * 4] = 0;
			rectangles[j * 4 + 1] = j;
			rectangles[j * 4 + 2] = graphicBMD.width;
			rectangles[j * 4 + 3] = 1;
			
			indexes[j] = j;
			
			transforms[j * 6] = scaleMatrix.a;
			transforms[j * 6 + 1] = scaleMatrix.b;
			transforms[j * 6 + 2] = scaleMatrix.c;
			transforms[j * 6 + 3] = scaleMatrix.d;
			transforms[j * 6 + 4] = scaleMatrix.tx;
			transforms[j * 6 + 5] = scaleMatrix.ty;
		
			
		}
		//this.graphics.drawQuads(graphicBMD, scaleMatrix, null, null, new Rectangle(0, j, graphicBMD.width, j + 1), false);
		this.graphics.clear();
		this.graphics.beginBitmapFill(openfl.Assets.getBitmapData("img/segment.png"));
		this.graphics.drawQuads(rectangles, indexes, transforms);
		//this.graphics.drawQuads(rectangles);
		this.graphics.endFill();
	}
}