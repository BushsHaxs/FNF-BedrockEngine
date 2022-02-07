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

class FPS_Mem extends TextField
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
		text = "FPS: ";
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
		if (visible)
		{
			//TODO: make this thing actually better

			text = "FPS: " + times.length; //FPS Text

			if(ClientPrefs.memCounter)
				text = "FPS: " + times.length + "\nMEM: " + mem + " MB\nMEM peak: " + memPeak + " MB";

			if(ClientPrefs.memCounter && !ClientPrefs.showFPS)
				text = "MEM: " + mem + " MB\nMEM peak: " + memPeak + " MB";

			if(!ClientPrefs.showFPS && !ClientPrefs.memCounter)
				text = "";

            /*if(ClientPrefs.showState && ClientPrefs.showFPS && !ClientPrefs.memCounter)
                text = "FPS: " + times.length + "\nState: " + Main.mainClassState;

            if(ClientPrefs.showState && ClientPrefs.showFPS && ClientPrefs.memCounter)
            text = "FPS: " + times.length + "\nMEM: " + mem + " MB\nMEM peak: " + memPeak + " MB" + "\nState: " + Main.mainClassState;

            if(ClientPrefs.showState && !ClientPrefs.showFPS && !ClientPrefs.memCounter)
                text = "State: " + Main.mainClassState;*/

            /* I will make it so states can be also shown later*/
		}
	}
}