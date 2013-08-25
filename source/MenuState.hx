package;

import entities.Goal;
import entities.indicator.*;
import Std;
import entities.Player;
import entities.Selected;
import levels.MapLoader;
import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import org.flixel.FlxBasic;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
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
	
	var player:Player;
	var playerVel:Float;
	var startPlayer:Bool;
	var selecet:Selected;
	var goal: Goal;
	
	var level:MapLoader;
	var collisionMap:MapLoader;
	var frame:MapLoader;
	var indicator:FlxGroup;
	
	var placeTimer:Float;
	var placeText:FlxText;
	var placeCaption:FlxText;
	var placeAllowed: Bool;
	
	var gameTimer:Float;
	var gameText:FlxText;
	var gameCaption: FlxText;
	
	var movement:MovementControl;
	var movementPool:Array<MovementControl>;
	
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
		
		gameTimer = 10.0;
		placeTimer = 10.0;
		placeAllowed = true;
		startPlayer = true;
		
		level = new MapLoader("assets/levels/level01.oel", "assets/images/tiles.png", "tiles", 16, 16);
		add(level);
		
		collisionMap = new MapLoader("assets/levels/level01.oel", "assets/images/collide.png", "collision", 16, 16);
		add(collisionMap);
		
		frame = new MapLoader("assets/levels/level01.oel", "assets/images/frame.png", "frame", 16, 16);
		add(frame);
		
		placeCaption = new FlxText(586, 22, 100, "Place!", 8);
		add(placeCaption);
		placeText = new FlxText(586, 32, 64, Std.string(placeTimer), 16);
		add(placeText);
		
		gameText = new FlxText(586, 64, 64, Std.string(gameTimer), 16);
		add(gameText);
		
		indicator = new FlxGroup();
		indicator.add(new IndTop(36, 5));
		indicator.add(new IndDown(36, 10));
		indicator.add(new IndLeft(36, 15));
		indicator.add(new IndRight(36, 20));
		add(indicator);

		movementPool = new Array();
		
		selecet = new Selected();
		add(selecet);
		
		goal = new Goal(20, 15);
		add(goal);
		
		player = new Player(96 ,96 , 4);
		add(player);
		
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
		placeTimer -= FlxG.elapsed;
		placeText.text = Std.string(Math.floor(placeTimer));
		
		if (placeTimer > 0) 
		{
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
				movementPool.push(movement);
				clearSelected();
			} else if (FlxG.keys.justPressed("S") && tileSelected) 
			{
				movement = new MovementControl(selectedPosition.x, selectedPosition.y);
				movement.play("down");
				movementPool.push(movement);
				clearSelected();
			} else if (FlxG.keys.justPressed("A") && tileSelected) 
			{
				movement = new MovementControl(selectedPosition.x, selectedPosition.y);
				movement.play("left");
				movementPool.push(movement);
				clearSelected();
			} else if (FlxG.keys.justPressed("D") && tileSelected) 
			{
				movement = new MovementControl(selectedPosition.x, selectedPosition.y);
				movement.play("right");
				movementPool.push(movement);
				clearSelected();
			}
		} else 
		{
			placeAllowed = false;
			placeText.text = "--";
			gameTimer -= FlxG.elapsed;
			gameText.text = Std.string(Math.floor(gameTimer));
		}
		
		if (gameTimer > 0 && !placeAllowed) 
		{
			if (startPlayer) 
			{
				player.velocity.x = 30;
				startPlayer = false;
			}
			if (Math.floor(player.x) == goal.x && Math.floor(player.y) == goal.y) 
			{
				Reg.score.push(gameTimer);
			}
			
			
		} else 
		{
			gameText.text = "--";
			trace("game over");
		}
		
		if (FlxG.collide(collisionMap, player)) 
		{
			trace("game over");
		}
			
		for (i in movementPool) 
		{
			add(i);
			//FlxG.overlap(player, i, isOverlapping);
			
			if (Math.floor(player.x) == i.x && Math.floor(player.y) == i.y) 
			{
				isOverlapping(player, i);
			}
			
			if (FlxG.mouse.x > i.x && FlxG.mouse.x < (i.x +16) && FlxG.mouse.y > i.y && FlxG.mouse.y < (i.y + 16) && FlxG.mouse.justPressed() && placeAllowed) 
			{
				i.kill();
			}
		}
		
		super.update();
	}	
	
	function isOverlapping(playerCollider:FlxObject, movementCollider:MovementControl)
	{

		switch (movementCollider.playingAnim) 
			{
				case "up":
					player.velocity.x = 0;
					player.velocity.y = -30;
					player.angle = 0;
				case "down":
					player.velocity.x = 0;
					player.velocity.y = 30;
					player.angle = 180;
					
				case "left":
					player.velocity.y = 0;
					player.velocity.x = -30;
					player.angle = 270;
					
				case "right":
					player.velocity.y = 0;
					player.velocity.x = 30;
					player.angle = 90;
					
				default:
					trace("nothin");
			}
	}
	
	private function clearSelected()
	{
		tileSelected = false;
		selecet.x = -16;
		selecet.y = -16;
	}
}