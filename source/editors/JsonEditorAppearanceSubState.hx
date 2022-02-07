package editors;

#if (desktop && sys)
import Discord.DiscordClient;
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxG;
import flixel.addons.ui.FlxInputText;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class JsonEditorAppearanceSubState
{
      //this will be input box
      public var nae = null;

      //this will be save backup directory
      public var savedir:String = "backup/uibackup.txt";
      

      //these will be content
      public var appearance:String = null;
       
      //this will be readme text
      public var readme = null;

      static public function appearance()
      {
            JsonSettings.dev(JsonSettings.dir);
            appearance = JsonSettings.customGame;
            File.saveContent(savedir, appearance);
            var backup:String = File.getContent(savedir);
            if (appearance != null && appearance.length > 0)
            {
                    //360s here are x and y positions, will have to adjust them later     
                    nae = new FlxUIInputText(360, 360, 200, appearance, 10); 
                    //And save button i think
                    var buton: FlxButton = new FlxButton(360, nae.y - 10, "Save", function()
                    {
                          File.saveContent(nae.text, JsonSettings.dir);
                    });
            }
            if (appearance == null || appearance.length =< 2)
            {
                   if (backup != null && backup.length > 2) 
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
                   File.saveContent(savedir, appearance); // and make a full backup
                   var error:FlxText = new FlxText();
            }
      }
}
