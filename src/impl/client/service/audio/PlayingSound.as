package impl.client.service.audio 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlayingSound 
	{
		private var soundChannel:SoundChannel = null;
		private var playingSoundListener:IPlayingSoundListener = null;
		private var pausedPosition:Number = 0;
		private var pausedSoundTransform:SoundTransform = null;
		private var sound:Sound = null;
		private var startTime:Number = 0;
		private var loops:int = 0;
		
		public function PlayingSound( sound:Sound, soundChannel:SoundChannel, startTime:Number = 0, loops:int = 0 ) 
		{
			this.soundChannel = soundChannel;
			this.sound = sound;
			this.startTime = startTime;
			this.loops = loops;
			
			this.soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
		}

		public function addPlayingSoundListener( playingSoundListener:IPlayingSoundListener ):void
		{
			this.playingSoundListener = playingSoundListener;
		}
		
		public function stop():void
		{
			if ( this.soundChannel != null )
			{
				this.soundChannel.stop();
				this.soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete );
				this.soundChannel = null;
			}
		}
		
		public function pause():void
		{
			this.pausedPosition = this.soundChannel.position;
			this.pausedSoundTransform = this.soundChannel.soundTransform;
			
			this.stop();
		}
		
		public function play():void
		{
			this.soundChannel = this.sound.play( this.startTime, this.loops, this.pausedSoundTransform );
			this.pausedPosition = 0;
			this.pausedSoundTransform = null;
		}
		
		private function soundComplete( event:Event ):void
		{
			this.playingSoundListener.soundFinished(this);
			this.soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
		}
	}
	
}