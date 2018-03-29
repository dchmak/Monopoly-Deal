uses crt;
	
procedure MainMenu(init: boolean ; var outcome: byte);
var
	pointer : byte;
	done: boolean;
	ch: char;
begin
//	writeln(pointer);	writeln(outcome);	readln;
	done := false;
	repeat
		if init then
		begin
			init := false;
			pointer := 0;
			outcome := 0;
		end
		else
		begin
			repeat
				done := false;
				ch := ReadKey;
				If ord(ch)=0 then
					ch:=readkey; 
			until ord(ch) in [72,80];
				
			case ch of
				#72 : 	begin
							clrscr;	pointer := (pointer + 4) mod 5;
	//						writeln(pointer);
	//						writeln('up');
						end;
				#80 :	begin
							clrscr;	pointer := (pointer + 1) mod 5;
	//						writeln(pointer);
	//						writeln('down');
						end;
			end;
		end;
		
		writeln;
		writeln;
		writeln('                      |=======================================================|');
		writeln('                      |            ___          ___   ___   ___               |');	
		writeln('                      |   |\   /| |   | |\   | |   | |   | |   | |   \   /    |');
		writeln('                      |   | \ / | |   | | \  | |   | |___| |   | |    \ /     |');
		writeln('                      |   |  V  | |   | |  \ | |   | |     |   | |     V      |');
		writeln('                      |   |     | |   | |   \| |   | |     |   | |     |      |');
		writeln('                      |   |     | |___| |    | |___| |     |___| |___  |      |');
		writeln('                      |                  ___     ___  ___                     |');
		writeln('                      |                 |   |_  |    |   | |                  |');
		writeln('                      |                 |     | |___ |___| |                  |');
		writeln('                      |                 |     | |    |   | |                  |');
		writeln('                      |                 |    _| |    |   | |                  |');
		writeln('                      |                 |___|   |___ |   | |___               |');
		writeln('                      |                                                       |');
		writeln('                      |=======================================================|');
		writeln;
		
		case pointer of
		0: 	begin
				writeln('                   >  Single Player');
				writeln;
				writeln('                      Multi-Player(if possible)');
				writeln;
				writeln('                      Tutorial');
				writeln;
				writeln('                      Option');
				writeln;
				writeln('                      Exit');
			end;	
		1:	begin
				writeln('                      Single Player');
				writeln;
				writeln('                   >  Multi-Player(if possible)');
				writeln;
				writeln('                      Tutorial');
				writeln;
				writeln('                      Option');
				writeln;
				writeln('                      Exit');
			end;
		2:	begin
				writeln('                      Single Player');
				writeln;
				writeln('                      Multi-Player(if possible)');
				writeln;
				writeln('                   >  Tutorial');
				writeln;
				writeln('                      Option');
				writeln;
				writeln('                      Exit');
			end;
		3:	begin
				writeln('                      Single Player');
				writeln;
				writeln('                      Multi-Player(if possible)');
				writeln;
				writeln('                      Tutorial');
				writeln;
				writeln('                   >  Option');
				writeln;
				writeln('                      Exit');
			end;
		4:	begin
				writeln('                      Single Player');
				writeln;
				writeln('                      Multi-Player(if possible)');
				writeln;
				writeln('                      Tutorial');
				writeln;
				writeln('                      Option');
				writeln;
				writeln('                   >  Exit');
			end;
		end;
		writeln;
		writeln('Version Alpha 1.0.0                                                                        By Goggle');
		
		ch := ReadKey;
		if ch = #13 then
		begin		
			outcome := pointer;
			done := true;
		end;
			
	until done;
end;

var
	outcome: byte;	init: boolean;

begin
	repeat
		init := true;
		MainMenu(init,outcome);
		clrscr;
		case outcome of
			0:	begin 
					writeln('Update required for Single Player.');
					delay(1000);
					clrscr;
					init := true;
				end;
			1: 	begin 
					writeln('Update required for Multi-Player.');
					delay(1000);
					clrscr;
					init := true;
				end;
			2: 	begin 
					writeln('Update required for Tutorial.');
					delay(1000);
					clrscr;
					init := true;
				end;
			3: 	begin 
					writeln('Update required for Option.');
					delay(1000);
					clrscr;
					init := true;
				end;
			4:	begin 
					writeln('Bye.');
					delay(1000);
				end;
		end;
	until outcome = 4
end.
