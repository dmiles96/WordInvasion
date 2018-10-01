package impl.client.animation 
{
	import iface.client.animation.ITranslateAnimation;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TranslateAnimation extends Animation implements ITranslateAnimation
	{
		private var curFrameNum:int = 0;
		private var numFrames:int = 0;
		private var propertyName:String = null;
		private var curValue:int = 0;
		private var endValue:int = 0;
		private var valueDelta:int = 0;
		private var targetObject:Object = null;
		
		public function TranslateAnimation(	numFrames:int, 
									targetObject:Object, 
									propertyName:String ) 
		{
			this.numFrames = numFrames + 1; // + 1 is for the ending frame
			this.targetObject = targetObject;
			this.propertyName = propertyName;
		}
		
		public function updateValues( curValue:int, endValue:int ):void
		{
			this.curValue = curValue;
			this.endValue = endValue;
			this.valueDelta = (this.endValue - curValue) / this.numFrames;
			this.curFrameNum = 0;
		}
		
		public override function tick( tickDelta:int ):void
		{
			if ( this.curFrameNum < numFrames )
			{
				if ( this.curFrameNum == (numFrames - 1)) //if the last value
				{
					this.targetObject[this.propertyName] = this.endValue;
				}
				else
				{
					this.curValue += this.valueDelta;
					this.targetObject[this.propertyName] = curValue;
				}
				
				this.curFrameNum++;
			} 
		}
		
		public override function isDone():Boolean
		{
			return !(this.curFrameNum < numFrames);
		}
	}
	
}