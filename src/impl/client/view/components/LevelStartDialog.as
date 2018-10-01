package impl.client.view.components 
{
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldType;	
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.components.IDialog;	
	import iface.client.view.components.ILevelStartDialog;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LevelStartDialog extends SpaceBarDialog implements ILevelStartDialog
	{
		private var standardTextFormat:TextFormat = null;
		private var dialogTextField:TextField = null;
		
		public function LevelStartDialog(canvasFactory:ICanvasFactory, location:Point, standardTextFormat:TextFormat, width:int, height:int ) 
		{
			super( canvasFactory, location, "", standardTextFormat, width, height );
			
			this.standardTextFormat = standardTextFormat;
			this.dialogTextField = this.getDialogTextField();
		}
		
		public function updateStartMessage( startMessage:String ):void
		{
			this.setText( startMessage );
		}
	}
	
}