package impl.common.domain.city 
{
	import flash.geom.Point;
	import iface.common.domain.city.ICity;
	import iface.common.domain.city.ICityDestroyedListener;
	import iface.common.domain.city.ICityListener;
	import iface.common.domain.projectile.IProjectile;
	import iface.common.domain.projectile.IProjectileFactory;
	import iface.common.domain.projectile.IProjectilePositioner;
	import iface.common.domain.projectile.ITarget;
	
	/**
	 * ...
	 * @author ...
	 */
	public class City implements IProjectilePositioner, ICity
	{
		private var heights:Array = null;
		private var maxHeight:int = 0;
		private var citySegments:Array = new Array();
		private var cityListeners:Array = new Array();
		private var cityDestroyedListeners:Array = new Array();		
		private var cityYOffset:int = 0;
		private var projectileFactory:IProjectileFactory = null;
		
		public function City( length:int, cityYOffset:int, maxBuildingHeight:int, minBuildingWidth:int, maxBuildingWidth:int, projectileFactory:IProjectileFactory )
		{
			this.projectileFactory = projectileFactory;
			this.heights = new Array(length);
			this.citySegments.push( new CitySegment(0, length - 1));
			this.cityYOffset = cityYOffset;
			this.initializeCity(cityYOffset, maxBuildingHeight, minBuildingWidth, maxBuildingWidth);
		}
		
		public function getHeights():Array
		{
			return this.heights;
		}
		
		public function getMaxHeight():int
		{
			return this.maxHeight;
		}
		
		public function collision( y:int, startX:int, endX:int ):Boolean
		{	
			if ( y >= this.maxHeight )
			{
				for ( var heightIndex:int = startX; heightIndex < endX; heightIndex++ )
				{
					if ( this.heights[heightIndex] <= y )
					{
						this.damage(startX, endX);
						return true;
					}
				}
			}
			
			return false;
		}
		
		public function repair():void
		{
			if ( this.citySegments.length > 1 )
			{
				var maxCitySegmentRepairIndex:int = this.citySegments.length - 1;
				var citySegmentToRepairIndex:int = Math.floor( Math.random() * maxCitySegmentRepairIndex );
				var numOfCitySegements:int = this.citySegments.length;
				var repairEndCitySegment:CitySegment = null;
				
				for ( var citySegmentIndex:int = 0; citySegmentIndex < numOfCitySegements; citySegmentIndex++ )
				{
					var repairStartCitySegment:CitySegment = this.citySegments.shift();
					
					if ( citySegmentIndex == citySegmentToRepairIndex )
					{
						repairEndCitySegment = this.citySegments.shift();
						//take the next one and link it back to this current one
						repairEndCitySegment.setStartX( repairStartCitySegment.getStartX() );
						this.citySegments.push( repairEndCitySegment );
					}
					else
					{
						this.citySegments.push( repairStartCitySegment );
					}
				}
				
				this.fireRepairedEvent( this.heights, repairEndCitySegment.getStartX(), repairEndCitySegment.getEndX() );
			}
		}
		
		public function damage( startX:int, endX:int ):void
		{
			var numOfCitySegements:int = this.citySegments.length;
			
			for ( var citySegmentIndex:int = 0; citySegmentIndex < numOfCitySegements; citySegmentIndex++ )
			{
				var curCitySegment:CitySegment = this.citySegments.shift();
				
				
				if ( (curCitySegment.getStartX() >= startX) && (curCitySegment.getEndX() <= endX) )
				{
					continue;
				}
				else if ( (curCitySegment.getStartX() < startX) && (curCitySegment.getEndX() > startX) && (curCitySegment.getEndX() <= endX) )
				{
					this.citySegments.push( new CitySegment( curCitySegment.getStartX(), startX ));
				}
				else if ( (curCitySegment.getStartX() >= startX) && (curCitySegment.getStartX() < endX) && (curCitySegment.getEndX() > endX) )
				{
					this.citySegments.push( new CitySegment( endX, curCitySegment.getEndX() ));
				}
				else if ( (curCitySegment.getStartX() < startX) && (curCitySegment.getEndX() > endX) )
				{
					this.citySegments.push( new CitySegment( curCitySegment.getStartX(), startX ));
					this.citySegments.push( new CitySegment( endX, curCitySegment.getEndX() ));
				}
				else
				{
					this.citySegments.push( curCitySegment );
				}
			}

			this.fireDamagedEvent( this.heights, startX, endX );
			
			if ( this.citySegments.length == 0 )
				this.fireCityDestroyedEvent();
		}
		
		public function fireProjectile( target:ITarget, targetAltitude:Number ):IProjectile
		{
			var newProjectile:IProjectile = this.projectileFactory.createProjectile( target, targetAltitude, this );
			
			this.fireProjectileFiredEvent(newProjectile);
			
			return newProjectile;
		}
		
		public function getAltitude( x:Number ):Number
		{
			var intX:int = x;
			
			if ( (intX > this.heights.length - 1) || (intX < 0) )
				return this.cityYOffset;
				
			return this.heights[intX];
		}
		
		public function addCityListener( cityListener:ICityListener ):void
		{
			this.cityListeners.push( cityListener );
		}

		public function addCityDestroyedListener( cityDestroyedListener:ICityDestroyedListener ):void
		{
			this.cityDestroyedListeners.push( cityDestroyedListener );
		}
		
		public function getVulnerableLocation():int
		{
			var randomSegmentIndex:int = Math.floor( Math.random() * this.citySegments.length );
			var segment:CitySegment = this.citySegments[randomSegmentIndex];
			
			return segment.getStartX() + ((segment.getEndX() - segment.getStartX()) / 2);
		}
		
		private function initializeCity(cityYOffset:int, maxBuildingHeight:int, minBuildingWidth:int, maxBuildingWidth:int):void
		{
			var heightIndex:int = 0
			
			while ( heightIndex < this.heights.length )
			{
				var buildingWidth:int = Math.floor(Math.random() * maxBuildingWidth);
				
				if ( buildingWidth < minBuildingWidth )
					buildingWidth = minBuildingWidth;

				var buildingEnd:int = heightIndex + buildingWidth;
				
				if ( buildingEnd > this.heights.length )
					buildingEnd = this.heights.length;
					
				var buildingHeight:int = cityYOffset - Math.floor(Math.random() * maxBuildingHeight);

				if ( buildingHeight < this.maxHeight )
					this.maxHeight = buildingHeight;

				for ( ; heightIndex < buildingEnd; heightIndex++ )
				{
					this.heights[heightIndex] = buildingHeight;
				}
			}
		}
		
		private function fireDamagedEvent( heights:Array, damageStart:int, damageEnd:int ):void
		{
			if ( this.cityListeners[0] != null )
				this.cityListeners[0].damaged( heights, damageStart, damageEnd );
		}
		
		private function fireRepairedEvent( heights:Array, repairStart:int, repairEnd:int ):void
		{
			if ( this.cityListeners[0] != null )
				this.cityListeners[0].repaired( heights, repairStart, repairEnd );
		}		
		
		private function fireCityDestroyedEvent():void
		{
			if ( this.cityDestroyedListeners[0] != null )
				this.cityDestroyedListeners[0].cityDestroyed();
		}
		
		private function fireProjectileFiredEvent( projectile:IProjectile ):void
		{
			if ( this.cityListeners[0] != null )
				this.cityListeners[0].projectileFired(projectile);			
		}
	}
	
}