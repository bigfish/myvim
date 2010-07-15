package <+PACKAGE+>
{
	import flexunit.framework.TestSuite;

	public class <+FILE NAME ROOT+>
	{
		public static function suite() : TestSuite
		{
			var testSuite : TestSuite = new TestSuite();
			testSuite.addTest( new TestSuite( <+CURSOR+> ) );
			return testSuite;
		}
	}
}
