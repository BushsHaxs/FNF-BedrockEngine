package editors;


#if (desktop && sys)
import Discord.DiscordClient;
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxG;
import flixel.addons.ui.FlxUICheckBox;
import flixel.FlxBasic;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUITabMenu;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

using StringTools;

//haxe may be outdated and stuff but seriously musicbeatstate fuck you
class JsonEditor extends MusicBeatState
{

      private var ididyourmom:Bool;
      public var savetext:String;
      public var savegtext:String;

      public var na:FlxUIInputText;
      public var ney:FlxUIInputText;
      public var neya:FlxUIInputText;
      public var coolInput:FlxUIInputText;

      //ui shit
      public var nae:FlxUIInputText;
      private var UI_characterbox:FlxUITabMenu;

      //gameplay shit
      public var anan:FlxUIInputText;
      public var gbutonum:FlxButton;

      //grabbing shit from JsonSettings.hx (gameplay)
      public var letterG:Bool;
      public var divide:String;
      public var mash:Bool;

      //grabbing shit from JsonSettings.hx (ui)
      public var icon:Bool;
      public var judgement:String;
      public var splash:String;
      public var note:String;

      //these will be save backup directory
      public var savedir:String = "backup/uiBackup.txt";
      public var backup:String;
      public var gsavedir:String = "backup/gameplayBackup.txt";
      public var gbackup:String;


      //these will be content
      public var appearance:String;
      public var gameplay:String;
       
      //this will be readme text
      public var readme:String = JsonSettings.read;

     override public function create()
      {
            var ctrltext:FlxText = new FlxText(0, 40, FlxG.width, "", 20);
            ctrltext.text = "";

            FlxG.mouse.useSystemCursor = true;
		FlxG.mouse.visible = true;


            var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.screenCenter();
		add(bg);

            var tabs = [
			{name: 'Appearance', label: 'Appearance'},
			{name: 'Gameplay', label: 'Gameplay'},
		];
		UI_characterbox = new FlxUITabMenu(null, tabs, true);

		UI_characterbox.resize(400, 400);
		UI_characterbox.x = FlxG.width - 835;
		UI_characterbox.y = 175;
		UI_characterbox.scrollFactor.set();
		add(UI_characterbox);

            JsonSettings.dev(JsonSettings.dir);

            if (FileSystem.exists("backup/") && !FileSystem.exists("backup/uiBackup.text") && !FileSystem.exists("backup/gameplayBackup.text"))
                  ididyourmom = true;
            else
                  ididyourmom = false;

            if (!FileSystem.exists("backup/"))
            {
                  Sys.command("mkdir -p backup/");
                  ididyourmom = false;
            }

            appearance = File.getContent(JsonSettings.dir);
            gameplay = File.getContent(JsonSettings.dirtwo);

            letterG = JsonSettings.letterGrader;
            divide = JsonSettings.divider;
            mash = JsonSettings.antiMash;

            note = JsonSettings.noteSkin;
            icon = JsonSettings.iconSupport;
            judgement = JsonSettings.judgementSkin;
            splash = JsonSettings.noteSplashSkin;

            backup = File.getContent(savedir);
            gbackup = File.getContent(gsavedir);

            var tab_group = new FlxUI(null, UI_characterbox);
		tab_group.name = "Appearance";

            var group_two = new FlxUI(null, UI_characterbox);
            group_two.name = "Gameplay";

            var nae = new FlxUICheckBox(20, 60, null, null, "300x150 icon support", 200);
		nae.checked = icon;
		nae.callback = function()
		{
                  icon = !icon;
                 // saveUISetting();
		};

            var oof = new FlxUICheckBox(20, 60, null, null, "Letter Grader", 200);
		oof.checked = letterG;
		oof.callback = function()
		{
                  letterG = !letterG;
		};

            var anti = new FlxUICheckBox(20, 100, null, null, "Antimash", 200);
		anti.checked = mash;
	      anti.callback = function()
		{
                  mash = !mash;
		};

            var coolButton = new FlxButton(FlxG.width - 855, 25, "Save UI", function()
            {
                  saveUISetting();
            });

            var coolButon = new FlxButton(FlxG.width - 855, 25, "Save Gameplay", function()
            {
                  saveGameplaySetting();
            });

            var coolText = new FlxText(20, 40);
            coolText.text = "Score divider:";

            var text = new FlxText(20, 80);
            text.text = "Note Skin:";
            var texttwo = new FlxText(20, 100);
            texttwo.text = "Splash Skin:";
            var textthree = new FlxText(15, 120);
            textthree.text = "Judgement Skin:";

            na = new FlxUIInputText(100, 80, 90, note, 8);
            ney = new FlxUIInputText(100, 100, 90, splash, 8);
            neya = new FlxUIInputText(100, 120, 90, judgement, 8);

            coolInput = new FlxUIInputText(100, 40, 90, divide, 8); 

		tab_group.add(text);
            tab_group.add(texttwo);
            tab_group.add(textthree);
            tab_group.add(nae);
            tab_group.add(na);
            tab_group.add(ney);
            tab_group.add(neya);
            tab_group.add(coolButton);
            UI_characterbox.addGroup(tab_group);

            group_two.add(coolText);
            group_two.add(coolButon);
            group_two.add(coolInput);
            group_two.add(oof);
            group_two.add(anti);
            UI_characterbox.addGroup(group_two);

            super.create();
      }

      override public function update(elapsed:Float)
      {
            JsonSettings.dev(JsonSettings.dir);

            if (FlxG.keys.justPressed.ESCAPE)
                  MusicBeatState.switchState(new ExtraMenuState());

            #if desktop
            DiscordClient.changePresence("In Json Editor", null);
            #end

            JsonSettings.dev(JsonSettings.dir);
           
            if (appearance == null || gameplay == null)
            {
                  var error:FlxText = new FlxText(240, 150, 25, "Something was wrong\nwith Json settings.\n
                  Created a json temporarily\nso you can fix them.", 10);
                  error.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                  error.scrollFactor.set();
		      error.borderSize = 1.25;
                  add(error);      
            }
      super.update(elapsed);
      }

      function saveUISetting()
      {
            savetext = 
            '
            {
                  "iconSupport":'+icon+',
	            "noteSkin": "'+na.text+'", 
	            "noteSplashSkin": "'+ney.text+'",
	            "judgementSkin": "'+neya.text+'" 
            }
            ';
            File.saveContent(JsonSettings.dir, savetext);
            if (ididyourmom && appearance == null)
            {
                  if (backup != null && backup.contains("iconSupport") && backup.contains("judgementSkin"))
                        File.saveContent(savedir, backup);
                  else
                  {
                        appearance = '{
                        "iconSupport":false,
                        "noteSkin": "NOTE_assets", 
                        "noteSplashSkin": "noteSplashes",
                        "judgementSkin": "bedrock"         
                        }';
                  }          
            }
            else
            {
            }
      }

      function saveGameplaySetting()
      {
            savegtext = 
            '
            {
                  "letterGrader":'+letterG+',
	            "antiMash":'+mash+',
	            "divider": "'+coolInput.text+'"
            }
            ';
            File.saveContent(JsonSettings.dirtwo, savegtext);
            if (ididyourmom && gameplay == null)
            {
                  if (backup != null && backup.contains("letterGrader") && backup.contains("antiMash"))
                        File.saveContent(gsavedir, gbackup);
                  else
                  {
                        gameplay = '{
                        "letterGrader":true,
                        "antiMash":true,
                        "divider": " - "
                        }';
                  }          
            }
            else
            {

            }
      }
}
