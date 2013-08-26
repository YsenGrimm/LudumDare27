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
class LevelSelectState extends FlxState
{
	var text: FlxText;
	var level1: FlxButtonPlus;
	var level1Img: FlxSprite;
	var level1Caption: FlxText;
	
	var level2: FlxButtonPlus;
	var level2Img: FlxSprite;
	var level2Caption: FlxText;
	
	var level3: FlxButtonPlus;
	var level3Img: FlxSprite;
	var level3Caption: FlxText;
	
	var level4: FlxButtonPlus;
	var level4Img: FlxSprite;
	var level4Caption: FlxText;
	
	var counter: Int;
	var data: Array<Float>;
	
	override public function create():Void 
	{
		FlxG.bgColor = 0xff91aa9d;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		level1Img = new FlxSprite(0, 0, "assets/images/level1.png");
		level2Img = new FlxSprite(0, 0, "assets/images/level2.png");
		level3Img = new FlxSprite(0, 0, "assets/images/level3.png");
		level4Img = new FlxSprite(0, 0, "assets/images/level4.png");
		
		level1Caption = new FlxText(80, 128, 96, "Level 1");
		level1Caption.setFormat(null, 16, 0xfcfff5, "center");
		add(level1Caption);
		level1 = new FlxButtonPlus(80, 160, loadLevel1, null, null, 96, 96);
		level1.loadGraphic(level1Img, level1Img);
		add(level1);
		
		level2Caption = new FlxText(208, 128, 96, "Level 2");
		level2Caption.setFormat(null, 16, 0xfcfff5, "center");
		add(level2Caption);
		level2 = new FlxButtonPlus(208, 160, loadLevel2, null, null, 96, 96);
		level2.loadGraphic(level2Img, level2Img);
		add(level2);
		
		level3Caption = new FlxText(336, 128, 96, "Level 3");
		level3Caption.setFormat(null, 16, 0xfcfff5, "center");
		add(level3Caption);
		level3 = new FlxButtonPlus(336, 160, loadLevel3, null, null, 96, 96);
		level3.loadGraphic(level3Img, level3Img);
		add(level3);
		
		level4Caption = new FlxText(464, 128, 96, "Level 4");
		level4Caption.setFormat(null, 16, 0xfcfff5, "center");
		add(level4Caption);
		level4 = new FlxButtonPlus(464, 160, loadLevel4, null, null, 96, 96);
		level4.loadGraphic(level4Img, level4Img);
		add(level4);
		
		super.create();
	}
	
	function loadLevel4() 
	{
		Reg.level = 4;
		FlxG.switchState(new MenuState());
	}
	
	function loadLevel3() 
	{
		Reg.level = 3;
		FlxG.switchState(new MenuState());
	}
	
	function loadLevel2() 
	{
		Reg.level = 2;
		FlxG.switchState(new MenuState());
	}
	
	function loadLevel1()
	{
		Reg.level = 1;
		FlxG.switchState(new MenuState());
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