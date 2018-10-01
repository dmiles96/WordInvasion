package iface.client.service.video
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;

	/**
	 * ...
	 * @author ...
	 */
	public interface ICanvas 
	{
		function addCanvas( canvas:ICanvas ):void;
		function removeCanvas( canvas:ICanvas ):void;
		function addChild( displayObject:DisplayObject ):void;
		function removeChild( displayObject:DisplayObject ):void;
		function clear():void;
		function setX( newX:Number ):void;
		function setY( newY:Number ):void;
		function getWidth():Number;
		function getHeight():Number;
		function getGraphics():Graphics;
		function takeFocus():void;
		function setWidth( width:Number ):void;
		function setHeight( height:Number ):void;
		function getY():Number;
	}
	
}