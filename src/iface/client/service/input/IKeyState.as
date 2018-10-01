package iface.client.service.input 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IKeyState 
	{
		function getKeyCode():uint;
		function scan():uint;
		function scanForChar():String;
		function isPressed():Boolean;
		function press( charCode:int, shiftModifier:Boolean ):void;
		function clear():void;
		function isScanned():Boolean;
		function getType():int;
	}
	
}