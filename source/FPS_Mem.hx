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

		//will make this crap better in the future, rn it sucks.
		if (visible)
		{
			//1 counter
			text = "FPS: " + times.length; //FPS Only

			if(ClientPrefs.memCounter && !ClientPrefs.memPeak && !ClientPrefs.showFPS) //Mem Only
				text = "MEM: " + mem + " MB";

			if(ClientPrefs.memPeak && !ClientPrefs.memCounter && !ClientPrefs.showState && !ClientPrefs.showFPS) //Peak Only
                text = "MEM peak: " + memPeak;

			if(ClientPrefs.showState && !ClientPrefs.showFPS && !ClientPrefs.memCounter && !ClientPrefs.memPeak) //State Only
                text = "State: " + Main.curStateS;

			
			//2 counters
			if(ClientPrefs.showFPS && ClientPrefs.memCounter && !ClientPrefs.memPeak && !ClientPrefs.showState) //FPS and Mem
				text = "FPS: " + times.length + "\nMEM: " + mem + " MB";

			if(ClientPrefs.showFPS && !ClientPrefs.memCounter && ClientPrefs.memPeak && !ClientPrefs.showState) //FPS and Mem
				text = "FPS: " + times.length + "\nMEM peak: " + memPeak + " MB";

			if(ClientPrefs.memCounter && ClientPrefs.memPeak && !ClientPrefs.showFPS) //Mem and Peak
				text = "MEM: " + mem + " MB\nMEM peak: " + memPeak + " MB";

            if(ClientPrefs.showState && ClientPrefs.showFPS && !ClientPrefs.memCounter && !ClientPrefs.memPeak) //FPS and State
                text = "FPS: " + times.length + "\nState: " + Main.curStateS;

			if(ClientPrefs.showState && !ClientPrefs.showFPS && ClientPrefs.memCounter && !ClientPrefs.memPeak) //Mem and State
                text = "MEM: " + mem + " MB " + "\nState: " + Main.curStateS;

			if(ClientPrefs.showState && !ClientPrefs.showFPS && !ClientPrefs.memCounter && ClientPrefs.memPeak) //Peak and State
                text = "MEM peak: " + memPeak + "\nState: " + Main.curStateS;

			//3 counters
			if(ClientPrefs.showState && ClientPrefs.showFPS && ClientPrefs.memCounter && !ClientPrefs.memPeak) //FPS, Mem, and State
				text = "FPS: " + times.length + "\nMEM: " + mem + " MB" + "\nState: " + Main.curStateS;

			if(ClientPrefs.showState && ClientPrefs.showFPS && !ClientPrefs.memCounter && ClientPrefs.memPeak) //FPS, Peak, and State
				text = "FPS: " + times.length + "\nMEM peak: " + memPeak + " MB" + "\nState: " + Main.curStateS;

			//all
            if(ClientPrefs.showState && ClientPrefs.showFPS && ClientPrefs.memCounter && ClientPrefs.memPeak) //FPS, Mem, Peak, and State
            text = "FPS: " + times.length + "\nMEM: " + mem + " MB\nMEM peak: " + memPeak + " MB" + "\nState: " + Main.curStateS;


			//all disabled
			if(!ClientPrefs.showFPS && !ClientPrefs.memCounter && !ClientPrefs.memPeak && !ClientPrefs.showState)
				text = "";
		}
	}
}