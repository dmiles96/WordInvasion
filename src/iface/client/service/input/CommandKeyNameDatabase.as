package iface.client.service.input 
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CommandKeyNameDatabase 
	{
		private var comandKeyNamesByCode:Dictionary = new Dictionary();
		
		public static const F1_KEY:String = "F1";
		public static const F2_KEY:String = "F2";
		public static const F3_KEY:String = "F3";
		public static const ESC:String = "ESC";
		
		public function CommandKeyNameDatabase() 
		{
			this.comandKeyNamesByCode[112] = F1_KEY;
			this.comandKeyNamesByCode[113] = F2_KEY;
			this.comandKeyNamesByCode[114] = F3_KEY;
			this.comandKeyNamesByCode[27] = ESC;
		}
		
		public function getKeyNameForCode( keyCode:uint ):String
		{
			return this.comandKeyNamesByCode[keyCode];
		}
		
	}
	
}