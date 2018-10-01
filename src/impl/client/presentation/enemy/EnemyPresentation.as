package impl.client.presentation.enemy
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.utils.Dictionary;
	import iface.client.animation.IAnimation;
	import iface.client.animation.IAnimationEngine;	
	import iface.client.animation.IIndefiniteAnimation;
	import iface.client.presentation.enemy.IEnemyPresentation;
	import iface.client.presentation.enemy.IEnemyPresentationListener;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.common.domain.Dimension;
	import iface.common.domain.enemy.EnemyTypes;	
	import iface.common.domain.enemy.IBonusWord;
	import iface.common.domain.enemy.IDropLetterWordListener;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IEnemyListener;
	import iface.common.domain.enemy.IFallingEnemyListener;
	import iface.common.domain.enemy.IMissingLetterWordListener;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EnemyPresentation implements IFallingEnemyListener, IMissingLetterWordListener, IDropLetterWordListener, IEnemyListener, IEnemyPresentation
	{
		private var textCanvas:ICanvas = null;
		private	var sprite:Sprite = new Sprite();
		private var textField:TextField = new TextField();
		private var enemyPresentationListeners:Array = new Array();
		private var standardCharaterFormat:TextFormat = null;
		private var typedCharacterFormat:TextFormat = null;
		private var animationEngine:IAnimationEngine = null;
		private var explosionAnimation:IAnimation = null;
		private var exploded:Boolean = false;
		private var explosionSound:IGameSound = null;
		
		private var enemyType:int = 0; //once we have type specific ones, we don't need it		
		
		//falling enemy
		private var collisionSound:IGameSound = null;
		
		//hidden letter word specific
		private var hiddenCharacterMarker:String = null;
		private var reavlead:Boolean = false;
		
		//bomb specific
		private var bombSound:IGameSound = null;
		private var bombSoundChannel:SoundChannel = null;
		
		//bonus enemy specific
		private var bonusEnemySound:IGameSound = null;
		private var bonusEnemySoundChannel:SoundChannel = null;
		private var playAreaWidth:int = 0; 
		private var millisecondsPerTick:int = 0;
		private var flightTime:int = 0;
		
		//drop letter word specific
		private var blink:Boolean = true;
		private var chosenDropLetters:Dictionary = new Dictionary();
		private var readyToDropCharacterFormat:TextFormat = null;
		private var curLetterToDropIndex:int = 0;
		private var blinkLetterAnimation:IIndefiniteAnimation = null;
		
		public function EnemyPresentation(	canvasFactory:ICanvasFactory, enemy:IEnemy, 
											standardCharaterFormat:TextFormat, typedCharacterFormat:TextFormat, readyToDropCharacterFormat:TextFormat,
											animationEngine:IAnimationEngine, explosionSound:IGameSound, bombSound:IGameSound, bonusEnemySound:IGameSound,
											collisionSound:IGameSound, hiddenCharacterMarker:String)
		{
			this.standardCharaterFormat = standardCharaterFormat;
			this.typedCharacterFormat = typedCharacterFormat;
			this.readyToDropCharacterFormat = readyToDropCharacterFormat;
			this.animationEngine = animationEngine;
			this.explosionSound = explosionSound;
			this.bombSound = bombSound;
			this.bonusEnemySound = bonusEnemySound;
			this.collisionSound = collisionSound;
			this.hiddenCharacterMarker = hiddenCharacterMarker;
			
			this.enemyType = enemy.getType();
			
			if ( this.enemyType == EnemyTypes.BONUS_WORD_ENEMY_TYPE )
			{
				var bonusWordEnemy:IBonusWord = enemy as IBonusWord;
				
				this.flightTime = bonusWordEnemy.getMillisecondsTillOffScreen();
			}
			
			if ( this.enemyType == EnemyTypes.DROP_LETTER_WORD_ENEMY_TYPE )
			{
				this.blinkLetterAnimation = this.animationEngine.createIndefiniteFunctionAnimation(1, this, this.blinkChosenLetter);
				this.animationEngine.runAnimation( this.blinkLetterAnimation );
			}
			
			this.textField.selectable = false;
			this.textField.embedFonts = true;
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			this.textField.type = TextFieldType.DYNAMIC;
			this.textField.text = enemy.getData();
			this.textField.setTextFormat(this.standardCharaterFormat);
		
			this.sprite.addChild(textField);
			this.textCanvas = canvasFactory.createCanvasFromSprite(sprite);

			this.sprite.x = enemy.getX();
			this.sprite.y = enemy.getY();
			
			enemy.addEnemyListener(this);
		}
		
		public function move(valueDelta:int):void
		{
			this.sprite.y += valueDelta;
		}
		
		public function numMatchedCharsUpdated( characterEndIndex:int ):void
		{
			if ( characterEndIndex == 0 )
			{
				this.textField.setTextFormat( standardCharaterFormat );
				
				if ( !this.reavlead )
				{
					for ( var dropLetterIndex:Object in this.chosenDropLetters )
					{
						if ( this.chosenDropLetters[dropLetterIndex] == true )
						{
							this.letterToDropChosen( dropLetterIndex as int );
						}
					}
				}
				
				if( this.blinkLetterAnimation != null )
					this.blinkLetterAnimation.play();
			}
			else
			{
				if( this.blinkLetterAnimation != null )				
					this.blinkLetterAnimation.pause();
				
				this.textField.setTextFormat(standardCharaterFormat);
				this.textField.setTextFormat(typedCharacterFormat, 0, characterEndIndex);
			}
		}
		
		public function present( drawingSurface:ICanvas ):void
		{
			drawingSurface.addCanvas( this.getCanvas() );
			
			if ( this.enemyType == EnemyTypes.BOMB_ENEMY_TYPE )
			{
				this.bombSoundChannel = this.bombSound.play();
			}
			else if ( this.enemyType == EnemyTypes.BONUS_WORD_ENEMY_TYPE )
			{
				this.bonusEnemySoundChannel = this.bonusEnemySound.play(0, this.flightTime / bonusEnemySound.getLength());
			}
		}
		
		public function moved( x:int, y:int ):void
		{
			this.sprite.x = x;
			this.sprite.y = y;
		}
		
		public function enemyDied():void
		{
			if( this.explosionAnimation != null )
				this.explosionAnimation.cancel();

			if ( this.bombSoundChannel != null )
				this.bombSoundChannel.stop();
				
			if ( this.bonusEnemySoundChannel != null )
				this.bonusEnemySoundChannel.stop();
			
			if ( this.blinkLetterAnimation != null )
				this.blinkLetterAnimation.cancel();
				
			this.fireDeadEvent();
			
			if( !this.exploded )
				this.sprite.removeChild( this.textField );

			this.textCanvas = null;
			this.textField = null;
			this.sprite = null;
			this.enemyPresentationListeners = null;
			this.chosenDropLetters = null;
		}
		
		public function enemyExploding( enemy:IEnemy ):void
		{
			var explosionFrames:Array = new Array();
			
			explosionFrames.push( this.createExplosionFrame( true, enemy ));
			explosionFrames.push( this.createExplosionFrame( false, enemy ));
			explosionFrames.push( this.createExplosionFrame( true, enemy ));
			
			this.sprite.removeChild( this.textField );
			this.explosionAnimation = this.animationEngine.createDisplayObjectAnimation( this.textCanvas, explosionFrames, 10, true );
			this.animationEngine.runAnimation(this.explosionAnimation);
			this.exploded = true;
			this.explosionSound.play();
		}
		
		public function getCanvas():ICanvas
		{
			return this.textCanvas;
		}
		
		public function addEnemyPresentationListener( enemyPresentationListener:IEnemyPresentationListener ):void
		{
			enemyPresentationListeners.push(enemyPresentationListener );
		}
		
		public function letterToDropChosen( letterToDropIndex:int ):void
		{
			this.textField.setTextFormat(readyToDropCharacterFormat, letterToDropIndex, letterToDropIndex + 1);
			this.chosenDropLetters[letterToDropIndex] = true;
		}
		
		public function letterDropped( letterToDropIndex:int ):Dimension
		{
			var data:String = this.textField.text;
			
			if ( letterToDropIndex == 0 )
			{
				this.textField.text = hiddenCharacterMarker.concat( data.substring( letterToDropIndex + 1 ));
			}
			else
			{
				this.textField.text = data.substring( 0, letterToDropIndex ).concat( hiddenCharacterMarker ).concat( data.substring( letterToDropIndex + 1 ));
			}
			
			this.textField.setTextFormat(standardCharaterFormat);
			this.chosenDropLetters[letterToDropIndex] = false;
			
			return createDimensions();
		}

		public function missingLettersChosen( missingLetterIndexes:Array ):Dimension
		{
			var data:String = this.textField.text;
		
			for each( var missingLetterIndex:int in missingLetterIndexes)
			{
				if ( missingLetterIndex == 0)
				{
					data = hiddenCharacterMarker.concat( data.substring( missingLetterIndex + 1 ));
				}
				else
				{
					data = data.substring( 0, missingLetterIndex ).concat( hiddenCharacterMarker ).concat( data.substring( missingLetterIndex + 1 ));
				}
			}
			
			this.textField.text = data;
			this.textField.setTextFormat( this.standardCharaterFormat );
			
			return createDimensions();
		}
		
		public function revealAllHiddenLetters( data:String ):Dimension
		{
			this.textField.text = data;
			this.textField.setTextFormat( this.standardCharaterFormat );
			this.reavlead = true;
			
			if ( this.blinkLetterAnimation != null )
			{
				this.blinkLetterAnimation.cancel();
				this.blinkLetterAnimation = null;
			}
			
			return new Dimension( this.textField.textWidth, this.textField.textHeight );
		}
		
		public function collided():void
		{
			this.explosionSound = this.collisionSound;
		}
 
		public function revealMatchedLetter( matchedLetterIndex:int, machtedLetter:String ):void
		{
			var data:String = this.textField.text;
			
			this.textField.text = data.substring(0, matchedLetterIndex).concat(machtedLetter).concat(data.substring(matchedLetterIndex + 1));
			
			this.textField.setTextFormat(standardCharaterFormat);
			this.textField.setTextFormat(typedCharacterFormat, 0, matchedLetterIndex + 1);
		}
		
		
		private function blinkChosenLetter():void
		{
			for ( var dropLetterIndex:Object in this.chosenDropLetters )
			{
				if ( this.chosenDropLetters[dropLetterIndex] == true )
				{
					var letterToDropIndex:int = dropLetterIndex as int;
					
					if ( this.blink )
					{
						this.textField.setTextFormat(this.readyToDropCharacterFormat, letterToDropIndex, letterToDropIndex + 1);
						this.blink = false;
					}
					else
					{
						this.textField.setTextFormat(this.standardCharaterFormat, letterToDropIndex, letterToDropIndex + 1);
						this.blink = true;
					}
				}
			}
		}
		private function createDimensions():Dimension
		{
			return new Dimension( this.textField.textWidth, this.textField.textHeight );
		}
		
		private function createExplosionFrame(startDrawSquare:Boolean, enemy:IEnemy):Bitmap		
		{
			var explosionFrameData:BitmapData = new BitmapData(enemy.getWidth(), enemy.getHeight(), false, 0x000000 );
			var explosionParticleRows:int = 4;
			var explosionParticleCols:int = enemy.getData().length * 2;
			var explosionParticleRect:Rectangle = new Rectangle( 0, 0, enemy.getWidth() / explosionParticleCols, enemy.getHeight() / explosionParticleRows);
			var explosionFrame:Bitmap = new Bitmap( explosionFrameData );
			var startDrawSquare:Boolean = true;
			var shouldDrawSquare:Boolean = startDrawSquare;
			
			for ( var rowIndex:int = 0; rowIndex < explosionParticleRows; rowIndex++ )
			{
				for ( var colIndex:int = 0; colIndex < explosionParticleCols; colIndex++ )
				{
					if ( shouldDrawSquare )
					{
						if ( (rowIndex == 0) || (colIndex == 0) || (rowIndex == explosionParticleRows - 1) || (colIndex == explosionParticleCols - 1)) 
						{
							if ( Math.floor( Math.random() * 10 ) > 2 )
							{
								explosionFrameData.fillRect( explosionParticleRect, 0xFFFFFF );
							}
						}
						else
						{
							explosionFrameData.fillRect( explosionParticleRect, 0xFFFFFF );
						}
						
						shouldDrawSquare = false;
					}
					else
					{
						shouldDrawSquare = true;
					}

					explosionParticleRect.x += explosionParticleRect.width;
				}
				
				startDrawSquare = !startDrawSquare;
				shouldDrawSquare = startDrawSquare;
				explosionParticleRect.x = 0;
				explosionParticleRect.y += explosionParticleRect.height;
			}
			
			return explosionFrame;
		}
		
		private function fireDeadEvent():void
		{
			if ( enemyPresentationListeners[0] != null )
				enemyPresentationListeners[0].dead(this);
		}
	}
	
}