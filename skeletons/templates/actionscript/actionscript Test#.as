package <+PACKAGE+>
{
	import flexunit.framework.TestCase;

	public class <+FILE NAME ROOT+> extends TestCase
	{

		public function <+FILE NAME ROOT+>(methodName:String=null)
		{
			super(methodName);
		}

		override public function setUp() : void
		{
			<+CURSOR+>
		}

		override public function tearDown() : void
		{
			<++>
		}

		public function test<++>():void {

		}
	}
}
