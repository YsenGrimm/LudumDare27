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
class Menu extends FlxState
{
	var play: FlxButtonPlus;
	var about: FlxButtonPlus;
	var title: FlxText;
	
	var buttonNorm:ButtonNormalImg;
	var buttonHov:ButtonHoverImg;
	
	var horrible: FlxText;
	
	override public function create():Void 
	{
		// Set a background color
		FlxG.bgColor = 0xff91aa9d;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		buttonNorm = new ButtonNormalImg();
		buttonHov = new ButtonHoverImg();
		
		title = new FlxText(FlxG.width / 2 - 250, 112, 500, "MOVEMENT", 32);
		title.setFormat("assets/fonts/orbitron.ttf", 48, 0xffffff, "center");
		add(title);
		
		play = new FlxButtonPlus( 96, 320, goToLevelSelect, null, "Play", 160, 48);
		play.loadGraphic(buttonNorm, buttonHov);
		play.textNormal.size = 16;
		play.textNormal.y += 8;
		play.textHighlight.y += 14;
		play.textHighlight.size = 16;
		play.textNormal.color = 0xfcfff5;
		play.textHighlight.color = 0xfcfff5;
		add(play);
		
		about = new FlxButtonPlus( 384, 320, goToAboutScreen, null, "About", 160, 48);
		about.loadGraphic(buttonNorm, buttonHov);
		about.textNormal.size = 16;
		about.textNormal.y += 8;
		about.textHighlight.y += 14;
		about.textHighlight.size = 16;
		add(about);
		
		horrible = new FlxText(0, 225, FlxG.width, "Horrible Broken", 16);
		horrible.setFormat(null, 16, 0xfcfff5, "center");
		add(horrible);
		
		super.create();
	}
	
	function goToAboutScreen() 
	{
		FlxG.switchState(new AboutState());
	}
	
	function goToLevelSelect() 
	{
		FlxG.switchState(new LevelSelectState());
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