package ;

import entities.ButtonHoverImg;
import entities.ButtonNormalImg;
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
class GameOverState extends FlxState
{
	var text: FlxText;
	var menu: FlxButtonPlus;
	var again: FlxButtonPlus;
	var gameOverBg: FlxSprite;
	
	var buttonNorm: ButtonNormalImg;
	var buttonHov: ButtonHoverImg;
	
	override public function create():Void 
	{
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		buttonNorm = new ButtonNormalImg();
		buttonHov = new ButtonHoverImg();
		
		gameOverBg = new FlxSprite(0, 0, "assets/images/gameOverScreen.png");
		add(gameOverBg);
		
		text = new FlxText(0, 32, FlxG.width, "GAME OVER", 48);
		text.setFormat(null, 48, 0xffffff, "center");
		add(text);
		
		menu = new FlxButtonPlus(0, 320, backToMenu, null, "Menu", 160, 48);
		menu.screenCenter();
		menu.textNormal.setFormat(null, 16, 0xffffff, "center");
		menu.textNormal.y += 8;
		menu.textHighlight.setFormat(null, 16, 0xffffff, "center");
		menu.textHighlight.y += 12;
		menu.loadGraphic(buttonNorm, buttonHov);
		add(menu);
		
		super.create();
	}
	
	function backToMenu() 
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