//i didnt know where to put this tbh
class Misc {
    public static var isPenthosUnlocked(get,set):Bool;
    static function set_isPenthosUnlocked(value:Bool):Bool {
        FlxG.save.data.penthosUnlock = value;
        FlxG.save.flush();
        return value;
    }
	static function get_isPenthosUnlocked():Bool return (FlxG.save.data.penthosUnlock != null && FlxG.save.data.penthosUnlock);

    public static var piratedTheGame(get,set):Bool;
    static function set_piratedTheGame(value:Bool):Bool {
        FlxG.save.data.piracyDone = value;
        FlxG.save.flush();
        return value;
    }
	static function get_piratedTheGame():Bool return (FlxG.save.data.piracyDone != null && FlxG.save.data.piracyDone);


    //could just reuse piratedtehgame but im scared of breakin smth rn imma be real
    public static var experiencedPiracy(get,set):Bool;
    static function set_experiencedPiracy(value:Bool):Bool {
        FlxG.save.data.experiencedPiracy = value;
        FlxG.save.flush();
        return value;
    }
	static function get_experiencedPiracy():Bool return (FlxG.save.data.experiencedPiracy != null && FlxG.save.data.experiencedPiracy);

    public static function crashGame() Sys.exit(0);
	
}

class PapyrusText extends FlxText
{

	public var targetY:Int = 0;
	public var isMenuItem:Bool = false;
	public var changeX:Bool = true;
	public var changeY:Bool = true;


	public var distancePerItem:FlxPoint = new FlxPoint(20, 120);
	public var startPosition:FlxPoint = new FlxPoint(0, 0); //for the calculations

    public var sc:Float = 1;

    public function new(x:Float=0,y:Float=0,e:String = '') {
        super(x,y,0,e,48);
        font = Paths.font('papyrus.ttf');
        updateHitbox();
        startPosition.set(x,y);
    }

    override function update(elapsed:Float)
    {
         var lerpVal:Float = Math.exp(-elapsed * 9.6);
        if (isMenuItem) {
    
            if (changeX)
            x = FlxMath.lerp((targetY * distancePerItem.x) + startPosition.x, x, lerpVal);
            if (changeY)
            y = FlxMath.lerp((targetY * 1.3 * distancePerItem.y) + startPosition.y, y, lerpVal);
        }


        final s = FlxMath.lerp(sc,scale.x, lerpVal);
        scale.set(s,s);

        super.update(elapsed);
    }

    public function snapToPosition()
    {
        if (isMenuItem) {
            if (changeX)
                x = (targetY * distancePerItem.x) + startPosition.x;
            if (changeY)
                y = (targetY * 1.3 * distancePerItem.y) + startPosition.y;
        }

    }
}
