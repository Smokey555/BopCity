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