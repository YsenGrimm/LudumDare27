package levels;

import openfl.Assets;
import org.flixel.addons.OgmoLevelLoader;
import org.flixel.FlxTilemap;
import openfl.Assets;
import haxe.xml.Fast;
import haxe.xml.Parser;
import org.flixel.FlxG;
import org.flixel.util.FlxPoint;

/**
 * ...
 * @author YsenGrimm
 */

class MapLoader extends FlxTilemap
{
	var ogmo:OgmoLevelLoader;
	private var _fastXML:Fast; 
	private var _xml:Xml;
	private var str:String;
	
	public function new(LevelData:Dynamic, TileGraphic:Dynamic, TileLayer:String, TileWidth:Int, TileHeight:Int) 
	{
		super();
		
		if (Std.is(LevelData, Class))
		{
			str = Type.createInstance(LevelData, []);
		}
		else if (Std.is(LevelData, String))
		{
			str = Assets.getText(LevelData);
		}
		
		_xml = Parser.parse(str);
		_fastXML = new Fast(_xml.firstElement());
		
		loadMap(_fastXML.node.resolve(TileLayer).innerData, TileGraphic, TileWidth, TileHeight);
	}
}