package;

import entities.Player;
import entities.Selected;
import levels.MapLoader;
import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTilemap;
import org.flixel.util.FlxMath;
import org.flixel.util.FlxPoint;

class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	
	/**
	 * Dummyz
	*/
	
	var dummy:FlxSprite;
	
	/**********************************/
	
	var player:Player;
	var selecet:Selected;
	var level:MapLoader;
	var collisionMap:MapLoader;
	
	var movement:MovementControl;
	
	var tilePosition:Array<FlxPoint>;
	var tileSelected:Bool = false;
	var selectedPosition:FlxPoint;
	 
	override public function create():Void
	{
		// Set a background color
		FlxG.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		
		level = new MapLoader("assets/levels/level01.oel", "assets/images/tiles.png", "tiles", 16, 16);
		add(level);
		
		collisionMap = new MapLoader("assets/levels/level01.oel", "assets/images/collide.png", "collision", 16, 16);
		add(collisionMap);
		
		selecet = new Selected();
		add(selecet);
		
		player = new Player(96,96, 4);
		add(player);
		
		dummy = new FlxSprite(0, 0, "assets/images/dummy.png");
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if (FlxG.collide(collisionMap, player))
		{
			trace("collide!");
		}
		
		if (FlxG.collide(player, movement)) 
		{
			player.acceleration.y = 10;
		}
		if (FlxG.mouse.justPressed()) 
		{
			tilePosition = level.getTileCoords(1, false);
			for (tile in tilePosition) 
			{
				if (FlxG.mouse.x > tile.x && FlxG.mouse.x < (tile.x +16) && FlxG.mouse.y > tile.y && FlxG.mouse.y < (tile.y + 16)) 
				{
					selectedPosition = tile;
					selecet.x = tile.x;
					selecet.y = tile.y;
					
					tileSelected = true;
				}
			}
		}
		
		if (FlxG.keys.justPressed("W") && tileSelected) 
		{
			movement = new MovementControl(selectedPosition.x, selectedPosition.y);
			movement.play("up");
			add(movement);
			clearSelected();
		} else if (FlxG.keys.justPressed("S") && tileSelected) 
		{
			movement = new MovementControl(selectedPosition.x, selectedPosition.y);
			movement.play("down");
			add(movement);
			clearSelected();
		} else if (FlxG.keys.justPressed("A") && tileSelected) 
		{
			movement = new MovementControl(selectedPosition.x, selectedPosition.y);
			movement.play("left");
			add(movement);
			clearSelected();
		} else if (FlxG.keys.justPressed("D") && tileSelected) 
		{
			movement = new MovementControl(selectedPosition.x, selectedPosition.y);
			movement.play("right");
			add(movement);
			clearSelected();
		}
		super.update();
	}	
	
	private function clearSelected()
	{
		tileSelected = false;
		selecet.x = -16;
		selecet.y = -16;
	}
}