package cti.rec.util;

public class Command 
{
	public static final byte COMMAND_INFO = 0x07;
	
	public class SubCommand 
	{
		public static final byte CALLSERVER_STARTCALL = 0x10;
		public static final byte CALLSERVER_ENDCALL = 0x11;
	}
}
