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
	import iface.client.view.components.IGamePauseDialog;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GamePauseDialog extends Dialog implements IGamePauseDialog
	{
		public var soundTextField:TextField = new TextField();
		public var soundMessage:String = "Press +/- to change sound volume: ";
		public var standardTextFormat:TextFormat = null;
		
		public function GamePauseDialog(canvasFactory:ICanvasFactory, location:Point, standardTextFormat:TextFormat, width:int, height:int, volume:int ) 
		{
			super( canvasFactory, location, "Game Paused. Press q to quit.", standardTextFormat, width, height );
			
			this.standardTextFormat = standardTextFormat;
			
			var dialogTextField:TextField = this.getDialogTextField();
			
			dialogTextField.y = (height / 4) - (dialogTextField.textHeight / 2);
			
			soundTextField.selectable = false;
			soundTextField.embedFonts = true;
			soundTextField.autoSize = TextFieldAutoSize.LEFT;
			soundTextField.type = TextFieldType.DYNAMIC;
			
			this.updateVolumeDisplay( volume );

			soundTextField.x = (width / 2) - (soundTextField.width / 2);
			soundTextField.y = (height / 4) * 3 - (soundTextField.textHeight / 2);
			
			this.getDialogCanvas().addChild( soundTextField );
		}
		
		public function updateVolumeDisplay( newVolume:int ):void
		{
			this.soundTextField.text = soundMessage.concat( newVolume.toString().concat( "%" ));
			this.soundTextField.setTextFormat( this.standardTextFormat );
		}
		
	}
	
}