package impl.client.view 
{
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	import iface.client.presentation.highscore.IHighscorePresentation;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.IClickHandler;
	import iface.client.view.IHighscoreView;
	import impl.client.view.components.Button;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HighscoreView implements IHighscoreView
	{
		private var titleTextField:TextField = null;
		private var nameTextFormat:TextFormat = new TextFormat("Atari", 16, 0xFFFFFF );
		private var titleTextFormat:TextFormat = new TextFormat( "Atari", 20, 0xFFFFFF);
		private var viewCanvas:ICanvas = null;
		private var continueButton:Button = null;
		private var playAreaWidth:int = 0;
		private var playAreaHeight:int = 0;
		private var leftMargin:int = 0;
		private var fieldPadding:int = 0;
		
		public function HighscoreView(canvasFactory:ICanvasFactory, playAreaWidth:int, playAreaHeight:int, leftMargin:int, fieldPadding:int, continueClickHandler:IClickHandler, buttonTextFormat:TextFormat) 
		{
			this.playAreaWidth = playAreaWidth;
			this.playAreaHeight = playAreaHeight;
			this.leftMargin = leftMargin;
			this.fieldPadding = fieldPadding;
			
			this.viewCanvas = canvasFactory.createCanvas();
			
			this.titleTextField = this.createTextField( "HIGH SCORES", titleTextFormat, TextFieldAutoSize.CENTER );
			this.titleTextField.x = (playAreaWidth / 2)	- (titleTextField.width / 2);
			this.viewCanvas.addChild( this.titleTextField );
			
			this.continueButton = new Button( canvasFactory, "Continue" ,  continueClickHandler, buttonTextFormat, "highscores-continue");
			this.continueButton.setY(playAreaHeight / 8 * 7);
			this.continueButton.centerXPosition(playAreaWidth / 2);
			
			this.viewCanvas.addCanvas( this.continueButton.getCanvas() );
		}
		
		public function getCanvas():ICanvas
		{
			return this.viewCanvas;
		}
		
		public function showScores( highscorePresentations:Array ):void
		{
			var tallestFieldHeight:Number = 0;
			var startHeight:Number = playAreaHeight / 6;
			var nameFieldStartPoint:Point = new Point(leftMargin, startHeight );
			var scoreFieldStartPoint:Point = new Point( (playAreaWidth / 2) + leftMargin, startHeight );
			
			for ( var highscorePresentationIndex:int = 0; highscorePresentationIndex < highscorePresentations.length; highscorePresentationIndex++ )
			{
				var highscorePresentation:IHighscorePresentation = highscorePresentations[highscorePresentationIndex];
				
				var nameTextField:TextField = this.createTextField( highscorePresentation.getName(), nameTextFormat, TextFieldAutoSize.RIGHT );
				
				nameTextField.x = nameFieldStartPoint.x;
				nameTextField.y = nameFieldStartPoint.y;
				nameTextField.width = (playAreaWidth / 2) - (leftMargin * 2);
				
				this.viewCanvas.addChild( nameTextField );
				
				var scoreTextField:TextField = this.createTextField( highscorePresentation.getScore(), nameTextFormat, TextFieldAutoSize.CENTER );
				
				scoreTextField.x = scoreFieldStartPoint.x;
				scoreTextField.y = scoreFieldStartPoint.y;
				scoreTextField.width = (playAreaWidth / 2) - (leftMargin * 2);
				
				this.viewCanvas.addChild( scoreTextField );

				tallestFieldHeight = nameTextField.height;
				
				if ( scoreTextField.height > nameTextField.height )
					tallestFieldHeight = scoreTextField.height;
					
				nameFieldStartPoint.y += tallestFieldHeight + fieldPadding;
				scoreFieldStartPoint.y += tallestFieldHeight + fieldPadding;				
			}
		}

		private function createTextField( text:String, textFormat:TextFormat, autoSize:String ):TextField
		{
			var newTextField:TextField = new TextField();
			
			newTextField.selectable = false;
			newTextField.embedFonts = true;
			newTextField.autoSize = autoSize;
			newTextField.type = TextFieldType.DYNAMIC;
			newTextField.text = text;
			newTextField.setTextFormat( textFormat );
			
			return newTextField;
		}
		
	}
	
}