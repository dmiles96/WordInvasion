package impl.client.service.input 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class KeyState 
	{
		private var keyCode:uint = 0;
		private var pressed:Boolean = false;
		private var charCode:uint = 0;
		private var scanned:Boolean = false;
		private var shiftModifier:Boolean = false;
		
		public function KeyState(keyCode:uint, charCode:uint, pressed:Boolean, shiftModifier:Boolean) 
		{
			this.keyCode = keyCode;
			this.charCode = charCode;
			this.pressed = pressed;
			this.shiftModifier = shiftModifier;
		}
				
		public function getKeyCode():uint
		{
			return this.keyCode;
		}
		
		public function scan():uint
		{
			this.scanned = true;
			return this.charCode;
		}
		
		public function isPressed():Boolean
		{
			return this.pressed;
		}
		
		public function press( charCode:int, shiftModifier:Boolean ):void
		{
			this.charCode = charCode;
			this.shiftModifier = shiftModifier;
			this.pressed = true;
		}
		
		public function clear():void
		{
			this.shiftModifier = false;
			this.pressed = false;
			this.scanned = false;
		}
		
		public function isScanned():Boolean
		{
			return scanned;
		}
		
		public function isShifted():Boolean
		{
			return this.shiftModifier;
		}
	}
	
}