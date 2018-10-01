package iface.client.view 
{
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ClickEvent 
	{
		private var data:String = null;
		private var mouseEvent:MouseEvent = null;
		
		public function ClickEvent( data:String, mouseEvent:MouseEvent ) 
		{
			this.data = data;
			this.mouseEvent = mouseEvent;
		}
		
		public function getData():String
		{
			return this.data;
		}
		
	}
	
}