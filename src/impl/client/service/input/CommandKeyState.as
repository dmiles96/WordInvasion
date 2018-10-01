package impl.client.service.input 
{
	import iface.client.service.input.IKeyState;
	import iface.client.service.input.KeyStateTypes;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CommandKeyState extends KeyState implements IKeyState
	{
		private var name:String = null;
		
		public function CommandKeyState( name:String, keyCode:uint, charCode:uint, pressed:Boolean, shiftModifier:Boolean) 
		{
			super( keyCode, charCode, pressed, shiftModifier );
			
			this.name = name;
		}
		
		public function scanForChar():String
		{
			this.scan();
			
			return name;
		}
		
		public function getType():int
		{
			return KeyStateTypes.COMMAND_KEY;
		}
	}
	
}