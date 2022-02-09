package;

import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flixel.FlxG;
import openfl.events.EventType;
import openfl.display.DisplayObject;
import haxe.Timer;
import openfl.display.FPS;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class DisplayCounters extends TextField
{
	private var times:Array<Float>;
	private var memPeak:Float = 0;

	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000)
	{
		super();
		x = inX;
		y = inY;
		selectable = false;
		defaultTextFormat = new TextFormat("VCR OSD Mono", 16, inCol);
		text = "FPS: \nState: \nMemory:";
		times = [];
		addEventListener(Event.ENTER_FRAME, onEnter);
		width = 1280;
		height = 720;
	}

	private function onEnter(_)
	{
		var now = Timer.stamp();
		times.push(now);
		while (times[0] < now - 1)
			times.shift();
		var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;
		if (mem > memPeak)
			memPeak = mem;

		//will make this crap better in the future, rn it sucks.
		if (visible)
		{
			text = "";

			if(ClientPrefs.showFPS)
				text += "FPS: " + times.length + "\n";

			if(ClientPrefs.showState)
                text += "State: " + Main.curStateS + "\n";

			if(ClientPrefs.memCounter)
				text += "Memory: " + mem + " mb" + "\n";

			if(ClientPrefs.memPeak)
                text += "Memory Peak: " + memPeak + " mb";
		}
	}
}