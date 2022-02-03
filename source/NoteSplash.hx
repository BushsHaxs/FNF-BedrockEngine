package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = null;
	public var dir:String = "settings/uiSettings.json";
	public var noteSplashSkin:String;
	private var idleAnim:String;
	private var textureLoaded:String = null;


	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0, dir:String) {
		super(x, y);

		if(FileSystem.exists(dir))
			{
				var customJson:String = File.getContent(dir);
				if (customJson != null && customJson.length > 0)
				{
					var shit:Dynamic = Json.parse(customJson);
					var noteSplashSkin:String = Reflect.getProperty(shit, "noteSplashSkin");

					if (noteSplashSkin != null && noteSplashSkin.length > 0)
						this.noteSplashSkin = noteSplashSkin;
					else 
						this.noteSplashSkin = 'noteSplashes';
					
				}
			}

		var skin:String = noteSplashSkin;
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;

		loadAnims(skin);
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		setupNoteSplash(x, y, note);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0, dir:String) {
		
		if(FileSystem.exists(dir))
			{
				var customJson:String = File.getContent(dir);
				if (customJson != null && customJson.length > 0)
				{
					var shit:Dynamic = Json.parse(customJson);
					var noteSplashSkin:String = Reflect.getProperty(shit, "noteSplashSkin");

					if (noteSplashSkin != null && noteSplashSkin.length > 0)
						this.noteSplashSkin = noteSplashSkin;
					else 
						this.noteSplashSkin = 'noteSplashes';
					
				}
			}
		
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = 0.6;

		if(texture == null) {
			texture = noteSplashSkin;
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;

			if(PlayState.isPixelStage) {
				texture = 'pixelUI/'+noteSplashSkin;
				if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = 'pixelUI/' + PlayState.SONG.splashSkin;
				if(animation.curAnim != null)animation.curAnim.frameRate = 12;
			}
		}

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		colorSwap.hue = hueColor;
		colorSwap.saturation = satColor;
		colorSwap.brightness = brtColor;
		offset.set(10, 10);

		var animNum:Int = FlxG.random.int(1, 2);
		animation.play('note' + note + '-' + animNum, true);
		if(animation.curAnim != null)animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		for (i in 1...3) {
			animation.addByPrefix("note1-" + i, "note splash blue " + i, 24, false);
			animation.addByPrefix("note2-" + i, "note splash green " + i, 24, false);
			animation.addByPrefix("note0-" + i, "note splash purple " + i, 24, false);
			animation.addByPrefix("note3-" + i, "note splash red " + i, 24, false);
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}