//i didnt know where to put this tbh
class Misc {
    public static var isPenthosUnlocked(get,set):Bool;
    static function set_isPenthosUnlocked(value:Bool):Bool {
        FlxG.save.data.penthosUnlock = value;
        FlxG.save.flush();
        return value;
    }
	static function get_isPenthosUnlocked():Bool return (FlxG.save.data.penthosUnlock != null && FlxG.save.data.penthosUnlock);
	
}