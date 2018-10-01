package impl.client.service.input 
{
	import iface.client.service.input.IKeyState;
	import iface.client.service.input.KeyStateTypes;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AlphaNumericKeyState extends KeyState implements IKeyState
	{
		
		public function AlphaNumericKeyState(keyCode:uint, charCode:uint, pressed:Boolean, shiftModifier:Boolean)
		{
			super( keyCode, charCode, pressed, shiftModifier );
		}
		
		public function scanForChar():String
		{
			var charCode:uint = this.scan();
			var char:String = String.fromCharCode( charCode );
			
			if ( this.isShifted() )
			{
				return char.toLocaleUpperCase();
			}
			
			return char;
		}
		
		public function getType():int
		{
			return KeyStateTypes.ALPHANUMERIC_KEY;
		}		
	}
	
}