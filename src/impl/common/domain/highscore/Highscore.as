package impl.common.domain.highscore 
{
	import iface.common.domain.highscore.IHighscore;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Highscore implements IHighscore
	{
		private var name:String = null;
		private var score:int = 0;
		
		public function Highscore(name:String, score:int) 
		{
			this.name = name;
			this.score = score;
		}

		public function getName():String
		{
			return this.name;
		}

		public function getScore():int
		{
			return this.score;
		}	
		
		public function isLessThan( score:int ):Boolean
		{
			return this.score < score;
		}
	}
	
}