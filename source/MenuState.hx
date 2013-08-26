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
	var indUp: FlxText;
	var indUpCount: Int;
	var indDown: FlxText;
	var indDownCount: Int;
	var indLeft: FlxText;
	var indLeftCount: Int;
	var indRight: FlxText;
	var indRightCount: Int;
	
	var placeTimer:Float;
	var placeText:FlxText;
	var placeCaption:FlxText;
	var placeAllowed: Bool;
	var allowPlacing: Bool;
	
	var gameTimer:Float;
	var gameText:FlxText;
	var gameCaption: FlxText;
	
	var readySetGo:FlxText;
	var readyTimer:Float;
	
	var movement:MovementControl;
	var movementPool:Array<MovementControl>;
	
	var tilePosition:Array<FlxPoint>;
	var tileSelected:Bool = false;
	var selectedPosition:FlxPoint;
	
	var playerStartAngle: Int;
	var playerStartSpeedX: Float;
	var playerStartSpeedY: Float;
	var playerSpeed: Float;
	
	var playerStartPositionX: Float;
	var playerStartPositionY: Float;
	var goalPositionX: Float;
	var goalPositionY: Float;
	
	override public function create():Void
	{
		// Set a background color
		FlxG.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		readyTimer = 4.0;
		gameTimer = 10.0;
		placeTimer = 10.0;
		placeAllowed = false; //movement Player
		allowPlacing = false; //placement Movetiles
		startPlayer = true;
		
		switch (Reg.level) 
		{
			case 1:
				level = new MapLoader("assets/levels/firstLevel.oel", "assets/images/tiles.png", "tiles", 16, 16);
				add(level);
				collisionMap = new MapLoader("assets/levels/firstLevel.oel", "assets/images/collide.png", "collision", 16, 16);
				add(collisionMap);
				indUpCount = 3;
				indDownCount = 2;
				indLeftCount = 2;
				indRightCount = 2;
				playerStartAngle = 2;
				playerStartSpeedX = 60;
				playerStartSpeedY = 0;
				playerSpeed = 60;
				playerStartPositionX = 96;
				playerStartPositionY = 256;
				goalPositionX = 480;
				goalPositionY = 256;
			case 2:
				level = new MapLoader("assets/levels/secondLevel.oel", "assets/images/tiles.png", "tiles", 16, 16);
				add(level);
				collisionMap = new MapLoader("assets/levels/secondLevel.oel", "assets/images/collide.png", "collision", 16, 16);
				add(collisionMap);
				indUpCount = 2;
				indDownCount = 2;
				indLeftCount = 1;
				indRightCount = 1;
				playerStartAngle = 4;
				playerStartSpeedX = -60;
				playerStartSpeedY = 0;
				playerSpeed = 60;
				playerStartPositionX = 352;
				playerStartPositionY = 400;
				goalPositionX = 304;
				goalPositionY = 272;
			case 3:
				level = new MapLoader("assets/levels/thirdLevel.oel", "assets/images/tiles.png", "tiles", 16, 16);
				add(level);
				collisionMap = new MapLoader("assets/levels/thirdLevel.oel", "assets/images/collide.png", "collision", 16, 16);
				add(collisionMap);
				indUpCount = 3;
				indDownCount = 1;
				indLeftCount = 2;
				indRightCount = 1;
				playerStartAngle = 3;
				playerStartSpeedX = 0;
				playerStartSpeedY = 60;
				playerSpeed = 60;
				playerStartPositionX = 64;
				playerStartPositionY = 144;
				goalPositionX = 256;
				goalPositionY = 320;
			case 4:
				level = new MapLoader("assets/levels/fourthLevel.oel", "assets/images/tiles.png", "tiles", 16, 16);
				add(level);
				collisionMap = new MapLoader("assets/levels/fourthLevel.oel", "assets/images/collide.png", "collision", 16, 16);
				add(collisionMap);
				indUpCount = 2;
				indDownCount = 2;
				indLeftCount = 1;
				indRightCount = 1;
				playerStartAngle = 2;
				playerStartSpeedX = 60;
				playerStartSpeedY = 0;
				playerSpeed = 60;
				playerStartPositionX = 64;
				playerStartPositionY = 64;
				goalPositionX = 336;
				goalPositionY = 432;
			default:
				/*
				level = new MapLoader("assets/levels/level01.oel", "assets/images/tiles.png", "tiles", 16, 16);
				add(level);
				collisionMap = new MapLoader("assets/levels/level01.oel", "assets/images/collide.png", "collision", 16, 16);
				add(collisionMap);
				indUpCount = 3;
				indDownCount = 3;
				indLeftCount = 3;
				indRightCount = 3;
				playerStartAngle = 2;
				playerStartSpeedX = 30;
				playerStartSpeedY = 0;
				playerSpeed = 60;
				*/
		}
		
		
		frame = new MapLoader("assets/levels/level01.oel", "assets/images/frame.png", "frame", 16, 16);
		add(frame);
		
		readySetGo = new FlxText(0, 48, FlxG.width, "", 32);
		readySetGo.setFormat( null, 32, 0xfcfff5, "center");
		add(readySetGo);
		
		gameCaption = new FlxText(586, 16, 100, "", 8);
		gameCaption.setFormat(null, 8, 0xafcfff5);
		add(gameCaption);
		placeText = new FlxText(586, 32, 64, Std.string(placeTimer), 16);
		add(placeText);
		
		gameText = new FlxText(586, 64, 64, Std.string(gameTimer), 16);
		add(gameText);
		
		indicator = new FlxGroup();
		indicator.add(new IndTop(36, 7));
		indicator.add(new IndDown(36, 12));
		indicator.add(new IndLeft(36, 17));
		indicator.add(new IndRight(36, 22));
		add(indicator);
		
		indUp = new FlxText(592, 160, 32, Std.string(indUpCount), 16);
		indUp.setFormat(null, 16, 0xfcfff5, null, 0x193441, true);
		add(indUp);
		
		indDown = new FlxText(592, 240, 32, Std.string(indDownCount), 16);
		indDown.setFormat(null, 16, 0xfcfff5, null, 0x193441, true);
		add(indDown);
		
		indLeft = new FlxText(592, 320, 32, Std.string(indLeftCount), 16);
		indLeft.setFormat(null, 16, 0xfcfff5, null, 0x193441, true);
		add(indLeft);
		
		indRight = new FlxText(592, 400, 32, Std.string(indRightCount), 16);
		indRight.setFormat(null, 16, 0xfcfff5, null, 0x193441, true);
		add(indRight);
		
		movementPool = new Array();
		
		selecet = new Selected();
		add(selecet);
		
		goal = new Goal(goalPositionX, goalPositionY);
		add(goal);
		
		player = new Player(playerStartPositionX ,playerStartPositionY , playerStartAngle);
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
		readyTimer -= FlxG.elapsed;
		indUp.text = Std.string(indUpCount);
		indDown.text = Std.string(indDownCount);
		indLeft.text = Std.string(indLeftCount);
		indRight.text = Std.string(indRightCount);
		
		if (readyTimer >= 3) 
		{
			readySetGo.text = "ready";
		} else if (readyTimer >= 2) 
		{
			readySetGo.text = "set";
		} else if (readyTimer >= 1) 
		{
			readySetGo.text = "go";
		} else 
		{
			readySetGo.text = "";
			placeTimer -= FlxG.elapsed;
			placeText.text = Std.string(Math.floor(placeTimer));
			placeAllowed = true;
		}
		
		if (placeTimer > 0 && placeAllowed) 
		{
			gameCaption.text = "Place!1!";
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
			
			if (FlxG.keys.justPressed("W") && tileSelected && indUpCount > 0) 
			{
				movement = new MovementControl(selectedPosition.x, selectedPosition.y);
				movement.play("up");
				movementPool.push(movement);
				indUpCount -= 1;
				clearSelected();
			} else if (FlxG.keys.justPressed("S") && tileSelected && indDownCount > 0) 
			{
				movement = new MovementControl(selectedPosition.x, selectedPosition.y);
				movement.play("down");
				movementPool.push(movement);
				indDownCount -= 1;
				clearSelected();
			} else if (FlxG.keys.justPressed("A") && tileSelected && indLeftCount > 0) 
			{
				movement = new MovementControl(selectedPosition.x, selectedPosition.y);
				movement.play("left");
				movementPool.push(movement);
				clearSelected();
				indLeftCount -= 1;
			} else if (FlxG.keys.justPressed("D") && tileSelected && indRightCount > 0) 
			{
				movement = new MovementControl(selectedPosition.x, selectedPosition.y);
				movement.play("right");
				movementPool.push(movement);
				indRightCount -= 1;
				clearSelected();
			}
			
		} else 
		{
			placeAllowed = false;
			if (placeTimer <= 0) 
			{
				placeText.text = "--";
			}
			
			if (readyTimer <= 0) 
			{
				gameTimer -= FlxG.elapsed;
				gameText.text = Std.string(Math.floor(gameTimer));
			}
		}
		
		if (placeTimer <= 0) 
		{
			if (startPlayer) 
			{
				player.velocity.x = playerStartSpeedX;
				player.velocity.y = playerStartSpeedY;
				startPlayer = false;
			}
		}
		
		if (gameTimer > 0 && !placeAllowed) 
		{
			gameCaption.text = "Game !1!";
			if (Math.floor(player.x) == goal.x && Math.floor(player.y) == goal.y) 
			{
				switch (Reg.level) 
				{
					case 1:
						Reg.scoreLevel1 = gameTimer;
					case 2:
						Reg.scoreLevel2 = gameTimer;
					case 3:	
						Reg.scoreLevel3 = gameTimer;
					case 4:
						Reg.scoreLevel4 = gameTimer;
					default:
					
					FlxG.switchState(new LevelSelectState());
				}
			}
			
			
		} else if (gameTimer <= 0) 
		{
			gameText.text = "--";
			FlxG.switchState(new GameOverState());
		}

		
		if (FlxG.collide(collisionMap, player)) 
		{
			FlxG.switchState(new GameOverState());
		}
			
		for (i in movementPool) 
		{
			add(i);
			
			if (Math.floor(player.x) == i.x && Math.floor(player.y) == i.y) 
			{
				isOverlapping(player, i);
			}
			
			if (FlxG.mouse.x > i.x && FlxG.mouse.x < (i.x +16) && FlxG.mouse.y > i.y && FlxG.mouse.y < (i.y + 16) && FlxG.mouse.justPressed() && placeAllowed) 
			{
				switch (i.playingAnim) 
				{
					case "up":
						indUpCount += 1;
					case "down":
						indDownCount += 1;
					case "left":
						indLeftCount += 1;
					case "right":
						indRightCount += 1;
					default:
						trace("babumm");
				}
				i.kill();
				movementPool.remove(i);
			}
		}
		super.update();
	}	
	
	function isOverlapping(playerCollider:FlxObject, movementCollider:MovementControl)
	{

		switch (movementCollider.playingAnim) 
			{
				case "up":
						player.angle = 0;
						player.velocity.x = 0;
						player.velocity.y = -playerSpeed;
				case "down":
						player.angle = 180;
						player.velocity.x = 0;
						player.velocity.y = playerSpeed;
				case "left":
						player.angle = 270;
						player.velocity.x = -playerSpeed;
						player.velocity.y = 0;
				case "right":
						player.angle = 90;
						player.velocity.x = playerSpeed;
						player.velocity.y = 0;
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