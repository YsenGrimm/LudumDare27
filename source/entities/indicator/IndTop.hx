package entities.indicator;

import org.flixel.FlxSprite;

/**
 * ...
 * @author YsenGrimm
 */
class IndTop extends FlxSprite
{

	public function new(x: Int, y:Int) 
	{
		var x = x * 16;
		var y = y * 16;
		super(x, y, "assets/images/indicatorUp.png");
	}
	
}