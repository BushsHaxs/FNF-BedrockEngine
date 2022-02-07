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

      //these will be content
      public var appearance:String = null;
       
      //this will be readme text
      public var readme = null;

      static public function appearance()
      {
           JsonSettings.dev(JsonSettings.dir);
           appearance = JsonSettings.customGame;

           //360s here are x and y positions, will have to adjust them later     
           nae = new FlxUIInputText(360, 360, 200, appearance, 10); 
           //And save button i think
           var buton: FlxButton = new FlxButton(360, nae.y - 10, "Save", function()
           {
                 File.saveContent(nae.text, appearance);
           });
      }
}
