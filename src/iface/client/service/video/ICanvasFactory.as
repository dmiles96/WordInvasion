package iface.client.service.video 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ICanvasFactory 
	{
		function createCanvas():ICanvas;
		function createCanvasFromSprite(sprite:Sprite):ICanvas;
		function getMainCanvas():ICanvas;
		function createUpdateableCanvas():IUpdateableCanvas
	}
	
}