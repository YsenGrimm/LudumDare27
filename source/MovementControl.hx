package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxTilemap;

/**
 * ...
 * @author YsenGrimm
 */
class MovementControl extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0) 
	{
		super(x, y);
		loadGraphic("assets/images/movement.png", true, false, 16, 16, true);
		addAnimation("up", [0], 1, true);
		addAnimation("down", [1], 1, true);
		addAnimation("left", [2], 1, true);
		addAnimation("right", [3], 1, true);
	}
	
	override public function update()
	{
		super.update();
	}
}