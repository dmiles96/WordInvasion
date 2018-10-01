package impl.client.test 
{
	import asunit.framework.TestCase;

	/**
	 * ...
	 * @author ...
	 */
	public class SwapTest extends TestCase
	{
		
		public function SwapTest() 
		{
			
		}
		
		public function setUp():void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.quality = StageQuality.LOW;
			
			var canvasFactory:ICanvasFactory = new CanvasFactory(this);
			var applicationScopeFactory:ApplicationScopeFactory = new ApplicationScopeFactory(canvasFactory);
		
			applicationScope = applicationScopeFactory.createApplicationScope();
			applicationScope.getWorfklowEngine().executeStartGameWorkflow();
		}
	}
	
}