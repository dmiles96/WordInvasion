package impl.client.presentation.city 
{
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import iface.client.presentation.city.ICityPresentation;
	import iface.client.presentation.city.ICityPresentationListener;
	import iface.client.presentation.projectile.IProjectilePresentation;
	import iface.client.presentation.projectile.IProjectilePresentationFactory;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.common.domain.city.ICity;
	import iface.common.domain.city.ICityListener;
	import flash.display.CapsStyle;
    import flash.display.LineScaleMode;
	import iface.common.domain.projectile.IProjectile;

	/**
	 * ...
	 * @author ...
	 */
	public class CityPresentation implements ICityListener, ICityPresentation
	{
		private static const CITY_COLOR:uint = 0xFFFFFF;
		private static const DESTROYED_CITY_COLOR:uint = 0x000000;

		private var cityOutline:Sprite = new Sprite();
		private var cityYOffset:int = 0;
		private var projectilePresentationFactory:IProjectilePresentationFactory = null;
		private var cityPresentationListeners:Array = new Array();
		private var projectileSound:IGameSound = null;
		
		public function CityPresentation( city:ICity, cityYOffset:int, projectilePresentationFactory:IProjectilePresentationFactory, projectileSound:IGameSound ) 
		{
			this.cityYOffset = cityYOffset;
			this.projectilePresentationFactory = projectilePresentationFactory;
			this.projectileSound = projectileSound;
			
			this.drawCityOutline(city, cityYOffset);
			
			city.addCityListener(this);
		}
		
		private function drawCityOutline(city:ICity, cityYOffset:int):void
		{
			var heights:Array = city.getHeights();
			
			drawHeights( city.getHeights(), 0, city.getHeights().length, CITY_COLOR );
		}
		
		private function drawHeights(heights:Array, startIndex:int, endIndex:int, color:uint):void
		{
			this.cityOutline.graphics.lineStyle(4, color, 1.00, false, LineScaleMode.NONE, CapsStyle.NONE);
			this.cityOutline.graphics.moveTo(startIndex, heights[startIndex] - cityYOffset);
			
			var prevHeight:int = heights[startIndex] - cityYOffset;
			var xPos:int = startIndex;
			
			for ( var heightIndex:int = startIndex; heightIndex < endIndex; heightIndex++ )
			{	
				var curHeight:int = heights[heightIndex];
				curHeight -= cityYOffset;
				
				if ( prevHeight != curHeight )
				{
					this.cityOutline.graphics.lineTo(xPos, prevHeight);
					this.cityOutline.graphics.lineTo(xPos, curHeight);
					
					prevHeight = curHeight;
				}

				xPos++;
			}
			
			this.cityOutline.graphics.lineTo(xPos, prevHeight);
		}
		
		public function damaged( heights:Array, damageStart:int, damageEnd:int ):void
		{
			this.drawHeights( heights, damageStart, damageEnd, DESTROYED_CITY_COLOR );
		}
		
		public function repaired( heights:Array, repairStart:int, repairEnd:int ):void
		{
			this.drawHeights( heights, repairStart, repairEnd, CITY_COLOR );
		}
		
		public function projectileFired( projectile:IProjectile ):void
		{
			var newProjectilePresentation:IProjectilePresentation = this.projectilePresentationFactory.createProjectilePresentation( projectile )
			
			this.fireProjectileFiredEvent( newProjectilePresentation );
			this.projectileSound.play();
		}
		
		public function addCityPresentationListener( cityPresentationListener:ICityPresentationListener ):void
		{
			cityPresentationListeners.push( cityPresentationListener );
		}
		
		private function fireProjectileFiredEvent( projectilePresentation:IProjectilePresentation ):void
		{
			if ( cityPresentationListeners[0] != null )
				cityPresentationListeners[0].projectileFired(projectilePresentation);
		}
		
		public function getDisplay():Sprite
		{
			return cityOutline;
		}
	}
	
}