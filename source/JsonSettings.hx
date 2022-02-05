package;

#if (desktop && sys)
import Discord.DiscordClient;
import sys.FileSystem;
import sys.io.File;
#end
import haxe.Json;

class JsonSettings

{

    public static var logs:Int = 0; 
    //this is used for log counts

    //offsets, will be used by conductor
    public static var marvOffsets:Float;
    public static var sickOffsets:Float;
    public static var goodOffsets:Float;
    public static var badOffsets:Float;

    //ui settings 
    public static var iconSupport:Bool;
    public static var noteSkin:String;
    public static var noteSplashSkin:String;
    public static var judgementSkin:String;

    //gameplay settings 
    public static var divider:String;
    public static var letterGrader:Bool;
	public static var antiMash:Bool;

    //json directories
    public static var dirtwo:String = "settings/gameplaySettings.json";
    public static var dir:String = "settings/uiSettings.json";
    public static var diroffset:String = "settings/offsets.json";
    #if MODS_ALLOWED
    public static var dirmod:String = "mods/settings/settings.json";
    public static var modoffset:String;
    #end

    public static function devtwo(dirtwo:String)
    {
        if (FileSystem.exists(dirtwo))
        {
            var customJson:String = File.getContent(dirtwo);
            if (customJson != null && customJson.length > 0)
            {
                logs++;

                var poop:Dynamic = Json.parse(customJson);
                var letterGraderTEMPLATE:Bool = Reflect.getProperty(poop, "letterGrader");
				var antiMashTEMPLATE:Bool = Reflect.getProperty(poop, "antiMash");
				var dividerTEMPLATE:String = Reflect.getProperty(poop, "divider");

                letterGrader = letterGraderTEMPLATE;
                antiMash = antiMashTEMPLATE;
                divider = dividerTEMPLATE;

               // trace(antiMash + divider + letterGrader);

                if (dividerTEMPLATE != null && dividerTEMPLATE.length > 6)
                {
                    if  (logs < 16)
                     trace("did you really think you could abuse dividers LMAO");
                    divider = ' ' +null+ ' ';
                }
            }
        }
    }

    public static function dev(dir:String)
    {
        if (FileSystem.exists(dir))
        {
            var customGame:String = File.getContent(dir);
            if (customGame != null && customGame.length > 0)
            {
                logs++;

                var shit:Dynamic = Json.parse(customGame);
                var iconSupportTEMPLATE:Bool = Reflect.getProperty(shit, "iconSupport");
				var judgementSkinTEMPLATE:String = Reflect.getProperty(shit, "judgementSkin");
				var noteSplashSkinTEMPLATE:String = Reflect.getProperty(shit, "noteSplashSkin");
                var noteSkinTEMPLATE:String = Reflect.getProperty(shit, "noteSkin");

                noteSkin = noteSkinTEMPLATE;
                noteSplashSkin = noteSplashSkinTEMPLATE;
                judgementSkin = judgementSkinTEMPLATE;
                iconSupport = iconSupportTEMPLATE;

                if (judgementSkinTEMPLATE == null || judgementSkinTEMPLATE.length < 0)
                {
                   if (logs < 11) 
                    trace("judgement skins are null, making them bedrock again.");
                   judgementSkin = 'bedrock';
                }

                if (noteSkinTEMPLATE == null || noteSkinTEMPLATE.length < 0)
                {
                    if (logs < 11)
                     trace("note skins are null, making them note_assets again.");
                    noteSkin = 'NOTE_assets';
                }

                if (noteSplashSkinTEMPLATE == null || noteSplashSkinTEMPLATE.length < 0)
                {
                    if (logs < 11)
                     trace("note splash skins are null, making them noteSplashes again.");
                    noteSplashSkin = 'noteSplashes';
                }
            }
        }
    }

    public static function devoffset(diroffset:String)
    {
        if (FileSystem.exists(diroffset))
        {
            var customOffsets:String = File.getContent(diroffset);
            if (customOffsets != null && customOffsets.length > 0)
            {

                //fuck you haxe i couldnt use =< or >= in here

                var offset:Dynamic = Json.parse(diroffset);
                var marvOffsetsTEMPLATE:Float = Reflect.getProperty(offset, "marvOffset");
                var sickOffsetsTEMPLATE:Float = Reflect.getProperty(offset, "sickOffset");
                var goodOffsetsTEMPLATE:Float = Reflect.getProperty(offset, "goodOffset");
                var badOffsetsTEMPLATE:Float = Reflect.getProperty(offset, "badOffset");

                if (marvOffsetsTEMPLATE > 2.49 && marvOffsetsTEMPLATE < 30.01)
                    marvOffsets = marvOffsetsTEMPLATE;
                else
                    marvOffsets = 25;

                if (sickOffsetsTEMPLATE > 14.99 && sickOffsetsTEMPLATE < 60.01)
                    sickOffsets = sickOffsetsTEMPLATE;
                else
                    marvOffsets = 45;

                if (goodOffsetsTEMPLATE > 29.99 && goodOffsetsTEMPLATE < 90.01)
                   goodOffsets = goodOffsetsTEMPLATE;
                else
                    marvOffsets = 90;

                if (badOffsetsTEMPLATE > 44.99 && badOffsetsTEMPLATE < 135.01)
                    badOffsets = badOffsetsTEMPLATE;
                else
                    marvOffsets = 135;
            }
        }
    }

    //use this on your mods and add your options 
    #if MODS_ALLOWED
    public static function devmod(dirmod:String)
    {
        if (FileSystem.exists(dir))
        {
            var customMod:String = File.getContent(dirmod);
            if (customMod != null)
            {
                logs++;

                trace("wow no mod options installed");
            }
        }
    }
    #end
}