package ;

import levels.MapLoader;
import org.flixel.FlxState;
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
import org.flixel.FlxText;
import org.flixel.FlxTilemap;
import org.flixel.plugin.photonstorm.FlxButtonPlus;

/**
 * ...
 * @author YsenGrimm
 */
class AboutState extends FlxState
{
	var aboutHuman:FlxText;
	var aboutCode:FlxText;
	var back: FlxButtonPlus;
	var norm: FlxSprite;
	var hover: FlxSprite;
	
	
	override public function create():Void 
	{
		norm = new FlxSprite(0, 0, "assets/images/buttonNormal.png");
		hover = new FlxSprite(0, 0, "assets/images/buttonHover.png");
		
		aboutHuman = new FlxText(32, 48, FlxG.width - 32, "How to Play: \nIn the first 10 seconds you have to place the movement tiles with klicking an pressing W, A, S or D on your keyboard. \n In the next 10 seconds the player character tries to reach the green \"goal\" wihle following the placed movement tiles.\n The game ends either with the player reaching the goal or with a game over. This hppens the player hits the wall or isn't able to reach the goal in the provided time frame.\n\nThis game was made during the Ludum Dare 27 Jam. In under 48 houres. \nThis is the first Build without any QC. It might burn your house.");
		aboutHuman.setFormat(null, 16, 0xfcfff5, "left");
		add(aboutHuman);
		back = new FlxButtonPlus(32, 352, switchToMenu, null, "Menu", 160, 48);
		back.loadGraphic(norm, hover);
		back.textHighlight.y += 12;
		back.textNormal.y += 8;
		back.textHighlight.size = 16;
		back.textNormal.size = 16;
		add(back);
		super.create();
	}
	
	public function switchToMenu() 
	{
		FlxG.switchState(new Menu());
	}
	
	override public function destroy():Void 
	{
		super.destroy();
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
}