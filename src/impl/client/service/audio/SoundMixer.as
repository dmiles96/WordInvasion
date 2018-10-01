package impl.client.service.audio 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import iface.client.service.audio.ISoundMixer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SoundMixer implements ISoundMixer, IPlayingSoundListener
	{
		private var playingSounds:Array = new Array();
		private var globalSoundTransform:SoundTransform = null;
		
		public function SoundMixer(globalSoundTransform:SoundTransform) 
		{
			this.globalSoundTransform = globalSoundTransform;
		}
		
		public function playSound( sound:Sound, startTime:Number = 0, loops:int = 0 ):SoundChannel
		{
			var soundChannel:SoundChannel = sound.play( startTime, loops, this.globalSoundTransform );
			var playingSound:PlayingSound = new PlayingSound( sound, soundChannel, startTime, loops );
			
			playingSound.addPlayingSoundListener( this );
			playingSounds.push( playingSound );
			
			return soundChannel;
		}
		
		public function stopAll():void
		{
			var numPlayingSounds:int = this.playingSounds.length;
			
			for ( var playingSoundIndex:int = 0; playingSoundIndex < numPlayingSounds; playingSoundIndex++  )
			{
				var playingSound:PlayingSound = this.playingSounds.shift();
				
				playingSound.stop();
			}
		}
		
		public function pauseAll():void
		{
			for each( var playingSound:PlayingSound in this.playingSounds )
			{
				playingSound.pause();
			}
		}		
		
		public function playAll():void
		{
			for each( var playingSound:PlayingSound in this.playingSounds )
			{
				playingSound.play();
			}
		}
		
		public function soundFinished( playingSound:PlayingSound ):void
		{
			this.playingSounds.splice( this.playingSounds.indexOf(playingSound), 1 );
		}
	
		public function increaseVolume( volumeDelta:Number = .1 ):Number
		{
			if ( this.globalSoundTransform.volume < 1 )
			{
				this.globalSoundTransform.volume += .1;
				
				if ( this.globalSoundTransform.volume  > 1 ) //just in case we get rounding errors
					this.globalSoundTransform.volume = 1;
			}
			
			return this.globalSoundTransform.volume;
		}
		
		public function decreaseVolume( volumeDelta:Number = -.1 ):Number
		{
			if ( this.globalSoundTransform.volume > 0 )
			{
				this.globalSoundTransform.volume -= .1;
				
				if ( this.globalSoundTransform.volume  < 0 ) //just in case we get rounding errors
					this.globalSoundTransform.volume = 0;
			}
			
			return this.globalSoundTransform.volume;
		}
		
		public function getVolume():Number
		{
			return this.globalSoundTransform.volume;
		}
	}
	
}