package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Preloader extends MovieClip 
	{
		private var loaderFormat:TextFormat = new TextFormat("Atari", 20, 0xFFFFFF);
		private var loadingTextField:TextField = new TextField();
		private var percentageTextField:TextField = new TextField();
		
		public function Preloader() 
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			
			this.loadingTextField.selectable = false;
			this.loadingTextField.embedFonts = true;
			this.loadingTextField.autoSize = TextFieldAutoSize.LEFT;
			this.loadingTextField.type = TextFieldType.DYNAMIC;
			this.loadingTextField.text = "Loading...";
			this.loadingTextField.setTextFormat( loaderFormat );
			
			this.percentageTextField.selectable = false;
			this.percentageTextField.embedFonts = true;
			this.percentageTextField.autoSize = TextFieldAutoSize.LEFT;
			this.percentageTextField.type = TextFieldType.DYNAMIC;
			this.percentageTextField.text = "0%";
			this.percentageTextField.setTextFormat( loaderFormat );

			this.loadingTextField.x = (stage.width / 2) - (loadingTextField.width / 2);
			this.loadingTextField.y = (stage.height / 2) - loadingTextField.height;

			this.percentageTextField.x = (stage.width / 2) - (percentageTextField.width / 2);
			this.percentageTextField.y = (stage.height / 2)
			
			addChild( this.loadingTextField );
			addChild( this.percentageTextField );
		}
		
		private function progress(e:ProgressEvent):void 
		{
			var percentage:int = (e.bytesLoaded / e.bytesTotal) * 100;
			
			this.percentageTextField.text = percentage.toString() + "%";
			this.percentageTextField.setTextFormat( loaderFormat );
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				startup();
			}
		}
		
		private function startup():void 
		{
			removeChild( this.loadingTextField );
			removeChild( this.percentageTextField );
			
			stop();
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}