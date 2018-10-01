package iface.common.domain.enemy 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class CharacterExclusionMap 
	{
		private var charMap:Object = null;
		private var charArray:Array = new Array();
		
		public function CharacterExclusionMap() 
		{
			this.charMap = new Dictionary();
			
			this.charMap["a"] = false;
			this.charMap["b"] = false;
			this.charMap["c"] = false;
			this.charMap["d"] = false;
			this.charMap["e"] = false;
			this.charMap["f"] = false;
			this.charMap["g"] = false;
			this.charMap["h"] = false;
			this.charMap["i"] = false;
			this.charMap["j"] = false;
			this.charMap["k"] = false;
			this.charMap["l"] = false;
			this.charMap["m"] = false;
			this.charMap["n"] = false;
			this.charMap["o"] = false;
			this.charMap["p"] = false;
			this.charMap["q"] = false;
			this.charMap["r"] = false;
			this.charMap["s"] = false;
			this.charMap["t"] = false;
			this.charMap["u"] = false;
			this.charMap["v"] = false;
			this.charMap["w"] = false;
			this.charMap["x"] = false;
			this.charMap["y"] = false;
			this.charMap["z"] = false;
			this.charMap["A"] = false;
			this.charMap["B"] = false;
			this.charMap["C"] = false;
			this.charMap["D"] = false;
			this.charMap["E"] = false;
			this.charMap["F"] = false;
			this.charMap["G"] = false;
			this.charMap["H"] = false;
			this.charMap["I"] = false;
			this.charMap["J"] = false;
			this.charMap["K"] = false;
			this.charMap["L"] = false;
			this.charMap["M"] = false;
			this.charMap["N"] = false;
			this.charMap["O"] = false;
			this.charMap["P"] = false;
			this.charMap["Q"] = false;
			this.charMap["R"] = false;
			this.charMap["S"] = false;
			this.charMap["T"] = false;
			this.charMap["U"] = false;
			this.charMap["V"] = false;
			this.charMap["W"] = false;
			this.charMap["X"] = false;
			this.charMap["Y"] = false;
			this.charMap["Z"] = false;
			
			for ( var curChar:String in charMap )
			{
				this.charArray.push( curChar );
			}
			
			this.resortCharacters();
		}

		public function isExcluded( excludedChar:String ):Boolean
		{
			return this.charMap[excludedChar];
		}
		
		public function excludeChar( excludedChar:String ):void
		{
			this.charMap[excludedChar] = true;
		}
		
		public function includeChar( includedChar:String ):void
		{
			this.charMap[includedChar] = false;
		}
		
		public function randomAvailableChar():String
		{
			var chosenChar:String = null;
			var numChars:int = this.charArray.length;
			
			for ( var charIndex:int = 0; charIndex < numChars; charIndex++ )
			{
				var curChar:String = this.charArray.shift();
				
				if ( !this.isExcluded(curChar) )
				{
					chosenChar = curChar;
				}
				
				this.charArray.push(curChar);
				
				if ( chosenChar != null )
					break;
			}
			
			return chosenChar;
		}
		
		public function resortCharacters():void
		{
			var chance:Number = .1;
			
			do
			{
				this.randomizeCharacters( chance );
				chance += .1;
			}
			while ( chance < 1 );			
		}
		
		private function randomizeCharacters(chance:Number):void
		{
			var shouldChooseThisChar:Number = 0;
			var tempChar:String = null;
			
			for ( var charIndex:int = 1; charIndex < this.charArray.length; charIndex++ )
			{
				shouldChooseThisChar = Math.random();
				
				if ( shouldChooseThisChar > chance )
				{
					tempChar = this.charArray[charIndex];
					this.charArray[charIndex] = this.charArray[0];
					this.charArray[0] = tempChar;
				}
			}
		}
	}
}