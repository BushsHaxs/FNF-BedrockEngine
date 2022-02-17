package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;

class ResultsSubState extends MusicBeatSubstate
{
    public var applause:FlxSound;
    public var results:FlxSound;

    public var bg:FlxSprite;
    public var resultRank:FlxSprite;
    public var hidingBG:FlxSprite;

    public var accText:FlxText;
    // public var continue:FlxText;

    // WIP
    override function create()
    {
        applause = new FlxSound().loadEmbedded(Paths.sound('applause'));
        results = new FlxSound().loadEmbedded(Paths.music('resultsScreen'));

        var ratingResult:String = '';

        bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.alpha = 0.5;

        var ratings:FlxSpriteGroup = new FlxSpriteGroup

        accText = new FlxText(-200, 65, 0,
            'Accuracy: ${countAcc(PlayState.Highscore.floorDecimal(ratingPercent * 100, 2))}'
        );

        var perfect:FlxSprite = new FlxSprite(-150, 65).loadGraphic(Paths.image('maniamode/resultsscreen/perfect'));
        perfect.antialiasing = true;

        var percent:Float = PlayState.instance.ratingPercent;
        resultRank = new FlxSprite(150, 30).loadGraphic(Paths.image('maniamode/resultsscreen/' + ratingResult));
        resultRank.antialiasing = true;

        if(PlayState.songMisses < 0 && ratingResult = 'X' || ratingResult = 'S')
            resultRank = new FlxSprite(150, 30).loadGraphic(Paths.image('maniamode/resultsscreen/' + ratingResult + '-gold'));

        switch (percent)
        {
            case 1:
                ratingResult = 'X';
    
            case 0.951:
                ratingResult = 'S';
    
            case 0.91:
                ratingResult = 'A';
    
            case 0.81:
                ratingResult = 'B';
    
            case 0.71:
                ratingResult = 'C';
    
            case 0.61:
                ratingResult = 'D';
        }

        hidingBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(hidingBG);
    }

    override function update()
    {
        if(FlxG.keys.justPressed.ENTER)
        {
            results.fadeIn(0.4, 1, 0);
            applause.fadeIn(0.4, 1, 0);
            close();

            if(PlayState.isStoryMode)
                MusicBeatState.switchState(new StoryMenuState());
            else
                MusicBeatState.switchState(new FreeplayState());
        }
    }

    public function new()
    {
        FlxTween.tween(hidingBG, {alpha:0}, 0.2, {
            ease:FlxEase.circOut
        });

        new FlxTimer().start(0.9, function(tmr:FlxTimer)
        {
            resultRank.visble = true;
            FlxG.sound.play(Paths.sound('confirmMenu'));

            onComplete: function(tmr:FlxTimer)
            {
                applause.play();
                results.play()
            }
        }
    }

    public static function countAcc(number:Float, precision:Int):Float // ROBBED FROM KADE LMAOO
    {
        var num = number;
        num = num * Math.pow(10, precision);
        num = Math.round(num) / Math.pow(10, precision);
        return num;
    }
}