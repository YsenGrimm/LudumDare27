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
	var xPos: Float;
	var yPos: Float;
	public function new(x:Float, y:Float, direction:Int) 
	{
		super(x, y);
		loadGraphic("assets/images/player.png", false, false, 16, 16, false);
		//offset.x = 1;
		//offset.y = 1;
		//centerOffsets(true);
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
		
		velocity.x = 0;
		velocity.y = 0;
	}
	
	override public function update()
	{
		
		super.update();
	}
	
}