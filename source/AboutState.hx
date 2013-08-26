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
	
	override public function create():Void 
	{
		aboutHuman = new FlxText(0, 48, FlxG.width, "This game was made during the Ludum Dare 27 Jam. In under 48 houres. \nThis is the first Build without any QC. It might burn your house.");
		aboutHuman.setFormat(null, 16, 0xfcfff5, "center");
		add(aboutHuman);
		aboutCode = new FlxText(0, 225, FlxG.width, "Made by YsenGrimm");
		aboutCode.setFormat(null, 16, 0xfcfff5, "center");
		add(aboutCode);
		super.create();
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