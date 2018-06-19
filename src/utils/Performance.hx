package utils;

import haxe.Timer;
import haxe.macro.Context;
import lime.app.Application;
import openfl.Lib;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

/**
 * Performance.hx
 * Haxe/OpenFL class to display memory usage.
 *
 * Mutilated from Simone Cingano code
 * 
 */

class Performance extends Sprite
{

    private var performanceText:TextField;
    private var appText:TextField;

    private var fpsHistory:Array<Int>;
    private static inline var fpsHistoryLen:Int=30;
    private var skipped = 0;
    private var skip = 10;
	private var times:Array<Float>;

	private var padding:Int = 5;
	private var paddingY:Int = 3;

	public var graphBarTickness = 2;
	public var graphBarPadding = 1;
	private var barHeight = 30;

	private var memPeak:Float = 0;

    private var graph:Shape;

    private var fullHeight:Int = 50;

	private var showGraph:Bool;
	var defines:String;
	var defineText:TextField;

	public function new(full:Bool = true ) 
	{
		super();
		mouseEnabled = false;
		mouseChildren = false;
		
    	performanceText = new TextField();
    	performanceText.y = paddingY;
    	//performanceText.width = 500;
		performanceText.selectable = false;
		performanceText.defaultTextFormat = new TextFormat("_sans", 8, 0xededed);
		performanceText.text = "FPS: 0\nMEM: 0 MB\nMPK: 0 MB\nCANVAS\nDATE";
		performanceText.autoSize= TextFieldAutoSize.LEFT;
		performanceText.embedFonts = true;
		addChild(performanceText);
		
		if (!full) {
			performanceText.text = "Build: " + getBuildDate() + " ("+Application.current.config.build+")";	
			return;
		}
		
		// Setup arrays
		fpsHistory = [];
		for (i in 0...fpsHistoryLen) fpsHistory.push(0);
		times = [];

		fullHeight = Std.int(performanceText.textHeight + paddingY*3);
		barHeight = Std.int(performanceText.textHeight)-paddingY;

		var nextX:Float = padding;

		graph = new Shape();
		graph.x = nextX;
		graph.y = paddingY * 2;
		addChild(graph);

		
		nextX = graph.x + (graphBarTickness+graphBarPadding)*(fpsHistoryLen-2) + graphBarTickness + padding;

		
    	performanceText.x = nextX;
		defines  = "";
		var tmpMap:Map<String,String> = getDefines();
		for (j in tmpMap.keys()) 
		{
			if (tmpMap.get(j).charAt(1) == tmpMap.get(j).charAt(3) && tmpMap.get(j).charAt(1) == ".") {
				defines += j + ": " + tmpMap.get(j) + "\n";
			};
		}
		defineText = new TextField();
    	defineText.y = paddingY;
		defineText.x = performanceText.x + performanceText.textWidth;
    	//performanceText.width = 500;
		defineText.selectable = false;
		defineText.defaultTextFormat = new TextFormat("_sans", 8, 0xededed);
		defineText.text = defines;
		defineText.autoSize= TextFieldAutoSize.LEFT;
		defineText.embedFonts = true;
		addChild(defineText);
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnter);
	}

	private function onEnter(_):Void
	{	
		var now = Timer.stamp();
		times.push(now);
		
		while (times[0] < now - 1)
			times.shift();

        if (skipped == skip) {
            skipped = 0;
            var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100)/100;
            if (mem > memPeak) memPeak = mem;
            
            if (visible)
            {	
            	drawGraph(times.length);
				
				performanceText.text = "FPS: " + times.length + "\nMEM: " + mem + " MB\nMEM peak: " + memPeak + " MB\nRender: " + stage.window.renderer.type + "\nBuild: "+getBuildDate();	
				defineText.x = performanceText.x + performanceText.textWidth + paddingY;	
			}
        }
        skipped++;
	}

	private function drawGraph(fps:Int):Void 
	{
		var color:Int;
		fpsHistory.push(fps);
        fpsHistory.shift();
        graph.graphics.clear();
        for (i in 0...fpsHistoryLen){
        	graph.graphics.moveTo(graphBarTickness*i+i*graphBarPadding,barHeight);
        	if (fpsHistory[i] > 55) color = 0x9fe198;
        	else if (fpsHistory[i] > 40) color = 0xefdea2;
        	else if (fpsHistory[i] > 30) color = 0xefbda2;
        	else color = 0xeda0a4;
        	graph.graphics.lineStyle(graphBarTickness, color, 0.5);
        	graph.graphics.lineTo(graphBarTickness*i+i*graphBarPadding,barHeight-barHeight*fpsHistory[i]/60);
        }
	}
	
	macro public static function getBuildDate() {
		var date = DateTools.format(Date.now(), "%Y%m%d");
		return Context.makeExpr(date, Context.currentPos());

    }
	
// Shorthand for retrieving a map of all defined compiler flags.
  static macro function getDefines() : haxe.macro.Expr {
    var defines : Map<String, String> = haxe.macro.Context.getDefines();
    // Construct map syntax so we can return it as an expression
    var map : Array<haxe.macro.Expr> = [];
    for (key in defines.keys()) {
      map.push(macro $v{key} => $v{Std.string(defines.get(key))});
    }
    return macro $a{map};
  }
}