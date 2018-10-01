package impl.client.view.components 
{
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldType;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.components.IOnCloseHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SpaceBarDialog extends Dialog
	{
		private var spacebarTextField:TextField = new TextField();
		
		public function SpaceBarDialog( canvasFactory:ICanvasFactory, location:Point, text:String, standardTextForamt:TextFormat, width:int, height:int, onCloseHandler:IOnCloseHandler = null )
		{
			super( canvasFactory, location, text, standardTextForamt, width, height + 20, onCloseHandler );
			
			spacebarTextField.selectable = false;
			spacebarTextField.embedFonts = true;
			spacebarTextField.autoSize = TextFieldAutoSize.CENTER;
			spacebarTextField.type = TextFieldType.DYNAMIC;
			spacebarTextField.text = "Press the spacebar to continue";
			spacebarTextField.setTextFormat( standardTextForamt );
			spacebarTextField.selectable = false;
			spacebarTextField.x = (width / 2 ) - (spacebarTextField.width / 2);
			spacebarTextField.y = this.getHeight() - (spacebarTextField.height) - 10;
			
			this.getDialogCanvas().addChild( spacebarTextField );
		}
		
	}
	
}