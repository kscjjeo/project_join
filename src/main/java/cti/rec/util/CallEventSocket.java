package cti.rec.util;

import java.io.OutputStream;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import org.springframework.stereotype.Component;

@Component
public class CallEventSocket 
{
	
	
	private static final int RET_SUCCESS = 0;
	private static final int RET_SOCKET_ERROR = -2;
	private static final int RET_INVALID_PARAM = -3;
	
	private static final String charset = "euc-kr";
	private byte[] zeroByte = new byte[1596];
		
	private Socket socket = null;
	private OutputStream out = null;
	private ByteBuffer sendBuf = ByteBuffer.allocate(1596);
	private String r_ips ="";
	private int r_ports =0;
	
	public int connect(String r_ip,int r_port)
	{
		r_ips = r_ip;
		r_ports = r_port;
		try 
		{
			if(socket != null)
			{
				socket.close();
			}
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			for (StackTraceElement element : e.getStackTrace()) {
				System.out.println(element.toString());
			}
		}
		
		try 
		{
			socket = new Socket(r_ip, r_port);
			out = socket.getOutputStream();
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			for (StackTraceElement element : e.getStackTrace()) {
				System.out.println(element.toString());
			}
			return RET_SOCKET_ERROR;
		}
		return RET_SUCCESS;
		
	}
	
	public void disconnect()
	{
		try 
		{
			if(socket != null)
			{
				socket.close();
			}
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			for (StackTraceElement element : e.getStackTrace()) {
				System.out.println(element.toString());
			}
		}
		
	}
	
	public int startCall(int callId, String station, String agentId, String phoneNumber, String direction,
			String optional1, String optional2, String optional3, String optional4, String optional5,
			String optional6, String optional7, String optional8, String optional9, String optional10,
			String optional11, String optional12, String optional13, String optional14, String optional15,
			String optional16, String optional17, String optional18, String optional19, String optional20)
	{
		if(callId <= 0 || station.equals("") || station == null)
		{
			return RET_INVALID_PARAM;
		}
		
		try
		{
			sendBuf.clear();
			sendBuf.put(zeroByte);
			sendBuf.position(0);
			sendBuf.order(ByteOrder.LITTLE_ENDIAN);
			sendBuf.put(new byte[] {(byte)0x36, (byte)0x06, (byte)0x2E, (byte)0x2E, (byte)0x2E, (byte)0x2E});
			sendBuf.put(Command.COMMAND_INFO);
			sendBuf.put(Command.SubCommand.CALLSERVER_STARTCALL);
			
			sendBuf.position(CallEventIndex.callId);
			sendBuf.putInt(callId);
			
			if(agentId == null) agentId = "";
			if(phoneNumber == null) phoneNumber = "";
			if(direction == null) direction = "";
			if(optional1 == null) optional1 = "";
			if(optional2 == null) optional2 = "";
			if(optional3 == null) optional3 = "";
			if(optional4 == null) optional4 = "";
			if(optional5 == null) optional5 = "";
			if(optional6 == null) optional6 = "";
			if(optional7 == null) optional7 = "";
			if(optional8 == null) optional8 = "";
			if(optional9 == null) optional9 = "";
			if(optional10 == null) optional10 = "";
			if(optional11 == null) optional11 = "";
			if(optional12 == null) optional12 = "";
			if(optional13 == null) optional13 = "";
			if(optional14 == null) optional14 = "";
			if(optional15 == null) optional15 = "";
			if(optional16 == null) optional16 = "";
			if(optional17 == null) optional17 = "";
			if(optional18 == null) optional18 = "";
			if(optional19 == null) optional19 = "";
			if(optional20 == null) optional20 = "";
			
			setBuffer(sendBuf, agentId.getBytes(charset), CallEventIndex.agentId, CallEventSize.agentId);
			setBuffer(sendBuf, direction.getBytes(charset), CallEventIndex.direction, CallEventSize.direction);
			setBuffer(sendBuf, station.getBytes(charset), CallEventIndex.station, CallEventSize.station);
			setBuffer(sendBuf, phoneNumber.getBytes(charset), CallEventIndex.phoneNumber, CallEventSize.phoneNumber);
			setBuffer(sendBuf, optional1.getBytes(charset), CallEventIndex.optional1, CallEventSize.optional1);
			setBuffer(sendBuf, optional2.getBytes(charset), CallEventIndex.optional2, CallEventSize.optional2);
			setBuffer(sendBuf, optional3.getBytes(charset), CallEventIndex.optional3, CallEventSize.optional3);
			setBuffer(sendBuf, optional4.getBytes(charset), CallEventIndex.optional4, CallEventSize.optional4);
			setBuffer(sendBuf, optional5.getBytes(charset), CallEventIndex.optional5, CallEventSize.optional5);
			setBuffer(sendBuf, optional6.getBytes(charset), CallEventIndex.optional6, CallEventSize.optional6);
			setBuffer(sendBuf, optional7.getBytes(charset), CallEventIndex.optional7, CallEventSize.optional7);
			setBuffer(sendBuf, optional8.getBytes(charset), CallEventIndex.optional8, CallEventSize.optional8);
			setBuffer(sendBuf, optional9.getBytes(charset), CallEventIndex.optional9, CallEventSize.optional9);
			setBuffer(sendBuf, optional10.getBytes(charset), CallEventIndex.optional10, CallEventSize.optional10);
			setBuffer(sendBuf, optional11.getBytes(charset), CallEventIndex.optional11, CallEventSize.optional11);
			setBuffer(sendBuf, optional12.getBytes(charset), CallEventIndex.optional12, CallEventSize.optional12);
			setBuffer(sendBuf, optional13.getBytes(charset), CallEventIndex.optional13, CallEventSize.optional13);
			setBuffer(sendBuf, optional14.getBytes(charset), CallEventIndex.optional14, CallEventSize.optional14);
			setBuffer(sendBuf, optional15.getBytes(charset), CallEventIndex.optional15, CallEventSize.optional15);
			setBuffer(sendBuf, optional16.getBytes(charset), CallEventIndex.optional16, CallEventSize.optional16);
			setBuffer(sendBuf, optional17.getBytes(charset), CallEventIndex.optional17, CallEventSize.optional17);
			setBuffer(sendBuf, optional18.getBytes(charset), CallEventIndex.optional18, CallEventSize.optional18);
			setBuffer(sendBuf, optional19.getBytes(charset), CallEventIndex.optional19, CallEventSize.optional19);
			setBuffer(sendBuf, optional20.getBytes(charset), CallEventIndex.optional20, CallEventSize.optional20);
			
			out.write(sendBuf.array(), 0, 1596);
		}
		catch(Exception e)
		{
			if(connect(r_ips, r_ports) == RET_SUCCESS)
			{	
				try
				{
					sendBuf.clear();
					sendBuf.put(zeroByte);
					sendBuf.position(0);
					sendBuf.order(ByteOrder.LITTLE_ENDIAN);
					sendBuf.put(new byte[] {(byte)0x36, (byte)0x06, (byte)0x2E, (byte)0x2E, (byte)0x2E, (byte)0x2E});
					sendBuf.put(Command.COMMAND_INFO);
					sendBuf.put(Command.SubCommand.CALLSERVER_STARTCALL);
					
					sendBuf.position(CallEventIndex.callId);
					sendBuf.putInt(callId);
					
					if(agentId == null) agentId = "";
					if(phoneNumber == null) phoneNumber = "";
					if(direction == null) direction = "";
					if(optional1 == null) optional1 = "";
					if(optional2 == null) optional2 = "";
					if(optional3 == null) optional3 = "";
					if(optional4 == null) optional4 = "";
					if(optional5 == null) optional5 = "";
					if(optional6 == null) optional6 = "";
					if(optional7 == null) optional7 = "";
					if(optional8 == null) optional8 = "";
					if(optional9 == null) optional9 = "";
					if(optional10 == null) optional10 = "";
					if(optional11 == null) optional11 = "";
					if(optional12 == null) optional12 = "";
					if(optional13 == null) optional13 = "";
					if(optional14 == null) optional14 = "";
					if(optional15 == null) optional15 = "";
					if(optional16 == null) optional16 = "";
					if(optional17 == null) optional17 = "";
					if(optional18 == null) optional18 = "";
					if(optional19 == null) optional19 = "";
					if(optional20 == null) optional20 = "";
					
					setBuffer(sendBuf, agentId.getBytes(charset), CallEventIndex.agentId, CallEventSize.agentId);
					setBuffer(sendBuf, direction.getBytes(charset), CallEventIndex.direction, CallEventSize.direction);
					setBuffer(sendBuf, station.getBytes(charset), CallEventIndex.station, CallEventSize.station);
					setBuffer(sendBuf, phoneNumber.getBytes(charset), CallEventIndex.phoneNumber, CallEventSize.phoneNumber);
					setBuffer(sendBuf, optional1.getBytes(charset), CallEventIndex.optional1, CallEventSize.optional1);
					setBuffer(sendBuf, optional2.getBytes(charset), CallEventIndex.optional2, CallEventSize.optional2);
					setBuffer(sendBuf, optional3.getBytes(charset), CallEventIndex.optional3, CallEventSize.optional3);
					setBuffer(sendBuf, optional4.getBytes(charset), CallEventIndex.optional4, CallEventSize.optional4);
					setBuffer(sendBuf, optional5.getBytes(charset), CallEventIndex.optional5, CallEventSize.optional5);
					setBuffer(sendBuf, optional6.getBytes(charset), CallEventIndex.optional6, CallEventSize.optional6);
					setBuffer(sendBuf, optional7.getBytes(charset), CallEventIndex.optional7, CallEventSize.optional7);
					setBuffer(sendBuf, optional8.getBytes(charset), CallEventIndex.optional8, CallEventSize.optional8);
					setBuffer(sendBuf, optional9.getBytes(charset), CallEventIndex.optional9, CallEventSize.optional9);
					setBuffer(sendBuf, optional10.getBytes(charset), CallEventIndex.optional10, CallEventSize.optional10);
					setBuffer(sendBuf, optional11.getBytes(charset), CallEventIndex.optional11, CallEventSize.optional11);
					setBuffer(sendBuf, optional12.getBytes(charset), CallEventIndex.optional12, CallEventSize.optional12);
					setBuffer(sendBuf, optional13.getBytes(charset), CallEventIndex.optional13, CallEventSize.optional13);
					setBuffer(sendBuf, optional14.getBytes(charset), CallEventIndex.optional14, CallEventSize.optional14);
					setBuffer(sendBuf, optional15.getBytes(charset), CallEventIndex.optional15, CallEventSize.optional15);
					setBuffer(sendBuf, optional16.getBytes(charset), CallEventIndex.optional16, CallEventSize.optional16);
					setBuffer(sendBuf, optional17.getBytes(charset), CallEventIndex.optional17, CallEventSize.optional17);
					setBuffer(sendBuf, optional18.getBytes(charset), CallEventIndex.optional18, CallEventSize.optional18);
					setBuffer(sendBuf, optional19.getBytes(charset), CallEventIndex.optional19, CallEventSize.optional19);
					setBuffer(sendBuf, optional20.getBytes(charset), CallEventIndex.optional20, CallEventSize.optional20);
					
					out.write(sendBuf.array(), 0, 1596);
				}
				catch(Exception e2)
				{
					System.out.println(e2.toString());
					for (StackTraceElement element : e2.getStackTrace()) {
						System.out.println(element.toString());
					}
					return RET_SOCKET_ERROR;
				}
			}
			else
			{
				return RET_SOCKET_ERROR;
			}
		}
		return RET_SUCCESS;
	}
	
	
	public int endCall(int callId, String station, String agentId, String phoneNumber, String direction,
			String optional1, String optional2, String optional3, String optional4, String optional5,
			String optional6, String optional7, String optional8, String optional9, String optional10,
			String optional11, String optional12, String optional13, String optional14, String optional15,
			String optional16, String optional17, String optional18, String optional19, String optional20)
	{
		if(callId <= 0 || station.equals("") || station == null)
		{
			return RET_INVALID_PARAM;
		}
		
		try
		{
			sendBuf.clear();
			sendBuf.put(zeroByte);
			sendBuf.position(0);
			sendBuf.order(ByteOrder.LITTLE_ENDIAN);
			sendBuf.put(new byte[] {(byte)0x36, (byte)0x06, (byte)0x2E, (byte)0x2E, (byte)0x2E, (byte)0x2E});
			sendBuf.put(Command.COMMAND_INFO);
			sendBuf.put(Command.SubCommand.CALLSERVER_ENDCALL);
			
			sendBuf.position(CallEventIndex.callId);
			sendBuf.putInt(callId);
			
			if(agentId == null) agentId = "";
			if(phoneNumber == null) phoneNumber = "";
			if(direction == null) direction = "";
			if(optional1 == null) optional1 = "";
			if(optional2 == null) optional2 = "";
			if(optional3 == null) optional3 = "";
			if(optional4 == null) optional4 = "";
			if(optional5 == null) optional5 = "";
			if(optional6 == null) optional6 = "";
			if(optional7 == null) optional7 = "";
			if(optional8 == null) optional8 = "";
			if(optional9 == null) optional9 = "";
			if(optional10 == null) optional10 = "";
			if(optional11 == null) optional11 = "";
			if(optional12 == null) optional12 = "";
			if(optional13 == null) optional13 = "";
			if(optional14 == null) optional14 = "";
			if(optional15 == null) optional15 = "";
			if(optional16 == null) optional16 = "";
			if(optional17 == null) optional17 = "";
			if(optional18 == null) optional18 = "";
			if(optional19 == null) optional19 = "";
			if(optional20 == null) optional20 = "";
			
			setBuffer(sendBuf, agentId.getBytes(charset), CallEventIndex.agentId, CallEventSize.agentId);
			setBuffer(sendBuf, direction.getBytes(charset), CallEventIndex.direction, CallEventSize.direction);
			setBuffer(sendBuf, station.getBytes(charset), CallEventIndex.station, CallEventSize.station);
			setBuffer(sendBuf, phoneNumber.getBytes(charset), CallEventIndex.phoneNumber, CallEventSize.phoneNumber);
			setBuffer(sendBuf, optional1.getBytes(charset), CallEventIndex.optional1, CallEventSize.optional1);
			setBuffer(sendBuf, optional2.getBytes(charset), CallEventIndex.optional2, CallEventSize.optional2);
			setBuffer(sendBuf, optional3.getBytes(charset), CallEventIndex.optional3, CallEventSize.optional3);
			setBuffer(sendBuf, optional4.getBytes(charset), CallEventIndex.optional4, CallEventSize.optional4);
			setBuffer(sendBuf, optional5.getBytes(charset), CallEventIndex.optional5, CallEventSize.optional5);
			setBuffer(sendBuf, optional6.getBytes(charset), CallEventIndex.optional6, CallEventSize.optional6);
			setBuffer(sendBuf, optional7.getBytes(charset), CallEventIndex.optional7, CallEventSize.optional7);
			setBuffer(sendBuf, optional8.getBytes(charset), CallEventIndex.optional8, CallEventSize.optional8);
			setBuffer(sendBuf, optional9.getBytes(charset), CallEventIndex.optional9, CallEventSize.optional9);
			setBuffer(sendBuf, optional10.getBytes(charset), CallEventIndex.optional10, CallEventSize.optional10);
			setBuffer(sendBuf, optional11.getBytes(charset), CallEventIndex.optional11, CallEventSize.optional11);
			setBuffer(sendBuf, optional12.getBytes(charset), CallEventIndex.optional12, CallEventSize.optional12);
			setBuffer(sendBuf, optional13.getBytes(charset), CallEventIndex.optional13, CallEventSize.optional13);
			setBuffer(sendBuf, optional14.getBytes(charset), CallEventIndex.optional14, CallEventSize.optional14);
			setBuffer(sendBuf, optional15.getBytes(charset), CallEventIndex.optional15, CallEventSize.optional15);
			setBuffer(sendBuf, optional16.getBytes(charset), CallEventIndex.optional16, CallEventSize.optional16);
			setBuffer(sendBuf, optional17.getBytes(charset), CallEventIndex.optional17, CallEventSize.optional17);
			setBuffer(sendBuf, optional18.getBytes(charset), CallEventIndex.optional18, CallEventSize.optional18);
			setBuffer(sendBuf, optional19.getBytes(charset), CallEventIndex.optional19, CallEventSize.optional19);
			setBuffer(sendBuf, optional20.getBytes(charset), CallEventIndex.optional20, CallEventSize.optional20);
			
			out.write(sendBuf.array(), 0, 1596);
		}
		catch(Exception e)
		{
			if(connect(r_ips,r_ports) == RET_SUCCESS)
			{
				try
				{
					sendBuf.clear();
					sendBuf.put(zeroByte);
					sendBuf.position(0);
					sendBuf.order(ByteOrder.LITTLE_ENDIAN);
					sendBuf.put(new byte[] {(byte)0x36, (byte)0x06, (byte)0x2E, (byte)0x2E, (byte)0x2E, (byte)0x2E});
					sendBuf.put(Command.COMMAND_INFO);
					sendBuf.put(Command.SubCommand.CALLSERVER_ENDCALL);
					
					sendBuf.position(CallEventIndex.callId);
					sendBuf.putInt(callId);
					
					if(agentId == null) agentId = "";
					if(phoneNumber == null) phoneNumber = "";
					if(direction == null) direction = "";
					if(optional1 == null) optional1 = "";
					if(optional2 == null) optional2 = "";
					if(optional3 == null) optional3 = "";
					if(optional4 == null) optional4 = "";
					if(optional5 == null) optional5 = "";
					if(optional6 == null) optional6 = "";
					if(optional7 == null) optional7 = "";
					if(optional8 == null) optional8 = "";
					if(optional9 == null) optional9 = "";
					if(optional10 == null) optional10 = "";
					if(optional11 == null) optional11 = "";
					if(optional12 == null) optional12 = "";
					if(optional13 == null) optional13 = "";
					if(optional14 == null) optional14 = "";
					if(optional15 == null) optional15 = "";
					if(optional16 == null) optional16 = "";
					if(optional17 == null) optional17 = "";
					if(optional18 == null) optional18 = "";
					if(optional19 == null) optional19 = "";
					if(optional20 == null) optional20 = "";
					
					setBuffer(sendBuf, agentId.getBytes(charset), CallEventIndex.agentId, CallEventSize.agentId);
					setBuffer(sendBuf, direction.getBytes(charset), CallEventIndex.direction, CallEventSize.direction);
					setBuffer(sendBuf, station.getBytes(charset), CallEventIndex.station, CallEventSize.station);
					setBuffer(sendBuf, phoneNumber.getBytes(charset), CallEventIndex.phoneNumber, CallEventSize.phoneNumber);
					setBuffer(sendBuf, optional1.getBytes(charset), CallEventIndex.optional1, CallEventSize.optional1);
					setBuffer(sendBuf, optional2.getBytes(charset), CallEventIndex.optional2, CallEventSize.optional2);
					setBuffer(sendBuf, optional3.getBytes(charset), CallEventIndex.optional3, CallEventSize.optional3);
					setBuffer(sendBuf, optional4.getBytes(charset), CallEventIndex.optional4, CallEventSize.optional4);
					setBuffer(sendBuf, optional5.getBytes(charset), CallEventIndex.optional5, CallEventSize.optional5);
					setBuffer(sendBuf, optional6.getBytes(charset), CallEventIndex.optional6, CallEventSize.optional6);
					setBuffer(sendBuf, optional7.getBytes(charset), CallEventIndex.optional7, CallEventSize.optional7);
					setBuffer(sendBuf, optional8.getBytes(charset), CallEventIndex.optional8, CallEventSize.optional8);
					setBuffer(sendBuf, optional9.getBytes(charset), CallEventIndex.optional9, CallEventSize.optional9);
					setBuffer(sendBuf, optional10.getBytes(charset), CallEventIndex.optional10, CallEventSize.optional10);
					setBuffer(sendBuf, optional11.getBytes(charset), CallEventIndex.optional11, CallEventSize.optional11);
					setBuffer(sendBuf, optional12.getBytes(charset), CallEventIndex.optional12, CallEventSize.optional12);
					setBuffer(sendBuf, optional13.getBytes(charset), CallEventIndex.optional13, CallEventSize.optional13);
					setBuffer(sendBuf, optional14.getBytes(charset), CallEventIndex.optional14, CallEventSize.optional14);
					setBuffer(sendBuf, optional15.getBytes(charset), CallEventIndex.optional15, CallEventSize.optional15);
					setBuffer(sendBuf, optional16.getBytes(charset), CallEventIndex.optional16, CallEventSize.optional16);
					setBuffer(sendBuf, optional17.getBytes(charset), CallEventIndex.optional17, CallEventSize.optional17);
					setBuffer(sendBuf, optional18.getBytes(charset), CallEventIndex.optional18, CallEventSize.optional18);
					setBuffer(sendBuf, optional19.getBytes(charset), CallEventIndex.optional19, CallEventSize.optional19);
					setBuffer(sendBuf, optional20.getBytes(charset), CallEventIndex.optional20, CallEventSize.optional20);
					
					out.write(sendBuf.array(), 0, 1596);
				}
				catch(Exception e2)
				{
					System.out.println(e2.toString());
					for (StackTraceElement element : e2.getStackTrace()) {
						System.out.println(element.toString());
					}
					return RET_SOCKET_ERROR;
				}
			}
			else
			{
				System.out.println("error:"+RET_SOCKET_ERROR);	
				return RET_SOCKET_ERROR;
			}
		}
		return RET_SUCCESS;
	}
	
	public void setBuffer(ByteBuffer buf, byte[] data, int position, int maxSize)
	{
		if(data != null)
		{
			buf.position(position);
			buf.put(data,0, (data.length>maxSize)?maxSize:data.length);
		}
	}
}
