package impl.client.presentation.enemy 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import iface.common.domain.enemy.IEnemySizeComputer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EnemySizeComputer implements IEnemySizeComputer
	{
		private var textField:TextField = new TextField();
		private var textFormat:TextFormat = null;
		
		public function EnemySizeComputer( textFormat:TextFormat ) 
		{
			this.textFormat = textFormat;
			
			this.textField.selectable = false;
			this.textField.embedFonts = true;
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			this.textField.type = TextFieldType.DYNAMIC;
			this.textField.setTextFormat( textFormat );
		}
		
		public function computeWidth( data:String ):int
		{
			this.textField.text = data;
			this.textField.setTextFormat( textFormat );

			return this.textField.textWidth;
		}
		
		public function computeHeight( data:String ):int
		{
			this.textField.text = data;
			this.textField.setTextFormat( textFormat );
			
			return this.textField.textHeight;
		}
		
	}
	
}