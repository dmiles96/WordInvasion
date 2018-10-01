package impl.client.view 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import iface.client.view.IView;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.IClickHandler;
	import impl.client.view.components.Button;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameMenuView implements IView
	{
		private var viewCanvas:ICanvas;
		private var playButton:Button = null;
		private var buttonPadding:int = 20;
		private var titlePadding:int = 10;
		private var viewHighscoresButton:Button = null;
		private var titleMargin:int = 60;
		
		public function GameMenuView(canvasFactory:ICanvasFactory, playButtonClickHandler:IClickHandler, viewHighscoresButtonClickHandler:IClickHandler, textFormat:TextFormat, playAreaWidth:int, playAreaHeight:int, gameTitleTextFormat:TextFormat )
		{
			this.viewCanvas = canvasFactory.createCanvas();
			
			var gameTitleFirstLine:TextField = new TextField();
			var gameTitleSecondLine:TextField = new TextField();
			
			gameTitleFirstLine.selectable = false;
			gameTitleFirstLine.embedFonts = true;
			gameTitleFirstLine.autoSize = TextFieldAutoSize.CENTER;
			gameTitleFirstLine.type = TextFieldType.DYNAMIC;			
			gameTitleFirstLine.text = "Word";		
			gameTitleFirstLine.setTextFormat( gameTitleTextFormat );

			gameTitleSecondLine.selectable = false;
			gameTitleSecondLine.embedFonts = true;
			gameTitleSecondLine.autoSize = TextFieldAutoSize.CENTER;
			gameTitleSecondLine.type = TextFieldType.DYNAMIC;			
			gameTitleSecondLine.text = "Invaders";		
			gameTitleSecondLine.setTextFormat( gameTitleTextFormat );
			
			gameTitleFirstLine.x = (playAreaWidth / 2) - (gameTitleFirstLine.width / 2);
			gameTitleFirstLine.y = titleMargin;

			gameTitleSecondLine.x = (playAreaWidth / 2) - (gameTitleSecondLine.width / 2);
			gameTitleSecondLine.y = gameTitleFirstLine.y + gameTitleFirstLine.height + titlePadding;

			this.viewCanvas.addChild( gameTitleFirstLine );
			this.viewCanvas.addChild( gameTitleSecondLine );
			
			this.playButton = new Button( canvasFactory, "Play!", playButtonClickHandler, textFormat, "play");
			
			this.playButton.centerXPosition( playAreaWidth / 2 );
			this.playButton.setY( playAreaWidth / 2 + this.buttonPadding );
			
			this.viewCanvas.addCanvas( playButton.getCanvas() );
			
			this.viewHighscoresButton = new Button( canvasFactory, "View High Scores", viewHighscoresButtonClickHandler, textFormat, "highscores");
			
			this.viewHighscoresButton.centerXPosition( playAreaWidth / 2 );
			this.viewHighscoresButton.setY( playButton.getY() + playButton.getHeight() + this.buttonPadding );
			
			this.viewCanvas.addCanvas( viewHighscoresButton.getCanvas() );			
		}
		
		public function getCanvas():ICanvas
		{
			return this.viewCanvas;
		}
		
	}
	
}