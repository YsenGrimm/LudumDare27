package entities;

import openfl.Assets;
import org.flixel.FlxSprite;
import org.flixel.FlxG;

/**
 * ...
 * @author YsenGrimm
 */
class Player extends FlxSprite
{
	var maxVelocityX = 200;
	var maxVelocityY = 200;
	public function new(x:Float, y:Float, direction:Int) 
	{
		super(x, y);
		loadGraphic("assets/images/player.png", false, false, 16, 16, false);
		switch (direction) 
		{
			case 1:
				angle = 0;
			case 2:
				angle = 90;
			case 3:	
				angle = 180;
			case 4:
				angle = 270;
			default:
				angle = 0;
		}
		
		acceleration.x = 30;
		maxVelocity.x = 100;
	}
	
	override public function update()
	{
		
		super.update();
	}
	
}