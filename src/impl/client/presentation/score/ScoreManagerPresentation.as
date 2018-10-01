package impl.client.presentation.score 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	import iface.client.animation.IAnimationEngine;
	import iface.client.animation.IWaitAnimation;
	import iface.client.presentation.score.IScoreManagerPresentation;
	import iface.client.presentation.score.IScoreManagerPresentationListener;
	import iface.client.presentation.score.IScorePresentation;
	import iface.client.presentation.score.IScorePresentationFactory;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.common.domain.score.IScoreListener;
	import iface.common.domain.score.IScoreManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScoreManagerPresentation implements IScoreListener, IScoreManagerPresentation
	{
		private var scoreSprite:Sprite = new Sprite();
		private var scoreTextField:TextField = new TextField();
		private var scoreSpriteCanvas:ICanvas = null;
		private var scoreBonusMessage:String = null;
		private var ticksToShowScoreBonusMessage:int = 0;
		private var showingBonusMessage:Boolean = false;
		private var cachedScore:int = 0;
		private var animationEngine:IAnimationEngine = null;
		private var scoreBonusMessageAnimation:IWaitAnimation = null;
		private var standardTextFormat:TextFormat = null;
		private var scoreManagerPresentationListeners:Array = new Array();
		private var scorePresntation:IScorePresentation = null;
		
		public function ScoreManagerPresentation( animationEngine:IAnimationEngine, canvasFactory:ICanvasFactory, scoreManager:IScoreManager, scoreBonusMessage:String, ticksToShowScoreBonusMessage:int, standardTextFormat:TextFormat, scorePresentationFactory:IScorePresentationFactory) 
		{
			this.standardTextFormat = standardTextFormat;
			this.scoreBonusMessage = scoreBonusMessage;
			this.ticksToShowScoreBonusMessage = ticksToShowScoreBonusMessage;
			this.animationEngine = animationEngine;
			this.scorePresntation = scorePresentationFactory.createScorePresentation( scoreManager.getScore() );
			
			standardTextFormat.align = TextFormatAlign.CENTER;
			
			this.scoreTextField.selectable = false;
			this.scoreTextField.embedFonts = true;
			this.scoreTextField.autoSize = TextFieldAutoSize.CENTER;
			this.scoreTextField.type = TextFieldType.DYNAMIC;
			
			this.standardTextFormat.size = 32;
			this.displayScore( scorePresntation.getScore() );
			
			this.scoreSprite.addChild( this.scoreTextField );
			this.scoreSpriteCanvas = canvasFactory.createCanvasFromSprite(this.scoreSprite);
			
			this.scoreBonusMessageAnimation = this.animationEngine.createWaitAnimation(ticksToShowScoreBonusMessage, this, clearBonusMessage );
			
			scoreManager.addScoreListener(this);		
		}
		
		public function getCanvas():ICanvas
		{
			return this.scoreSpriteCanvas;
		}
		
		public function addScoreManagerPresentationListener( scoreManagerPresentationListener:IScoreManagerPresentationListener ):void
		{
			this.scoreManagerPresentationListeners.push( scoreManagerPresentationListener );
		}
		
		public function isShowingBonusMessage():Boolean
		{
			return this.showingBonusMessage;
		}
		
		public function clearBonusMessage():void
		{
			if ( this.isShowingBonusMessage() )
			{
				if ( !this.scoreBonusMessageAnimation.isDone() )
					this.scoreBonusMessageAnimation.cancel();
				
				this.updateScoreDisplay( this.cachedScore );
				this.showingBonusMessage = false;
			}
		}
		
		public function scoreChanged( newScore:int ):void
		{
			if ( this.showingBonusMessage )
				this.cachedScore = newScore;
			else
				this.updateScoreDisplay( newScore );

		}
		
		public function scoreRewarded():void
		{
			this.showingBonusMessage = true;
			this.displayScore( this.scoreBonusMessage );
			this.scoreBonusMessageAnimation.reset();
			this.animationEngine.runAnimation( this.scoreBonusMessageAnimation );
		}

		private function updateScoreDisplay( updatedScore:int ):void
		{
			this.scorePresntation.updateScore( updatedScore );
			
			this.displayScore( this.scorePresntation.getScore() );
		}

		private function displayScore( displayableScore:String ):void
		{
			this.scoreTextField.text = displayableScore;
			this.scoreTextField.setTextFormat( this.standardTextFormat );
			this.fireScoreDisplayChangedEvent();
		}
		
		private function fireScoreDisplayChangedEvent():void
		{
			if ( scoreManagerPresentationListeners[0] != null )
				scoreManagerPresentationListeners[0].scoreDisplayChanged(this.scoreSpriteCanvas);
		}
	}
	
}