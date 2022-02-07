/*package editors;

#if (desktop && sys)
import Discord.DiscordClient;
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxG;
import flixel.addons.ui.FlxUIInputText;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.FlxBasic;
import flixel.FlxState;


using StringTools;

class AppearanceEditorState extends MusicBeatState
{
      //this will be input box
      public var nae = null;

      //this will be save backup directory
      public var savedir:String = "backup/";
      
      //this is a bool
      public var coolBool:Bool;

      //this will be content
      public var appearance:String = null;
       
      //this will be readme text
      public var readme:String = null;

      override public function new()
      {
            var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

            if (FlxG.keys.justPressed.ESCAPE)
                   MusicBeatState.switchState(new ExtraMenuState());

             #if desktop
             DiscordClient.changePresence("In Appearance Menu", null);
             #end

            JsonSettings.dev(JsonSettings.dir);
            appearance = JsonSettings.customGame;
            readme = JsonSettings.read;
            File.saveContent(savedir, appearance);

            if (appearance.contains("iconSupport") && appearance.contains("judgementSkin"))
                  coolBool = true;
            else
                  coolBool = false;

            var backup:String = File.getContent(savedir);
            if (appearance != null && appearance.length > 0 && coolBool)
            {
                    //360s here are x and y positions, will have to adjust them later     
                    nae = new FlxUIInputText(360, 360, 200, appearance, 10); 
                    //And save button i think
                    var buton: FlxButton = new FlxButton(360, nae.y - 10, "Save", function()
                    {
                          File.saveContent(nae.text, JsonSettings.dir);
                    });

                    if (FlxG.keys.justPressed.S)
                        File.saveContent(nae.text, JsonSettings.dir);

                    if (FlxG.keys.justPressed.CONTROL && FlxG.keys.justPressed.S)
                        File.saveContent(nae.text, JsonSettings.dir);

            }
            if (appearance == null || appearance.length < 3 || !coolBool)
            {
                   if (backup != null && backup.length > 2 && coolBool) 
                       appearance = backup;
                    else
                    {
                    appearance = '{
	              "iconSupport":false,
	              "noteSkin": "NOTE_assets", 
	              "noteSplashSkin": "noteSplashes",
	              "judgementSkin": "bedrock"         
                    }';
                    } //create a dummy json and warn the player 

                  File.saveContent(JsonSettings.dir, appearance); //save them
                  File.saveContent(savedir + 'uiBackup.txt', appearance); // and make a full backup

                  var error:FlxText = new FlxText(240, 150, 25, "Something was wrong with appearance settings.
                  Created a json temporarily so you can fix them.", 10);
                  error.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                  error.scrollFactor.set();
		      error.borderSize = 1.25;
                  add(error);
                  
            }
            super();
      }
}
